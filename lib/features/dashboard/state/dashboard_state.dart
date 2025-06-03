import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';

extension DashboardCubitX on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();
}

@injectable
class DashboardCubit extends Cubit<Unit> {
  DashboardCubit(this._pageNavigator) : super(unit);

  final PageNavigator _pageNavigator;

  void onProfilePressed() {
    _pageNavigator.toProfile();
  }
}
