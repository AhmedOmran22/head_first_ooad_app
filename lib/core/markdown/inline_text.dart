import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Renders a single line of inline markdown (`**bold**`, `` `code` ``,
/// `*italic*`) as a [Text.rich] widget without pulling in a full markdown
/// rendering package.
class InlineMarkdownText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const InlineMarkdownText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ??
        const TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.6);
    return Text.rich(
      TextSpan(children: _buildSpans(text, baseStyle)),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }

  static List<InlineSpan> _buildSpans(String text, TextStyle baseStyle) {
    final spans = <InlineSpan>[];
    final pattern = RegExp(r'(\*\*(.+?)\*\*)|(`(.+?)`)|(\*(.+?)\*)');
    int cursor = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, match.start), style: baseStyle));
      }
      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: baseStyle.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(
          text: match.group(4),
          style: baseStyle.copyWith(
            fontFamily: AppTheme.monoStyle.fontFamily,
            backgroundColor: AppColors.codeBackground,
            color: AppColors.accent,
            fontSize: (baseStyle.fontSize ?? 15) - 1,
          ),
        ));
      } else if (match.group(5) != null) {
        spans.add(TextSpan(
          text: match.group(6),
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ));
      }
      cursor = match.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor), style: baseStyle));
    }
    return spans;
  }
}
