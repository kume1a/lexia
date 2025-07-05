import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/small_circular_progress_indicator.dart';
import '../../word/ui/folder_word_list.dart';
import '../model/folder_type.dart';
import '../state/folder_state.dart';
import '../state/folder_subfolder_list_state.dart';
import 'folder_list_item.dart';

class FolderChildrenList extends StatelessWidget {
  const FolderChildrenList({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<FolderCubit, FolderState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const Center(child: SmallCircularProgressIndicator()),
          failure: (error, _) => Center(child: Text(error.translate(l))),
          success: (folder) {
            return switch (folder.type) {
              FolderType.wordCollection => const FolderWordList(),
              FolderType.folderCollection => const _SubfolderList(),
              null => Text(
                l.folderTypeNotSupported,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            };
          },
        );
      },
    );
  }
}

class _SubfolderList extends StatelessWidget {
  const _SubfolderList();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<FolderSubfolderListCubit, FolderSubfolderListState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const Center(child: SmallCircularProgressIndicator()),
          failure: (error, _) => Center(child: Text(error.translate(l))),
          success: (subfolders) {
            if (subfolders.isEmpty) {
              return Center(
                child: Text(
                  l.noFoldersYet,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: subfolders.length,
              itemBuilder: (_, index) {
                final folder = subfolders[index];

                return FolderListItem(
                  folder: folder,
                  onMenuPressed: () => context.folderSubfolderListCubit.onFolderMenuPressed(folder),
                  onPressed: () => context.folderSubfolderListCubit.onFolderPressed(folder),
                );
              },
            );
          },
        );
      },
    );
  }
}
