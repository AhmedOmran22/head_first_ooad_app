import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_theme.dart';

/// Shimmering placeholder shown while a chapter's markdown/metadata is
/// still loading.
class ChapterLoadingSkeleton extends StatelessWidget {
  const ChapterLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Shimmer.fromColors(
          baseColor: AppColors.surface,
          highlightColor: AppColors.surfaceElevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 140, decoration: _skeletonDecoration),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: List.generate(
                  3,
                  (i) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: i == 2 ? 0 : AppSpacing.sm),
                      height: 90,
                      decoration: _skeletonDecoration,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              for (int i = 0; i < 4; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  height: 80,
                  decoration: _skeletonDecoration,
                ),
            ],
          ),
        ),
      ),
    );
  }

  static final _skeletonDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(16),
  );
}
