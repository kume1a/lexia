import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../features/dynamic_client/state/change_server_url_origin_state.dart';
import '../features/settings/state/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SettingsCubit>()),
        BlocProvider(create: (_) => getIt<ChangeServerUrlOriginCubit>()),
      ],
      child: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.settings, style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: context.changeServerUrlOriginCubit.onChangeServerUrlOriginTilePressed,
                child: Text(l.changeServerUrlOrigin),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: context.settingsCubit.onSignOutPressed, child: Text(l.signOut)),
            ],
          ),
        ),
      ),
    );
  }
}
