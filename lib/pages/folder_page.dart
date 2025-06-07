import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../entities/folder/state/folder_state.dart';

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
      providers: [BlocProvider(create: (_) => getIt<FolderCubit>()..init(folderId: args.folderId))],
      child: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Folder')),
      body: Center(
        child: Text(
          'Folder ID: ${context.findAncestorWidgetOfExactType<FolderPage>()?.args.folderId ?? 'Unknown'}',
        ),
      ),
    );
  }
}
