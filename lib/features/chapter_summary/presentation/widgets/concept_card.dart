import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Known concept names that get rendered as a 2-column concept-comparison
/// grid in the Content tab (e.g. Encapsulation vs Delegation) instead of
/// flowing as plain subheadings.
const Map<String, IconData> kConceptIcons = {
  'encapsulation': LucideIcons.box,
  'delegation': LucideIcons.shuffle,
  'loose coupling': LucideIcons.unlock,
  'tight coupling': LucideIcons.lock,
};

class ConceptData {
  final String title;
  final String description;

  const ConceptData({required this.title, required this.description});
}

class ConceptGrid extends StatelessWidget {
  final List<ConceptData> concepts;

  const ConceptGrid({super.key, required this.concepts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final concept in concepts)
            SizedBox(
              width: (MediaQuery.of(context).size.width - AppSpacing.lg * 2 - AppSpacing.sm) / 2,
              child: ConceptCard(concept: concept),
            ),
        ],
      ),
    );
  }
}

class ConceptCard extends StatelessWidget {
  final ConceptData concept;

  const ConceptCard({super.key, required this.concept});

  @override
  Widget build(BuildContext context) {
    final icon = kConceptIcons[concept.title.toLowerCase()] ?? LucideIcons.brain;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(height: AppSpacing.sm),
          Text(
            concept.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            concept.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
