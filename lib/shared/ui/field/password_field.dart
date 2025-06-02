import 'package:flutter/material.dart';

import '../../../app/intl/app_localizations.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.onChanged, required this.validator, this.controller});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(hintText: l.password),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
