import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../app/navigation/page_navigator.dart';
import '../authentication/api/auth_status_provider.dart';

part 'welcome_state.freezed.dart';

@freezed
class WelcomeState with _$WelcomeState {
  const factory WelcomeState({required SimpleDataState<bool> isAuthenticatedState}) = _WelcomeState;

  factory WelcomeState.initial() => WelcomeState(isAuthenticatedState: SimpleDataState.idle());
}

extension WelcomeCubitExtension on BuildContext {
  WelcomeCubit get welcomeCubit => read<WelcomeCubit>();
}

@injectable
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit(this._authStatusProvider, this._pageNavigator) : super(WelcomeState.initial()) {
    _init();
  }

  final AuthStatusProvider _authStatusProvider;
  final PageNavigator _pageNavigator;

  Future<void> _init() async {
    emit(state.copyWith(isAuthenticatedState: SimpleDataState.loading()));

    final isAuthenticated = await _authStatusProvider.get();

    emit(state.copyWith(isAuthenticatedState: SimpleDataState.success(isAuthenticated)));

    if (isAuthenticated) {
      _pageNavigator.toMain();
    }
  }

  void onNextButtonPressed() {
    _pageNavigator.toSignIn();
  }
}
