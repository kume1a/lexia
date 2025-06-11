import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../entities/folder/state/folder_state.dart';
import '../entities/word/state/folder_word_list_state.dart';
import '../entities/word/ui/folder_word_list.dart';

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
              loading: () => const Text('Loading...'),
              success: (folder) => Text(folder.name),
              orElse: () => const Text('Folder'),
            );
          },
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(onRefresh: context.folderWordListCubit.onRefresh, child: FolderWordList()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: context.folderWordListCubit.onNewWordPressed,
        icon: const Icon(Icons.add),
        label: Text(l.addNewWord),
      ),
    );
  }
}
