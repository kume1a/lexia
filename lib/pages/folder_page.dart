import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../entities/folder/model/folder_type.dart';
import '../entities/folder/state/folder_state.dart';
import '../entities/folder/state/folder_subfolder_list_state.dart';
import '../entities/folder/ui/folder_children_list.dart';
import '../entities/word/state/folder_word_list_state.dart';

class FolderPageArgs {
  FolderPageArgs({required this.folderId});

  final String folderId;
}

class FolderPage extends StatelessWidget {
  const FolderPage({super.key, required this.args});

  final FolderPageArgs args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FolderCubit>()..init(folderId: args.folderId)),
        BlocProvider(create: (_) => getIt<FolderWordListCubit>()..init(folderId: args.folderId)),
        BlocProvider(create: (_) => getIt<FolderSubfolderListCubit>()..init(folderId: args.folderId)),
      ],
      child: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FolderCubit, FolderState>(
          builder: (_, state) {
            return state.maybeWhen(
              loading: () => Text('${l.loading}...'),
              success: (folder) => Text(folder.name),
              orElse: () => Text(l.folder),
            );
          },
        ),
        actions: [
          BlocBuilder<FolderCubit, FolderState>(
            builder: (_, state) {
              return state.maybeWhen(
                success: (folder) => IconButton(
                  onPressed: switch (folder.type) {
                    FolderType.wordCollection => context.folderWordListCubit.onSortPressed,
                    FolderType.folderCollection => context.folderSubfolderListCubit.onSortPressed,
                    null => null,
                  },
                  icon: const Icon(Icons.sort),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(child: FolderChildrenList()),
      floatingActionButton: BlocBuilder<FolderCubit, FolderState>(
        builder: (_, state) {
          return state.maybeWhen(
            orElse: () => SizedBox.shrink(),
            success: (folder) => FloatingActionButton.extended(
              onPressed: switch (folder.type) {
                FolderType.wordCollection => context.folderWordListCubit.onNewWordPressed,
                FolderType.folderCollection => context.folderSubfolderListCubit.onNewFolderPressed,
                null => null,
              },
              icon: const Icon(Icons.add),
              label: Text(switch (folder.type) {
                FolderType.wordCollection => l.newWord,
                FolderType.folderCollection => l.newFolder,
                null => '',
              }),
            ),
          );
        },
      ),
    );
  }
}
