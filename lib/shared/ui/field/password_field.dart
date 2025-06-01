import 'package:flutter/material.dart';

import '../../../app/intl/app_localizations.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.onChanged, required this.validator});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(hintText: l.password),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
