import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AnimatedProgressIndicatorBar extends StatelessWidget {
  final double progress;

  const AnimatedProgressIndicatorBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3,
      child: Container(
        color: AppColors.surfaceElevated,
        alignment: Alignment.centerLeft,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: constraints.maxWidth * progress.clamp(0.0, 1.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accentDim, AppColors.accent],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
