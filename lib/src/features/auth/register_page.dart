import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/app_bar/main_app_bar.dart';
import 'package:flutter_template/src/common_widgets/button/locale_button.dart';
import 'package:flutter_template/src/common_widgets/button/main_action_button.dart';
import 'package:flutter_template/src/common_widgets/flushbar/app_flushbar.dart';
import 'package:flutter_template/src/common_widgets/input/password_input.dart';
import 'package:flutter_template/src/common_widgets/input/phone_input.dart';
import 'package:flutter_template/src/common_widgets/outside_tap_unfocus_handler/outside_tap_unfocus_handler.dart';
import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/models/user/user.dart';
import 'package:flutter_template/src/providers/locale_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/services/api/api.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';
import 'package:flutter_template/src/utils/input_utils/input_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ScrollController _scrollController = ScrollController();
  late final AppBarFadeInOptions _appBarFadeInOptions =
      AppBarFadeInOptions(scrollController: _scrollController);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final PhoneController _phoneController =
      PhoneController(initialValue: const PhoneNumber(isoCode: IsoCode.GE, nsn: ''));

  final ValueNotifier<bool> _isAwaitingResponse = ValueNotifier(false);

  @override
  void dispose() {
    _scrollController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _isAwaitingResponse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OutsideTapUnfocusHandler(
      child: Scaffold(
        appBar: MainAppBar(
          onBack: () => context.pop(),
          title: context.l10n.register,
          actions: const [LocaleButton()],
          fadeInOptions: _appBarFadeInOptions,
        ),
        body: ListView(
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(16, 6, 16, context.mediaQuery.viewPadding.bottom + 16),
          children: [
            ListenableBuilder(
              listenable: _scrollController,
              builder: (_, Widget? child) => AnimatedOpacity(
                duration: Duration.zero,
                opacity: 1 -
                    _scrollController.offset.clamp(0, _appBarFadeInOptions.threshold) /
                        _appBarFadeInOptions.threshold,
                child: child,
              ),
              child: Text(
                context.l10n.registrationFormTitle.toUpperCase(),
                style: context.textTheme.displaySmall,
              ),
            ),
            Gaps.h4,
            Text(
              context.l10n.registrationFormSubtitle,
              style: context.textTheme.bodyLarge,
            ),
            Gaps.h20,
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ValueListenableBuilder(
                valueListenable: _isAwaitingResponse,
                builder: (_, isAwaitingResponse, __) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      enabled: !isAwaitingResponse,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: context.l10n.firstName,
                        hintText: context.l10n.firstName,
                      ),
                      validator: InputValidators.required(
                        '${context.l10n.pleaseEnterYour} ${context.l10n.firstName}',
                      ),
                    ),
                    Gaps.h16,
                    TextFormField(
                      controller: _lastNameController,
                      enabled: !isAwaitingResponse,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: context.l10n.lastName,
                        hintText: context.l10n.lastName,
                      ),
                      validator: InputValidators.required(
                        '${context.l10n.pleaseEnterYour} ${context.l10n.lastName}',
                      ),
                    ),
                    Gaps.h16,
                    TextFormField(
                      controller: _emailController,
                      enabled: !isAwaitingResponse,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: context.l10n.email,
                        hintText: context.l10n.emailExample,
                      ),
                      inputFormatters: [InputFormatters.emailFormatter],
                      validator: InputValidators.compose([
                        InputValidators.required(
                          '${context.l10n.pleaseEnterYour} ${context.l10n.emailAddress}',
                        ),
                        InputValidators.validEmail(),
                      ]),
                    ),
                    Gaps.h16,
                    PasswordInput(
                      controller: _passwordController,
                      enabled: !isAwaitingResponse,
                      labelText: context.l10n.password,
                      hintText: context.l10n.password,
                      textInputAction: TextInputAction.next,
                      validator: InputValidators.compose([
                        InputValidators.required(
                          '${context.l10n.pleaseEnter} ${context.l10n.newPassword}',
                        ),
                        InputValidators.validPassword(),
                      ]),
                    ),
                    Gaps.h16,
                    PasswordInput(
                      controller: _confirmPasswordController,
                      enabled: !isAwaitingResponse,
                      labelText: context.l10n.confirmNewPassword,
                      hintText: context.l10n.confirmNewPassword,
                      textInputAction: TextInputAction.next,
                      validator: InputValidators.compose([
                        InputValidators.required(
                          '${context.l10n.pleaseRepeat} ${context.l10n.newPassword}',
                        ),
                        InputValidators.validPassword(),
                        (String? value) => value != _passwordController.text
                            ? context.l10n.passwordsDoNotMatch
                            : null,
                      ]),
                    ),
                    Gaps.h16,
                    PhoneInput(
                      controller: _phoneController,
                      enabled: !isAwaitingResponse,
                      textInputAction: TextInputAction.next,
                      isRequired: true,
                    ),
                  ],
                ),
              ),
            ),
            Gaps.h16,
            ValueListenableBuilder(
              valueListenable: _isAwaitingResponse,
              builder: (_, isAwaitingResponse, __) => MainActionButton(
                onPressed: _onSubmit,
                text: context.l10n.register,
                shouldShowSpinner: isAwaitingResponse,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (_isAwaitingResponse.value || !_formKey.currentState!.validate()) {
      return;
    }

    _isAwaitingResponse.value = true;

    try {
      // TODO: implement registration

      const String sessionId = '12345';
      final User user = User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.value.nsn,
        locale: LocaleProvider.instance.langCode,
        password: _passwordController.text,
      );

      if (mounted) {
        UserProvider.instance
          ..logIn(sessionId, user)
          ..navigateToLandingPage(context);
      }
    } on ConflictException catch (e) {
      log(e.toString(), error: e);
      AppFlushbar.bottomError(LocaleProvider.instance.l10n.userWithMatchingCredentialsAlreadyExists)
          .showSnackbar();
    } catch (e) {
      log(e.toString(), error: e);
      AppFlushbar.bottomError(LocaleProvider.instance.l10n.somethingWentWrong).showSnackbar();
    } finally {
      _isAwaitingResponse.value = false;
    }
  }
}
