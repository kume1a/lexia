import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/assets.dart';
import '../state/main_page_state.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              icon: _SecondaryIcon(iconAssetName: Assets.svgHome),
              activeIcon: _PrimaryIcon(iconAssetName: Assets.svgHome),
              label: l.home,
            ),
            BottomNavigationBarItem(
              icon: _SecondaryIcon(iconAssetName: Assets.svgSearch),
              activeIcon: _PrimaryIcon(iconAssetName: Assets.svgSearch),
              label: l.search,
            ),
            BottomNavigationBarItem(
              icon: _SecondaryIcon(iconAssetName: Assets.svgFolder),
              activeIcon: _PrimaryIcon(iconAssetName: Assets.svgFolder),
              label: l.folders,
            ),
            BottomNavigationBarItem(
              icon: _SecondaryIcon(iconAssetName: Assets.svgDictionary),
              activeIcon: _PrimaryIcon(iconAssetName: Assets.svgDictionary),
              label: l.dictionary,
            ),
          ],
        );
      },
    );
  }
}

class _PrimaryIcon extends StatelessWidget {
  const _PrimaryIcon({required this.iconAssetName});

  final String iconAssetName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SvgPicture.asset(
      iconAssetName,
      width: 24,
      height: 24,
      colorFilter: svgColor(theme.colorScheme.onPrimaryContainer),
    );
  }
}

class _SecondaryIcon extends StatelessWidget {
  const _SecondaryIcon({required this.iconAssetName});

  final String iconAssetName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SvgPicture.asset(
      iconAssetName,
      width: 24,
      height: 24,
      colorFilter: svgColor(theme.colorScheme.onPrimaryContainer),
    );
  }
}
