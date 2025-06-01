import 'package:flutter/material.dart';

import '../../../app/intl/app_localizations.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.onChanged, required this.validator});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: l.email),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
