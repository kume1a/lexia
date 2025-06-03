import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/app_theme_extension.dart';
import '../../../shared/values/assets.dart';
import '../state/main_page_state.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    return BlocBuilder<MainPageCubit, MainPageState>(
      buildWhen: (previous, current) => previous.pageIndex != current.pageIndex,
      builder: (_, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: context.mainPageCubit.onPageChanged,
          currentIndex: state.pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svgHome,
                width: 24,
                height: 24,
                colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
              ),
              activeIcon: SvgPicture.asset(
                Assets.svgHome,
                width: 24,
                height: 24,
                colorFilter: svgColor(theme.colorScheme.onPrimaryContainer),
              ),
              label: l.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svgSearch,
                width: 24,
                height: 24,
                colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
              ),
              activeIcon: SvgPicture.asset(
                Assets.svgSearch,
                width: 24,
                height: 24,
                colorFilter: svgColor(theme.colorScheme.onPrimaryContainer),
              ),
              label: l.search,
            ),
          ],
        );
      },
    );
  }
}
