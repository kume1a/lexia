import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../util/color.dart';
import '../../values/app_theme_extension.dart';
import '../../values/assets.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.onChanged, required this.validator, this.controller});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: l.email,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: SvgPicture.asset(
            Assets.svgEmail,
            colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
            fit: BoxFit.scaleDown,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 24.r, minHeight: 24.r),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
