import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrollableFormWrapper extends StatelessWidget {
  const ScrollableFormWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16.w, 52.h, 16.w, 12.w),
            child: child,
          ),
        ),
      ],
    );
  }
}
