import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/small_circular_progress_indicator.dart';
import '../../folder/model/folder.dart';
import '../../folder/model/folder_type.dart';
import '../../folder/state/folder_state.dart';
import '../model/word.dart';
import '../state/folder_subfolder_list_state.dart';
import '../state/folder_word_list_state.dart';

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
              FolderType.wordCollection => const _WordList(),
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

class _WordList extends StatelessWidget {
  const _WordList();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<FolderWordListCubit, FolderWordListState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const Center(child: SmallCircularProgressIndicator()),
          failure: (error, _) => Center(child: Text(error.translate(l))),
          success: (words) {
            if (words.isEmpty) {
              return Center(
                child: Text(
                  l.noWordsYet,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: words.length,
              itemBuilder: (_, index) => _WordItem(word: words[index]),
            );
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
              itemBuilder: (_, index) => _SubfolderItem(subfolder: subfolders[index]),
            );
          },
        );
      },
    );
  }
}

class _SubfolderItem extends StatelessWidget {
  const _SubfolderItem({required this.subfolder});

  final Folder subfolder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subfolder.name),
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () => context.folderSubfolderListCubit.onFolderMenuPressed(subfolder),
      ),
    );
  }
}

class _WordItem extends StatelessWidget {
  const _WordItem({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: theme.colorScheme.primaryContainer,
      ),
      padding: EdgeInsets.only(left: 16.w, right: 8.w, top: 12.h, bottom: 12.h),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word.text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                SizedBox(height: 2.h),
                Text(word.definition),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () => context.folderWordListCubit.onWordMenuPressed(word),
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
