import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/markdown/markdown_block_view.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../../../core/theme/app_theme.dart';
import 'concept_card.dart';

/// Flows all chapter sections as clean editorial content: a small amber dot
/// + title per section, then its blocks, with a thin divider between
/// sections. No card wrappers, no accordions.
class ContentTab extends StatelessWidget {
  final List<MdSection> sections;
  final Map<String, GlobalKey> sectionKeys;

  const ContentTab({
    super.key,
    required this.sections,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return Container(
          key: sectionKeys[section.title],
          margin: EdgeInsets.only(bottom: index == sections.length - 1 ? 0 : AppSpacing.lg),
          padding: index == sections.length - 1
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: AppSpacing.lg),
          decoration: index == sections.length - 1
              ? null
              : const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ..._buildBody(section.blocks),
            ],
          ),
        ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.03, end: 0, duration: 200.ms);
      },
    );
  }

  List<Widget> _buildBody(List<MdBlock> blocks) {
    final widgets = <Widget>[];
    int i = 0;

    while (i < blocks.length) {
      final block = blocks[i];

      if (block is MdSubheading && kConceptIcons.containsKey(block.text.toLowerCase())) {
        final concepts = <ConceptData>[];
        while (i < blocks.length &&
            blocks[i] is MdSubheading &&
            kConceptIcons.containsKey((blocks[i] as MdSubheading).text.toLowerCase())) {
          final title = (blocks[i] as MdSubheading).text;
          i++;
          final descParts = <String>[];
          while (i < blocks.length && blocks[i] is! MdSubheading) {
            final inner = blocks[i];
            if (inner is MdParagraph) {
              descParts.add(inner.text);
            } else if (inner is MdQuote) {
              descParts.add(inner.text);
            } else {
              break;
            }
            i++;
          }
          concepts.add(ConceptData(title: title, description: descParts.join(' ')));
        }
        widgets.add(ConceptGrid(concepts: concepts));
        continue;
      }

      widgets.add(MarkdownBlockView(block));
      i++;
    }

    return widgets;
  }
}
