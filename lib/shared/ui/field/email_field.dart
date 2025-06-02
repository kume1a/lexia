import 'package:flutter/material.dart';

import '../../../app/intl/app_localizations.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.onChanged, required this.validator, this.controller});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: l.email),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
