import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/di/register_dependencies.dart';
import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/enum_intl.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/model/language.dart';
import '../../../shared/ui/dropdown_container_field.dart';
import '../../../shared/ui/loading_text_button.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/app_theme_extension.dart';
import '../../../shared/values/assets.dart';
import '../model/folder_type.dart';
import '../state/mutate_folder_state.dart';

class MutateFolderDialog extends StatelessWidget {
  const MutateFolderDialog({super.key, required this.folderId, required this.parentFolderId});

  final String? folderId;
  final String? parentFolderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MutateFolderCubit>()..init(folderId: folderId, parentFolderId: parentFolderId),
      child: _Content(folderId: folderId),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.folderId});

  final String? folderId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Dialog(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.r),
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
                    Text(folderId != null ? l.updateFolder : l.createFolder),
                    SizedBox(height: 16.h),
                    _FieldFolderName(),
                    SizedBox(height: 8.h),
                    if (folderId == null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: _FieldFolderType(),
                      ),
                    BlocBuilder<MutateFolderCubit, MutateFolderState>(
                      buildWhen: (previous, current) => previous.folderType != current.folderType,
                      builder: (_, state) {
                        return switch (state.folderType) {
                          FolderType.wordCollection => Column(
                            children: [
                              _FieldLanguageFrom(),
                              SizedBox(height: 8.h),
                              _FieldLanguageTo(),
                              SizedBox(height: 8.h),
                            ],
                          ),
                          FolderType.folderCollection => SizedBox.shrink(),
                        };
                      },
                    ),
                    SizedBox(height: 12.h),
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

class _FieldFolderName extends StatelessWidget {
  const _FieldFolderName();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    return TextFormField(
      controller: context.mutateFolderCubit.nameFieldController,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: l.folderName,
        prefixIconConstraints: BoxConstraints(minWidth: 24.r, minHeight: 24.r),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: SvgPicture.asset(
            Assets.svgEmail,
            colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      onChanged: context.mutateFolderCubit.onNameChanged,
      validator: (_) => context.mutateFolderCubit.state.folderName.errToString((err) => err.translate(l)),
    );
  }
}

class _FieldFolderType extends StatelessWidget {
  const _FieldFolderType();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<MutateFolderCubit, MutateFolderState>(
      buildWhen: (previous, current) => previous.folderType != current.folderType,
      builder: (_, state) {
        return DropdownFieldContainer<FolderType>(
          hintText: l.folderType,
          value: state.folderType,
          valueToString: (value) => value.translate(l),
          onPressed: context.mutateFolderCubit.onFolderTypePressed,
          iconAssetName: Assets.svgFolder,
        );
      },
    );
  }
}

class _FieldLanguageFrom extends StatelessWidget {
  const _FieldLanguageFrom();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<MutateFolderCubit, MutateFolderState>(
      buildWhen: (previous, current) => previous.languageFrom != current.languageFrom,
      builder: (_, state) {
        return DropdownFieldContainer<Language>(
          hintText: l.languageFrom,
          value: state.languageFrom,
          valueToString: (value) => value.translate(l),
          onPressed: context.mutateFolderCubit.onLanguageFromPressed,
          iconAssetName: Assets.svgLanguage,
        );
      },
    );
  }
}

class _FieldLanguageTo extends StatelessWidget {
  const _FieldLanguageTo();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<MutateFolderCubit, MutateFolderState>(
      buildWhen: (previous, current) => previous.languageTo != current.languageTo,
      builder: (_, state) {
        return DropdownFieldContainer<Language>(
          hintText: l.languageTo,
          value: state.languageTo,
          valueToString: (value) => value.translate(l),
          onPressed: context.mutateFolderCubit.onLanguageToPressed,
          iconAssetName: Assets.svgLanguage,
        );
      },
    );
  }
}
