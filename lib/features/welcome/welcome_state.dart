import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../app/navigation/page_navigator.dart';
import '../authentication/api/auth_status_provider.dart';

extension WelcomeCubitExtension on BuildContext {
  WelcomeCubit get welcomeCubit => read<WelcomeCubit>();
}

@injectable
class WelcomeCubit extends Cubit<Unit> {
  WelcomeCubit(this._authStatusProvider, this._pageNavigator) : super(unit) {
    _init();
  }

  final AuthStatusProvider _authStatusProvider;
  final PageNavigator _pageNavigator;

  Future<void> _init() async {
    final isAuthenticated = await _authStatusProvider.get();

    if (isAuthenticated) {
      _pageNavigator.toMain();
    }
  }

  void onNextButtonPressed() {
    _pageNavigator.toSignIn();
  }
}
