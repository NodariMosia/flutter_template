import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_l10n_en.dart';
import 'app_l10n_ka.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL10n
/// returned by `AppL10n.of(context)`.
///
/// Applications need to include `AppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL10n.localizationsDelegates,
///   supportedLocales: AppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppL10n.supportedLocales
/// property.
abstract class AppL10n {
  AppL10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL10n? of(BuildContext context) {
    return Localizations.of<AppL10n>(context, AppL10n);
  }

  static const LocalizationsDelegate<AppL10n> delegate = _AppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ka')];

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Template'**
  String get appTitle;

  /// No description provided for @byContinuingYouAcceptThe.
  ///
  /// In en, this message translates to:
  /// **'By continuing you accept the'**
  String get byContinuingYouAcceptThe;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @checkInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Check internet connection'**
  String get checkInternetConnection;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. janedoe@example.com'**
  String get emailExample;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordFormSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your account\'s email address.'**
  String get forgotPasswordFormSubtitle;

  /// No description provided for @georgian.
  ///
  /// In en, this message translates to:
  /// **'Georgian'**
  String get georgian;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// No description provided for @incorrectCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect current password'**
  String get incorrectCurrentPassword;

  /// No description provided for @incorrectEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get incorrectEmailOrPassword;

  /// No description provided for @incorrectVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect verification code'**
  String get incorrectVerificationCode;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @loginFormSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your account details to continue.'**
  String get loginFormSubtitle;

  /// No description provided for @loginFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginFormTitle;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get myAccount;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @newPasswordMustBeDifferent.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from the current one'**
  String get newPasswordMustBeDifferent;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get passwordUpdated;

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 555123456'**
  String get phoneNumberExample;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get pleaseEnter;

  /// No description provided for @pleaseEnterYour.
  ///
  /// In en, this message translates to:
  /// **'Please enter your'**
  String get pleaseEnterYour;

  /// No description provided for @pleaseRepeat.
  ///
  /// In en, this message translates to:
  /// **'Please repeat'**
  String get pleaseRepeat;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyInContext.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyInContext;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registrationFormSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get started by completing a quick registration form. Provide your details and kick off your journey with us!'**
  String get registrationFormSubtitle;

  /// No description provided for @registrationFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Register account'**
  String get registrationFormTitle;

  /// No description provided for @reportAProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get reportAProblem;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @resetPasswordFormSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set new password for your account.'**
  String get resetPasswordFormSubtitle;

  /// No description provided for @resetPasswordFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordFormTitle;

  /// No description provided for @serverIsUnderMaintenanceTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Server is under maintenance, Try again later.'**
  String get serverIsUnderMaintenanceTryAgainLater;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @termsOfUseInContext.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUseInContext;

  /// No description provided for @userDoesNotExist.
  ///
  /// In en, this message translates to:
  /// **'User does not exist'**
  String get userDoesNotExist;

  /// No description provided for @userWithMatchingCredentialsAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'User with matching credentials already exists'**
  String get userWithMatchingCredentialsAlreadyExists;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @verifyPasswordResetFormSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to your email address.'**
  String get verifyPasswordResetFormSubtitle;

  /// No description provided for @verifyPasswordResetFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get verifyPasswordResetFormTitle;
}

class _AppL10nDelegate extends LocalizationsDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(lookupAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ka'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppL10nDelegate old) => false;
}

AppL10n lookupAppL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppL10nEn();
    case 'ka':
      return AppL10nKa();
  }

  throw FlutterError('AppL10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
