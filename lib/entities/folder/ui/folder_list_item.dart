import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/enum_intl.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/app_theme_extension.dart';
import '../../../shared/values/assets.dart';
import '../model/folder.dart';
import '../model/folder_type.dart';

class FolderListItem extends StatelessWidget {
  const FolderListItem({
    super.key,
    required this.folder,
    required this.onPressed,
    required this.onMenuPressed,
  });

  final Folder folder;
  final VoidCallback onPressed;
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.only(left: 12.w, right: 4.w, top: 12.h, bottom: 12.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(color: theme.colorScheme.secondary, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                folder.type == FolderType.folderCollection ? Assets.svgFolder : Assets.svgBook,
                width: 16.r,
                height: 16.r,
                fit: BoxFit.scaleDown,
                colorFilter: svgColor(theme.colorScheme.onSecondary),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(folder.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4.h),
                  if (folder.type != null)
                    Text(switch (folder.type!) {
                      FolderType.wordCollection =>
                        '${l.numberOfWords(folder.wordCount)} · ${folder.languageFrom?.translate(l)} > ${folder.languageTo?.translate(l)}',
                      FolderType.folderCollection => l.folder,
                    }, style: TextStyle(fontSize: 12, color: theme.appThemeExtension?.elSecondary)),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(onPressed: onMenuPressed, icon: Icon(Icons.more_vert)),
          ],
        ),
      ),
    );
  }
}
