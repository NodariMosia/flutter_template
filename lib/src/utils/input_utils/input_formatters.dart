part of 'input_utils.dart';

abstract final class InputFormatters {
  static final TextInputFormatter emailFormatter =
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.!#$%&'*+-/=@?^_`{|}~]"));

  static final TextInputFormatter passwordFormatter =
      FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9.!#$%&'*+-/=@?^_`{|}~]"));

  static final TextInputFormatter verificationCodeFormatter =
      FilteringTextInputFormatter.digitsOnly;
}
