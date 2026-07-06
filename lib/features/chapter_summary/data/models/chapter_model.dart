import 'package:flutter/material.dart';
import '../../domain/entities/chapter.dart';

class ChapterModel extends Chapter {
  const ChapterModel({
    required super.number,
    required super.title,
    required super.subtitle,
    required super.markdownContent,
    required super.accentColor,
    required super.iconData,
    required super.summary,
    required super.steps,
    required super.coreInsight,
  });
}

/// Static metadata for each chapter. New chapters register themselves here
/// with a title, subtitle, icon, accent color and the Overview-tab curated
/// copy (summary, steps timeline, core insight); the markdown body itself
/// is loaded separately from `assets/summaries/chapter<N>.md`.
class ChapterMeta {
  final String title;
  final String subtitle;
  final Color accentColor;
  final IconData iconData;
  final String summary;
  final List<ChapterStep> steps;
  final String coreInsight;

  const ChapterMeta({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.iconData,
    required this.summary,
    required this.steps,
    required this.coreInsight,
  });
}

/// Total number of chapters in the book, independent of how many are
/// currently registered below.
const kTotalChapterCount = 10;

const Map<int, ChapterMeta> kChapterMetadata = {
  1: ChapterMeta(
    title: 'Well-Designed Apps Rock',
    subtitle: 'Understand what "great software" really means',
    accentColor: Color(0xFFE8974E),
    iconData: Icons.auto_awesome_rounded,
    summary:
        'Rick\'s guitar shop app looks fine on paper but fails his customers. '
        'This chapter uses that failure to build a repeatable 3-step process '
        'for turning working code into well-designed, reusable software.',
    steps: [
      ChapterStep(
        title: 'Make it work for the customer',
        subtitle: 'Gather requirements, understand the real problem',
      ),
      ChapterStep(
        title: 'Apply OO principles',
        subtitle: 'Encapsulation, delegation, flexibility',
      ),
      ChapterStep(
        title: 'Strive for great design',
        subtitle: 'Maintainable, reusable, and flexible code',
      ),
    ],
    coreInsight:
        'It\'s not enough for code to look correct. It must work correctly '
        'for the customer.',
  ),
  2: ChapterMeta(
    title: 'Gathering Requirements',
    subtitle: 'Give them what they want',
    accentColor: Color(0xFF14B8A6),
    iconData: Icons.fact_check_rounded,
    summary:
        'Doug\'s Dog Doors teaches you to gather real requirements before '
        'writing code. You\'ll turn a vague customer wish into a testable '
        'requirements list, a use case, and finally working, tested Dart code.',
    steps: [
      ChapterStep(
        title: 'Listen to the customer',
        subtitle: 'Turn what they say into a testable requirements list',
      ),
      ChapterStep(
        title: 'Write the use case',
        subtitle: 'Capture actors, the goal, and every alternate path',
      ),
      ChapterStep(
        title: 'Implement and test',
        subtitle: 'Turn the use case into working, tested code',
      ),
    ],
    coreInsight:
        'Code that technically works isn\'t enough. You need to understand '
        'exactly how the system will be used — including what can go wrong.',
  ),
};
