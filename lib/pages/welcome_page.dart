import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../features/welcome/state/welcome_state.dart';
import '../shared/values/app_theme_extension.dart';
import '../shared/values/assets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(lazy: false, create: (_) => getIt<WelcomeCubit>(), child: const _Content());
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WelcomeCubit, WelcomeState>(
          buildWhen: (previous, current) => previous.isAuthenticatedState != current.isAuthenticatedState,
          builder: (_, state) {
            return state.isAuthenticatedState.maybeWhen(
              orElse: () => SizedBox.shrink(),
              success: (isAuthenticated) {
                if (isAuthenticated) {
                  return SizedBox.shrink();
                }

                return Column(
                  children: [
                    Spacer(flex: 3),
                    Align(
                      child: SizedBox(
                        width: 0.7.sw,
                        height: 0.7.sw,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(24.r),
                          child: Image.asset(Assets.imageLibrary),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      l.welcomeToAppName,
                      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: 48.h,
                      height: 48.h,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                          backgroundColor: theme.colorScheme.secondary,
                          iconSize: 24.sp,
                          foregroundColor: theme.colorScheme.onSecondary,
                        ),
                        onPressed: context.welcomeCubit.onNextButtonPressed,
                        icon: Icon(Icons.chevron_right),
                      ),
                    ),
                    Spacer(flex: 4),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.h),
                      child: Text(
                        l.welcomeCaption,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.sp, color: theme.appThemeExtension?.elSecondary),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
