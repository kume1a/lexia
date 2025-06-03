import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../authentication/api/after_sign_out.dart';
import '../../authentication/api/auth_token_store.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({required ActionState<NetworkCallError> signOutState}) = _SettingsState;

  factory SettingsState.initial() => SettingsState(signOutState: ActionState.idle());
}

extension SettingsCubitX on BuildContext {
  SettingsCubit get settingsCubit => read<SettingsCubit>();
}

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._authTokenStore, this._afterSignOut) : super(SettingsState.initial());

  final AuthTokenStore _authTokenStore;
  final AfterSignOut _afterSignOut;

  Future<void> onSignOutPressed() async {
    emit(state.copyWith(signOutState: ActionState.executing()));

    await _authTokenStore.clear();

    emit(state.copyWith(signOutState: ActionState.executed()));

    _afterSignOut();
  }
}
