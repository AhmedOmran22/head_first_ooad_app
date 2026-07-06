import 'markdown_models.dart';

/// Parses chapter markdown into [MdSection]s split on level-2 (`##`) headings.
/// This is intentionally not a full CommonMark parser — it covers the subset
/// of markdown used by the book summaries: headings, blockquotes, fenced
/// code blocks, tables, bullet lists, horizontal rules and paragraphs.
class MarkdownParser {
  const MarkdownParser._();

  static List<MdSection> parseSections(String markdown) {
    final lines = markdown.replaceAll('\r\n', '\n').split('\n');
    final sections = <MdSection>[];

    String? currentTitle;
    final buffer = <String>[];

    void flush() {
      if (currentTitle != null) {
        sections.add(MdSection(currentTitle, _parseBlocks(buffer)));
      }
      buffer.clear();
    }

    for (final line in lines) {
      if (line.startsWith('## ')) {
        flush();
        currentTitle = _stripInline(line.substring(3).trim());
      } else if (currentTitle != null) {
        buffer.add(line);
      }
    }
    flush();

    return sections;
  }

  static List<MdBlock> _parseBlocks(List<String> lines) {
    final blocks = <MdBlock>[];
    int i = 0;

    while (i < lines.length) {
      final line = lines[i];

      if (line.trim().isEmpty || line.trim() == '---') {
        i++;
        continue;
      }

      if (line.startsWith('### ')) {
        blocks.add(MdSubheading(_stripInline(line.substring(4).trim())));
        i++;
        continue;
      }

      if (line.startsWith('```')) {
        final language = line.substring(3).trim();
        final code = <String>[];
        i++;
        while (i < lines.length && !lines[i].startsWith('```')) {
          code.add(lines[i]);
          i++;
        }
        i++; // skip closing fence
        blocks.add(MdCodeBlock(code.join('\n'), language));
        continue;
      }

      if (line.trimLeft().startsWith('> ')) {
        final quote = <String>[];
        while (i < lines.length && lines[i].trimLeft().startsWith('>')) {
          final stripped = lines[i].trimLeft().replaceFirst(RegExp(r'^>\s?'), '');
          quote.add(stripped);
          i++;
        }
        blocks.add(MdQuote(_stripInline(quote.join(' ').trim())));
        continue;
      }

      if (line.trimLeft().startsWith('|')) {
        final tableLines = <String>[];
        while (i < lines.length && lines[i].trimLeft().startsWith('|')) {
          tableLines.add(lines[i].trim());
          i++;
        }
        final table = _parseTable(tableLines);
        if (table != null) blocks.add(table);
        continue;
      }

      if (RegExp(r'^[-*]\s+').hasMatch(line.trimLeft())) {
        final items = <String>[];
        while (i < lines.length && RegExp(r'^[-*]\s+').hasMatch(lines[i].trimLeft())) {
          items.add(_stripInline(lines[i].trimLeft().replaceFirst(RegExp(r'^[-*]\s+'), '')));
          i++;
        }
        blocks.add(MdListBlock(items));
        continue;
      }

      // Paragraph: accumulate until a blank line or a new block starts.
      final paragraph = <String>[];
      while (i < lines.length &&
          lines[i].trim().isNotEmpty &&
          lines[i].trim() != '---' &&
          !lines[i].startsWith('### ') &&
          !lines[i].startsWith('```') &&
          !lines[i].trimLeft().startsWith('> ') &&
          !lines[i].trimLeft().startsWith('|') &&
          !RegExp(r'^[-*]\s+').hasMatch(lines[i].trimLeft())) {
        paragraph.add(lines[i].trim());
        i++;
      }
      if (paragraph.isNotEmpty) {
        blocks.add(MdParagraph(_stripInline(paragraph.join(' '))));
      }
    }

    return blocks;
  }

  static MdTable? _parseTable(List<String> lines) {
    if (lines.length < 2) return null;

    List<String> splitRow(String row) {
      final trimmed = row.trim().replaceFirst(RegExp(r'^\|'), '').replaceFirst(RegExp(r'\|$'), '');
      return trimmed.split('|').map((c) => _stripInline(c.trim())).toList();
    }

    final headers = splitRow(lines[0]);
    final rows = <List<String>>[];
    for (var r = 2; r < lines.length; r++) {
      rows.add(splitRow(lines[r]));
    }
    return MdTable(headers, rows);
  }

  /// Strips markdown emphasis markers while keeping the raw text; bold/italic
  /// styling is instead reconstructed by [InlineTextSpanBuilder] downstream.
  static String _stripInline(String text) => text;
}
