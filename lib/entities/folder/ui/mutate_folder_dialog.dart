import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/register_dependencies.dart';
import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/loading_text_button.dart';
import '../model/folder.dart';
import '../state/mutate_folder_state.dart';

class MutateFolderDialog extends StatelessWidget {
  const MutateFolderDialog({super.key, required this.folder});

  final Folder? folder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MutateFolderCubit>()..init(folder: folder),
      child: _Content(folder: folder),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.folder});

  final Folder? folder;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Dialog(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<MutateFolderCubit, MutateFolderState>(
            buildWhen: (previous, current) =>
                previous.validateForm != current.validateForm ||
                previous.isSubmitting != current.isSubmitting,
            builder: (_, state) {
              return ValidatedForm(
                showErrors: state.validateForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(folder != null ? l.updateFolder : l.createFolder),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: context.mutateFolderCubit.nameFieldController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: l.folderName,
                        fillColor: theme.colorScheme.secondaryContainer,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      onChanged: context.mutateFolderCubit.onNameChanged,
                      validator: (_) =>
                          context.mutateFolderCubit.state.folderName.errToString((err) => err.translate(l)),
                    ),
                    const SizedBox(height: 12),
                    LoadingTextButton(
                      isLoading: state.isSubmitting,
                      onPressed: context.mutateFolderCubit.onSubmit,
                      label: l.submit,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
