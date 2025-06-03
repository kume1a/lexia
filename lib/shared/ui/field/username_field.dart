import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../util/color.dart';
import '../../values/app_theme_extension.dart';
import '../../values/assets.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key, required this.onChanged, required this.validator, this.controller});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: l.username,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 6.w),
          child: SvgPicture.asset(
            Assets.svgUser,
            colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
            fit: BoxFit.scaleDown,
            width: 24.r,
            height: 24.r,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 24.r, minHeight: 24.r),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
