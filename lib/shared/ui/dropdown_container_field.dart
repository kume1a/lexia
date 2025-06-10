import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../util/color.dart';
import '../values/app_theme_extension.dart';
import '../values/assets.dart';
import 'container_ink.dart';

class DropdownFieldContainer<T extends Object?> extends StatelessWidget {
  const DropdownFieldContainer({
    super.key,
    required this.hintText,
    required this.value,
    required this.valueToString,
    required this.onPressed,
    this.onClearPressed,
    this.iconAssetName,
  });

  final String hintText;
  final T? value;
  final String Function(T value) valueToString;
  final VoidCallback onPressed;
  final VoidCallback? onClearPressed;
  final String? iconAssetName;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 36,
        child: InputDecorator(
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minWidth: 24.r, minHeight: 24.r),
            prefixIcon: iconAssetName != null
                ? Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 5.w),
                    child: SvgPicture.asset(
                      iconAssetName!,
                      colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
                      width: 18.r,
                      height: 18.r,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                : null,
            suffixIcon: value != null && onClearPressed != null
                ? ContainerInk(
                    child: IconButton(
                      onPressed: onClearPressed,
                      splashRadius: 16,
                      icon: Icon(Icons.close, size: 18.r),
                    ),
                  )
                : SvgPicture.string(
                    Assets.svgChevronDown,
                    width: 18,
                    height: 18,
                    fit: BoxFit.scaleDown,
                    colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
                  ),
          ),
          child: value != null
              ? Text(valueToString(value as T))
              : Text(hintText, style: TextStyle(color: theme.appThemeExtension?.elSecondary)),
        ),
      ),
    );
  }
}
