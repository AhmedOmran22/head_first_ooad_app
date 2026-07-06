import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/markdown/markdown_block_view.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../../../core/theme/app_theme.dart';
import 'concept_card.dart';

/// Flows all chapter sections as clean editorial content: a small amber dot
/// + title per section, then its blocks, with a thin divider between
/// sections. No card wrappers, no accordions.
class ContentTab extends StatefulWidget {
  final List<MdSection> sections;
  final Map<String, GlobalKey> sectionKeys;
  final ScrollController scrollController;
  final double initialProgress;

  const ContentTab({
    super.key,
    required this.sections,
    required this.sectionKeys,
    required this.scrollController,
    required this.initialProgress,
  });

  @override
  State<ContentTab> createState() => _ContentTabState();
}

class _ContentTabState extends State<ContentTab> {
  static const _maxRestoreAttempts = 5;
  int _restoreAttempts = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialProgress > 0) {
      WidgetsBinding.instance.addPostFrameCallback(_restoreScrollPosition);
    }
  }

  void _restoreScrollPosition(Duration _) {
    if (!mounted || !widget.scrollController.hasClients) return;
    final position = widget.scrollController.position;
    if (position.maxScrollExtent <= 0) {
      // Layout may not have settled yet — retry a few frames, then give up
      // (a genuinely short chapter has nothing to scroll to anyway).
      _restoreAttempts++;
      if (_restoreAttempts < _maxRestoreAttempts) {
        WidgetsBinding.instance.addPostFrameCallback(_restoreScrollPosition);
      }
      return;
    }
    widget.scrollController.jumpTo(widget.initialProgress * position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: widget.sections.length,
      itemBuilder: (context, index) {
        final section = widget.sections[index];
        return Container(
          key: widget.sectionKeys[section.title],
          margin: EdgeInsets.only(bottom: index == widget.sections.length - 1 ? 0 : AppSpacing.lg),
          padding: index == widget.sections.length - 1
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: AppSpacing.lg),
          decoration: index == widget.sections.length - 1
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
