import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../entities/folder/state/folder_list_state.dart';
import '../entities/folder/ui/folder_list.dart';

class FolderListPage extends StatelessWidget {
  const FolderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<FolderListCubit>(), child: _Content());
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.folders)),
      body: SafeArea(
        child: RefreshIndicator(onRefresh: context.folderListCubit.onRefresh, child: FolderList()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: context.folderListCubit.onCreateFolderPressed,
        icon: const Icon(Icons.add),
        label: Text(l.newFolder),
      ),
    );
  }
}
