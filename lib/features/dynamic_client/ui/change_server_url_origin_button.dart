import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/util/color.dart';
import '../../../shared/values/assets.dart';
import '../state/change_server_url_origin_state.dart';

class ChangeServerUrlOriginButton extends StatelessWidget {
  const ChangeServerUrlOriginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: context.changeServerUrlOriginCubit.onChangeServerUrlOriginTilePressed,
      icon: SvgPicture.asset(
        Assets.svgServer,
        colorFilter: svgColor(theme.colorScheme.onSurface),
        width: 18,
        height: 18,
      ),
      splashRadius: 24,
    );
  }
}
