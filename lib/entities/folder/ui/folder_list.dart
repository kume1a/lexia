import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/ui/small_circular_progress_indicator.dart';
import '../state/folder_list_state.dart';
import 'folder_list_item.dart';

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
            return RefreshIndicator(
              onRefresh: context.folderListCubit.onRefresh,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final folder = data[index];

                  return FolderListItem(
                    folder: folder,
                    onPressed: () => context.folderListCubit.onFolderPressed(folder),
                    onMenuPressed: () => context.folderListCubit.onFolderMenuPressed(folder),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
