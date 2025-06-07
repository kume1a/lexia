import 'package:flutter/material.dart';

class FolderPageArgs {
  FolderPageArgs({required this.folderId});

  final String folderId;
}

class FolderPage extends StatelessWidget {
  const FolderPage({super.key, required this.args});

  final FolderPageArgs args;

  @override
  Widget build(BuildContext context) {
    return _Content();
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
