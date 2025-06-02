import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/di/register_dependencies.dart';
import '../features/authentication/state/sign_in_state.dart';
import '../features/authentication/ui/sign_in_form.dart';
import '../shared/ui/logo_header.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<SignInCubit>(), child: _Content());
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TapOutsideToClearFocus(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h),
                child: const LogoHeaderMedium(),
              ),
              Expanded(child: SignInForm()),
            ],
          ),
        ),
      ),
    );
  }
}
