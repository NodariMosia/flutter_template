import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/app_bar/main_app_bar.dart';
import 'package:flutter_template/src/common_widgets/button/locale_button.dart';
import 'package:flutter_template/src/common_widgets/button/main_action_button.dart';
import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/features/auth/login_page.dart';
import 'package:flutter_template/src/features/auth/register_page.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

class AuthOverviewPage extends StatefulWidget {
  const AuthOverviewPage({super.key});

  @override
  State<AuthOverviewPage> createState() => _AuthOverviewPageState();
}

class _AuthOverviewPageState extends State<AuthOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        isTransparent: true,
        actions: [LocaleButton()],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: context.mediaQuery.padding.top),
              decoration: BoxDecoration(
                color: context.colorScheme.tertiary,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Gaps.h24,
                  Image.asset(
                    'assets/images/icon.png',
                    width: math.min(196, context.screenHeight * 0.24),
                    height: math.min(196, context.screenHeight * 0.24),
                    color: context.colorScheme.tertiary,
                    colorBlendMode: BlendMode.modulate,
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    'FLUTTER\nTEMPLATE\nAPPLICATION',
                    style: context.screenHeight > 740
                        ? context.textTheme.displayLarge
                        : context.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Expanded(child: SizedBox()),
                  if (context.screenHeight > 740) Gaps.h24,
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainActionButton(
                    onPressed: () => context.push(const LoginPage()),
                    text: context.l10n.logIn,
                  ),
                  Gaps.h24,
                  Text(
                    context.l10n.dontHaveAnAccount,
                    style: context.textTheme.bodyMedium,
                  ),
                  Gaps.h8,
                  OutlinedButton(
                    onPressed: () => context.push(const RegisterPage()),
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size.fromHeight(52),
                      side: BorderSide(color: context.colorScheme.tertiary),
                      foregroundColor: context.colorScheme.tertiary,
                    ),
                    child: Text(
                      context.l10n.createAccount,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  Gaps.h32,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.textTheme.bodySmall,
                      children: [
                        TextSpan(text: '${context.l10n.byContinuingYouAcceptThe} '),
                        TextSpan(
                          text: context.l10n.termsOfUseInContext,
                          style: TextStyle(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () => context.push(const TermsOfUsePage()),
                        ),
                        TextSpan(text: '\n${context.l10n.and} '),
                        TextSpan(
                          text: context.l10n.privacyPolicyInContext,
                          style: TextStyle(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () => context.push(const PrivacyPolicyPage()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
