import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../util/color.dart';
import '../../values/app_theme_extension.dart';
import '../../values/assets.dart';

class RepeatPasswordField extends HookWidget {
  const RepeatPasswordField({super.key, required this.onChanged, required this.validator, this.controller});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final isObscured = useState(true);

    return TextFormField(
      controller: controller,
      obscureText: isObscured.value,
      decoration: InputDecoration(
        hintText: l.repeatPassword,
        counterText: '',
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: SvgPicture.asset(
            Assets.svgLock,
            colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
            fit: BoxFit.scaleDown,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 24.r, minHeight: 24.r),
        suffixIconConstraints: BoxConstraints(minWidth: 24.r, minHeight: 24.r),
        suffixIcon: GestureDetector(
          onTap: () => isObscured.value = !isObscured.value,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: SvgPicture.asset(
              isObscured.value ? Assets.svgEye : Assets.svgEyeOff,
              width: 18.r,
              height: 18.r,
              fit: BoxFit.scaleDown,
              colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
            ),
          ),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
