import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../model/word_with_folder_path.dart';

class WordDuplicateDialog extends StatelessWidget {
  const WordDuplicateDialog({super.key, required this.duplicateWord});

  final WordWithFolderPath duplicateWord;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.duplicateWordMessage(duplicateWord.text), style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  duplicateWord.text,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4.h),
                Text(
                  duplicateWord.definition,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  l.location,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 2.h),
                Wrap(
                  children: duplicateWord.folderPath.map((folder) {
                    final isLast = folder == duplicateWord.folderPath.last;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          folder.name,
                          style: TextStyle(fontSize: 12.sp, color: theme.colorScheme.primary),
                        ),
                        if (!isLast) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right,
                            size: 12.sp,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          SizedBox(width: 4.w),
                        ],
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              l.duplicateWordQuestion,
              style: TextStyle(fontSize: 14.sp, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l.cancel)),
                ),
                SizedBox(width: 8.w),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                  child: Text(l.createAnyway),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
