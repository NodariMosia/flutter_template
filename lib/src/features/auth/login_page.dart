import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/app_bar/main_app_bar.dart';
import 'package:flutter_template/src/common_widgets/button/locale_button.dart';
import 'package:flutter_template/src/common_widgets/button/main_action_button.dart';
import 'package:flutter_template/src/common_widgets/flushbar/app_flushbar.dart';
import 'package:flutter_template/src/common_widgets/input/password_input.dart';
import 'package:flutter_template/src/common_widgets/listenable_builder/multi_value_listenable_builder.dart';
import 'package:flutter_template/src/common_widgets/outside_tap_unfocus_handler/outside_tap_unfocus_handler.dart';
import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/models/user/user.dart';
import 'package:flutter_template/src/providers/locale_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/services/api/api.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';
import 'package:flutter_template/src/utils/input_utils/input_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<String?> _emailError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _passwordError = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _isAwaitingResponse = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailError.dispose();
    _passwordError.dispose();
    _isAwaitingResponse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OutsideTapUnfocusHandler(
      child: Scaffold(
        appBar: MainAppBar(
          onBack: () => context.pop(),
          actions: const [LocaleButton()],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                children: [
                  Text(
                    context.l10n.loginFormTitle.toUpperCase(),
                    style: context.textTheme.displaySmall,
                  ),
                  Gaps.h8,
                  Text(
                    context.l10n.loginFormSubtitle,
                    style: context.textTheme.bodyLarge,
                  ),
                  Gaps.h16,
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        ValueListenableBuilder2(
                          valueListenable1: _isAwaitingResponse,
                          valueListenable2: _emailError,
                          builder: (_, isAwaitingResponse, emailError, __) => TextFormField(
                            controller: _emailController,
                            enabled: !isAwaitingResponse,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: context.l10n.email,
                              hintText: context.l10n.emailExample,
                              errorText: emailError,
                            ),
                            inputFormatters: [InputFormatters.emailFormatter],
                            validator: InputValidators.compose([
                              InputValidators.required(
                                '${context.l10n.pleaseEnterYour} ${context.l10n.emailAddress}',
                              ),
                              InputValidators.validEmail(),
                            ]),
                          ),
                        ),
                        Gaps.h16,
                        ValueListenableBuilder2(
                          valueListenable1: _isAwaitingResponse,
                          valueListenable2: _passwordError,
                          builder: (_, isAwaitingResponse, passwordError, __) => PasswordInput(
                            controller: _passwordController,
                            enabled: !isAwaitingResponse,
                            textInputAction: TextInputAction.done,
                            labelText: context.l10n.password,
                            hintText: context.l10n.password,
                            errorText: passwordError,
                            validator: InputValidators.compose([
                              InputValidators.required(
                                '${context.l10n.pleaseEnterYour} ${context.l10n.password}',
                              ),
                              InputValidators.validPassword(),
                            ]),
                            onSubmitted: (_) => _onSubmit(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.h8,
                  GestureDetector(
                    // onTap: () => context.push(const RequestPasswordResetPage()),
                    child: Text(
                      context.l10n.forgotPassword,
                      textAlign: TextAlign.end,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ValueListenableBuilder(
                  valueListenable: _isAwaitingResponse,
                  builder: (_, isAwaitingResponse, __) => MainActionButton(
                    onPressed: _onSubmit,
                    text: context.l10n.logIn,
                    shouldShowSpinner: isAwaitingResponse,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    _emailError.value = _passwordError.value = null;

    if (_isAwaitingResponse.value || !_formKey.currentState!.validate()) {
      return;
    }

    _isAwaitingResponse.value = true;

    try {
      // TODO: implement login

      const String sessionId = '12345';
      final User user = User(
        firstName: 'John',
        lastName: 'Doe',
        email: _emailController.text,
        phoneNumber: '1234567890',
        locale: LocaleProvider.instance.langCode,
      );

      if (mounted) {
        UserProvider.instance
          ..logIn(sessionId, user)
          ..navigateToLandingPage(context);
      }
    } catch (e) {
      log(e.toString(), error: e);

      final String message = e is UnauthorizedAccessException
          ? LocaleProvider.instance.l10n.incorrectEmailOrPassword
          : LocaleProvider.instance.l10n.somethingWentWrong;

      AppFlushbar.bottomError(message).showSnackbar();
      _emailError.value = _passwordError.value = message;
    } finally {
      _isAwaitingResponse.value = false;
    }
  }
}
