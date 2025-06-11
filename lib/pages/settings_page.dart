import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../features/settings/state/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SettingsCubit>(), child: _Content());
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
              ElevatedButton(onPressed: context.settingsCubit.onSignOutPressed, child: Text(l.signOut)),
            ],
          ),
        ),
      ),
    );
  }
}
