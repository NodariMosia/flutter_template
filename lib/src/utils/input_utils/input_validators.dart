part of 'input_utils.dart';

/// Convenience type for input validator function.
/// Functions of this type should return `null` if the input [value] is valid,
/// otherwise they should return error text of type [String].
typedef InputValidator = String? Function(String? value);

abstract final class InputValidators {
  static AppL10n get _l10n => LocaleProvider.instance.l10n;

  // REGEXPS

  /// Valid verification code RegExp.
  ///
  /// Matches strings that include exactly 6 digits.
  static final RegExp verificationCodeRegExp = RegExp(r'^[0-9]{6}$');

  /// Valid password RegExp.
  ///
  /// Matches strings that:
  /// - Contain at least one **upper-case letter**;
  /// - Contain at least one **lower-case letter**;
  /// - Contain at least one **digit**;
  /// - Can contain following allowed symbols (in addition to letters and digits): **.!#$%&'*+-/=@?^_`{|}~**;
  /// - Are at least 8 characters long.
  static final RegExp passwordRegExp = RegExp(
    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])[A-Za-z0-9.!#$%&'*+-/=@?^_`{|}~]{8,}$",
  );

  // GENERAL VALIDATORS

  /// Returns [InputValidator] that wraps multiple [InputValidator]s.
  ///
  /// Note that [validators] list order is important as the first
  /// failed validator will return the appropriate error message.
  /// If non of the validators fail, this function returns `null`.
  static InputValidator compose(List<InputValidator> validators) {
    return (String? value) {
      for (final InputValidator validator in validators) {
        final String? errorText = validator(value);

        if (errorText != null) {
          return errorText;
        }
      }

      return null;
    };
  }

  /// Returns an [InputValidator] for required fields.
  ///
  /// If [errorText] is `null`, it defaults to `'Required'` (localized).
  static InputValidator required([String? errorText]) {
    return (String? value) {
      return value.isTruthy ? null : (errorText ?? _l10n.required);
    };
  }

  // SPECIFIC INPUT VALIDATORS (RETURNING ERROR TEXT OR NULL)

  /// Returns an [InputValidator] for email fields.
  ///
  /// If [errorText] is `null`, it defaults to `'Invalid Email Address'` (localized).
  static InputValidator validEmail([String? errorText]) {
    return (String? value) {
      return isValidEmail(value) ? null : (errorText ?? '${_l10n.invalid} ${_l10n.emailAddress}');
    };
  }

  /// Returns an [InputValidator] for password fields.
  ///
  /// If [errorText] is `null`, it defaults to `'Invalid Password'` (localized).
  static InputValidator validPassword([String? errorText]) {
    return (String? value) {
      return isValidPassword(value) ? null : (errorText ?? '${_l10n.invalid} ${_l10n.password}');
    };
  }

  /// Returns an [InputValidator] for verification code fields.
  ///
  /// If [errorText] is `null`, it defaults to `'Invalid Verification Code'` (localized).
  static InputValidator validVerificationCode([String? errorText]) {
    return (String? value) {
      return isValidVerificationCode(value)
          ? null
          : (errorText ?? '${_l10n.invalid} ${_l10n.verificationCode}');
    };
  }

  // SPECIFIC INPUT VALIDATORS (RETURNING BOOLEAN RESULT)

  static bool isValidEmail(String? value) {
    return value != null && EmailValidator.validate(value);
  }

  static bool isValidPassword(String? value) {
    return value != null && passwordRegExp.hasMatch(value);
  }

  static bool isValidVerificationCode(String? value) {
    return value != null && verificationCodeRegExp.hasMatch(value);
  }
}
