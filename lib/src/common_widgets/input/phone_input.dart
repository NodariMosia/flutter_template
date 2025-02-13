import 'package:flutter/material.dart';

import 'package:phone_form_field/phone_form_field.dart';

import 'package:flutter_template/src/utils/extensions/extensions.dart';

export 'package:phone_form_field/phone_form_field.dart' show PhoneController, PhoneNumber, IsoCode;

class PhoneInput extends StatelessWidget {
  final PhoneController controller;
  final bool enabled;
  final bool isCountrySelectionEnabled;
  final TextInputAction? textInputAction;

  /// If `null`, defaults to context.l10n.phoneNumber
  final String? labelText;

  /// If `null`, defaults to context.l10n.phoneNumberExample
  final String? hintText;

  final String? helperText;
  final String? errorText;
  final bool isRequired;

  const PhoneInput({
    required this.controller,
    this.enabled = true,
    this.isCountrySelectionEnabled = false,
    this.textInputAction,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.isRequired = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: controller,
      validator: PhoneValidator.compose([
        if (isRequired) PhoneValidator.required(context),
        PhoneValidator.validMobile(context),
      ]),
      enabled: enabled,
      textInputAction: textInputAction,
      isCountrySelectionEnabled: isCountrySelectionEnabled,
      isCountryButtonPersistent: isCountrySelectionEnabled,
      countryButtonStyle: CountryButtonStyle(
        showDropdownIcon: isCountrySelectionEnabled,
        showDialCode: true,
        showIsoCode: isCountrySelectionEnabled,
        showFlag: isCountrySelectionEnabled,
        flagSize: 16,
      ),
      countrySelectorNavigator: const CountrySelectorNavigator.draggableBottomSheet(
        favorites: [IsoCode.GE],
      ),
      decoration: InputDecoration(
        labelText: labelText ?? context.l10n.phoneNumber,
        hintText: hintText ?? context.l10n.phoneNumberExample,
        helperText: helperText,
        helperMaxLines: 3,
        errorText: errorText,
        errorMaxLines: 3,
      ),
    );
  }
}
