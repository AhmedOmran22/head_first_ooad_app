import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'inline_text.dart';
import 'markdown_models.dart';
import '../../features/chapter_summary/presentation/widgets/code_block_widget.dart';
import '../../features/chapter_summary/presentation/widgets/quote_widget.dart';

/// Renders a single [MdBlock] as a flowing widget (paragraph, subheading,
/// quote, code block, list or table) without wrapping it in any card or
/// accordion container.
class MarkdownBlockView extends StatelessWidget {
  final MdBlock block;

  const MarkdownBlockView(this.block, {super.key});

  @override
  Widget build(BuildContext context) {
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
      MdTable(:final headers, :final rows) => MarkdownTableView(headers: headers, rows: rows),
    };
  }
}

class MarkdownTableView extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const MarkdownTableView({super.key, required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.sm),
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
            for (final row in rows) TableRow(children: row.map((c) => _cell(c)).toList()),
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
