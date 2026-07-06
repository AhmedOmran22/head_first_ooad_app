import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// A vertical table-of-contents for the chapter's sections, shown on the
/// Overview tab. Tapping a row hands the section title back to the caller,
/// which switches to the Content tab and scrolls to it.
class SectionsToc extends StatelessWidget {
  final List<String> sectionTitles;
  final ValueChanged<String> onSectionTap;

  const SectionsToc({
    super.key,
    required this.sectionTitles,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sections in this chapter',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (var i = 0; i < sectionTitles.length; i++)
          _TocRow(
            title: sectionTitles[i],
            isLast: i == sectionTitles.length - 1,
            onTap: () => onSectionTap(sectionTitles[i]),
          ).animate(delay: Duration(milliseconds: 50 * i)).fadeIn(duration: 200.ms),
      ],
    );
  }
}

class _TocRow extends StatelessWidget {
  final String title;
  final bool isLast;
  final VoidCallback onTap;

  const _TocRow({required this.title, required this.isLast, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
