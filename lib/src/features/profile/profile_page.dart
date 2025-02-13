import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/app_bar/main_app_bar.dart';
import 'package:flutter_template/src/common_widgets/button/locale_button.dart';
import 'package:flutter_template/src/common_widgets/button/main_action_button.dart';
import 'package:flutter_template/src/common_widgets/input/selection_input.dart';
import 'package:flutter_template/src/common_widgets/progress_indicator/app_circular_progress_indicator.dart';
import 'package:flutter_template/src/constants/dropdown_options.dart';
import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/features/auth/auth_overview_page.dart';
import 'package:flutter_template/src/models/user/user.dart';
import 'package:flutter_template/src/providers/app_theme_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

part 'widgets/label_value_pair.dart';
part 'widgets/section_title.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<int?> _selectedThemeModeIndexNotifier = ValueNotifier<int?>(
    AppThemeProvider.instance.themeMode.index,
  );

  final ValueNotifier<bool> _isAwaitingResponse = ValueNotifier(true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (UserProvider.instance.user == null) {
        context.pushAndRemoveUntil(const AuthOverviewPage());
        return;
      }

      UserProvider.instance.refresh().then((_) {
        _isAwaitingResponse.value = false;
      });
    });
  }

  @override
  void dispose() {
    _selectedThemeModeIndexNotifier.dispose();
    _isAwaitingResponse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: context.l10n.profile,
        actions: const [LocaleButton()],
      ),
      body: ListenableBuilder(
        listenable: UserProvider.instance,
        builder: (BuildContext context, Widget? child) {
          final User? user = UserProvider.instance.user;

          if (user == null) {
            return const AppCircularProgressIndicator.topCenter();
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
            children: [
              _SectionTitle(context.l10n.myAccount),
              _LabelValuePair(context.l10n.firstName, user.firstName),
              _LabelValuePair(context.l10n.lastName, user.lastName),
              _LabelValuePair(context.l10n.email, user.email),
              _LabelValuePair(context.l10n.phoneNumber, user.phoneNumber),
              _SectionTitle(context.l10n.preferences),
              Gaps.h8,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPagePadding),
                child: SelectionInput(
                  options: DropdownOptions.themeModeOptions,
                  selectedIndexNotifier: _selectedThemeModeIndexNotifier,
                  labelText: context.l10n.appTheme,
                  onSubmit: _onThemeModeIndexValueChange,
                ),
              ),
              Gaps.h32,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPagePadding),
                child: MainActionButton(
                  text: context.l10n.logOut,
                  onPressed: () => UserProvider.instance
                    ..logOut()
                    ..navigateToLandingPage(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onThemeModeIndexValueChange(int index) {
    AppThemeProvider.instance.switchTheme(ThemeMode.values[index]);
  }
}
