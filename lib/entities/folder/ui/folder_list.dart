import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/enum_intl.dart';
import '../../../shared/ui/small_circular_progress_indicator.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/app_theme_extension.dart';
import '../../../shared/values/assets.dart';
import '../model/folder.dart';
import '../model/folder_type.dart';
import '../state/folder_list_state.dart';

class FolderList extends StatelessWidget {
  const FolderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderListCubit, FolderListState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => SizedBox.shrink(),
          loading: () => const Center(child: SmallCircularProgressIndicator()),
          success: (data) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: data.length,
              itemBuilder: (_, index) => _Item(folder: data[index]),
            );
          },
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.folder});

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () => context.folderListCubit.onFolderPressed(folder),
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
            IconButton(
              onPressed: () => context.folderListCubit.onFolderMenuPressed(folder),
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
