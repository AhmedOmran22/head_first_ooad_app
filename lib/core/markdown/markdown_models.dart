/// A lightweight, purpose-built markdown model for rendering chapter
/// summaries as polished native widgets instead of raw markdown text.
library;

sealed class MdBlock {
  const MdBlock();
}

class MdParagraph extends MdBlock {
  final String text;
  const MdParagraph(this.text);
}

class MdQuote extends MdBlock {
  final String text;
  const MdQuote(this.text);
}

class MdCodeBlock extends MdBlock {
  final String code;
  final String language;
  const MdCodeBlock(this.code, this.language);
}

class MdListBlock extends MdBlock {
  final List<String> items;
  const MdListBlock(this.items);
}

class MdTable extends MdBlock {
  final List<String> headers;
  final List<List<String>> rows;
  const MdTable(this.headers, this.rows);
}

class MdSubheading extends MdBlock {
  final String text;
  const MdSubheading(this.text);
}

class MdSection {
  final String title;
  final List<MdBlock> blocks;
  const MdSection(this.title, this.blocks);
}
