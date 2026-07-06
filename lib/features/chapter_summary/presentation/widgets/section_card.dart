import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/markdown/inline_text.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../../../core/theme/app_theme.dart';
import 'code_block_widget.dart';
import 'quote_widget.dart';

class SectionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<MdBlock> blocks;
  final bool initiallyExpanded;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.blocks,
    this.initiallyExpanded = false,
  });

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> with SingleTickerProviderStateMixin {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.icon, color: AppColors.accent, size: 20),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(LucideIcons.chevronDown, color: AppColors.textSecondary, size: 18),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.blocks.map(_buildBlock).toList(),
              ),
            ),
            crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
            sizeCurve: Curves.easeOutCubic,
          ),
        ],
      ),
    );
  }

  Widget _buildBlock(MdBlock block) {
    return switch (block) {
      MdParagraph(:final text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: InlineMarkdownText(text),
        ),
      MdSubheading(:final text) => Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.xs),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      MdQuote(:final text) => QuoteWidget(text: text),
      MdCodeBlock(:final code, :final language) => CodeBlockWidget(code: code, language: language),
      MdListBlock(:final items) => Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6, right: AppSpacing.sm),
                            child: Icon(Icons.circle, size: 5, color: AppColors.accent),
                          ),
                          Expanded(child: InlineMarkdownText(item)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      MdTable(:final headers, :final rows) => _TableBlock(headers: headers, rows: rows),
    };
  }
}

class _TableBlock extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const _TableBlock({required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.divider),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1)),
              children: headers.map((h) => _cell(h, isHeader: true)).toList(),
            ),
            for (final row in rows)
              TableRow(children: row.map((c) => _cell(c)).toList()),
          ],
        ),
      ),
    );
  }

  Widget _cell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: InlineMarkdownText(
        text,
        style: TextStyle(
          color: isHeader ? AppColors.textPrimary : AppColors.textSecondary,
          fontSize: 13,
          fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }
}
