import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/small_circular_progress_indicator.dart';
import '../model/word.dart';
import '../state/folder_word_list_state.dart';

class FolderWordList extends StatelessWidget {
  const FolderWordList({super.key});

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
              itemBuilder: (_, index) => _Item(word: words[index]),
            );
          },
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.word});

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
