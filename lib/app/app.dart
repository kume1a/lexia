import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:toastification/toastification.dart';

import '../shared/values/app_theme.dart';
import 'intl/app_localizations.dart';
import 'navigation/page_navigator.dart';
import 'navigation/route_factory.dart';
import 'navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return ToastificationWrapper(
          config: const ToastificationConfig(
            animationDuration: Duration(milliseconds: 400),
            alignment: Alignment.bottomCenter,
          ),
          child: MaterialApp(
            title: 'Lexia',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: Routes.root,
            navigatorObservers: [GNObserver()],
            onGenerateRoute: routeFactory,
            navigatorKey: navigatorKey,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        );
      },
    );
  }
}
