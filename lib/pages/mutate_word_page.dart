import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../entities/word/state/mutate_word_state.dart';
import '../entities/word/ui/mutate_word_form.dart';

class MutateWordPageArgs {
  const MutateWordPageArgs({required this.folderId, required this.wordId});

  final String folderId;
  final String? wordId;
}

class MutateWordPage extends StatelessWidget {
  const MutateWordPage({super.key, required this.args});

  final MutateWordPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MutateWordCubit>()..init(folderId: args.folderId, wordId: args.wordId),
      child: _Content(args: args),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.args});

  final MutateWordPageArgs args;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(args.wordId == null ? l.newWord : l.updateWord)),
      body: SafeArea(child: MutateWordForm()),
    );
  }
}
