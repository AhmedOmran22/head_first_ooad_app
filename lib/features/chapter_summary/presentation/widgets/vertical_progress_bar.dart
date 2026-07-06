import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// A slim, read-only reading-progress indicator pinned to the right edge of
/// the screen. Purely visual — wrapped in [IgnorePointer] so it never
/// intercepts taps/swipes meant for the content beneath it.
class VerticalProgressBar extends StatelessWidget {
  final double progress;

  const VerticalProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: 4,
        child: Container(
          color: AppColors.surfaceElevated,
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: constraints.maxHeight * progress.clamp(0.0, 1.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.accent, AppColors.accentDim],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
