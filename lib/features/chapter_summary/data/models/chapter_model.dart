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
  3: ChapterMeta(
    title: 'Requirements Change',
    subtitle: 'I love you, you\'re perfect... now change',
    accentColor: Color(0xFF8B5CF6),
    iconData: Icons.change_circle_rounded,
    summary:
        'Todd and Gina\'s dog door works great — until they ask for automatic '
        'bark-triggered opening. This chapter evolves the use case through '
        'several versions and applies the first OO Design Principle: '
        'encapsulate what varies.',
    steps: [
      ChapterStep(
        title: 'Update the use case first',
        subtitle: 'Never jump straight to code when requirements change',
      ),
      ChapterStep(
        title: 'Separate main and alternate paths',
        subtitle: 'Scenarios share a goal but take different routes',
      ),
      ChapterStep(
        title: 'Encapsulate what varies',
        subtitle: 'Move shared behavior into the class that owns it',
      ),
    ],
    coreInsight:
        'No matter how well you design an application, it will always grow '
        'and change. If you have good use cases, you can usually change '
        'your software quickly to adjust.',
  ),
  4: ChapterMeta(
    title: 'Analysis',
    subtitle: 'Taking your software into the real world',
    accentColor: Color(0xFF3B82F6),
    iconData: Icons.search_rounded,
    summary:
        'Holly\'s dog door now opens for every dog in the neighborhood, not '
        'just Bruce. This chapter teaches real-world analysis and textual '
        'analysis — reading your use case to find the nouns (classes) and '
        'verbs (methods) your system actually needs.',
    steps: [
      ChapterStep(
        title: 'Analyze for the real world',
        subtitle: 'Find what breaks outside the happy-path scenario',
      ),
      ChapterStep(
        title: 'Circle nouns and verbs',
        subtitle: 'Textual analysis turns use cases into classes and methods',
      ),
      ChapterStep(
        title: 'Delegate to shield your design',
        subtitle: 'Isolate comparison logic so only one class ever changes',
      ),
    ],
    coreInsight:
        'The key to making sure things work is analysis: figuring out '
        'potential problems, and solving those problems before you release '
        'your app into the real world.',
  ),
  5: ChapterMeta(
    title: 'Good Design = Flexible Software',
    subtitle: 'Nothing ever stays the same',
    accentColor: Color(0xFFF43F5E),
    iconData: Icons.hub_rounded,
    summary:
        'Rick wants to sell mandolins too — testing how flexible his guitar '
        'search tool really is. This chapter builds an abstract class '
        'hierarchy, then ruthlessly tears it down again in favor of a '
        'single flexible class driven by a property map, arriving at '
        'cohesion and loose coupling.',
    steps: [
      ChapterStep(
        title: 'Test your design with change',
        subtitle: 'Adding mandolins reveals what breaks in Rick\'s app',
      ),
      ChapterStep(
        title: 'Apply the 3 OO principles',
        subtitle: 'Interface, encapsulate what varies, single responsibility',
      ),
      ChapterStep(
        title: 'Chase cohesion, not more classes',
        subtitle: 'Flatten the hierarchy with enums and a property map',
      ),
    ],
    coreInsight:
        'Most good designs come from analysis of bad designs. Never be '
        'afraid to make mistakes and then change things around.',
  ),
  6: ChapterMeta(
    title: 'Solving Really Big Problems',
    subtitle: 'My name is Art Vandelay... I am an architect',
    accentColor: Color(0xFF6366F1),
    iconData: Icons.account_tree_rounded,
    summary:
        'Gary wants a reusable Game System Framework, and the scale is '
        'overwhelming. This chapter shows that big problems are just lots '
        'of small ones — solved with feature lists, use case diagrams, and '
        'domain analysis to break the system into manageable modules.',
    steps: [
      ChapterStep(
        title: 'Find commonality and variability',
        subtitle: 'Learn what the system is like and not like',
      ),
      ChapterStep(
        title: 'Turn conversations into a feature list',
        subtitle: 'Validate it against a use case diagram',
      ),
      ChapterStep(
        title: 'Break it into modules',
        subtitle: 'Divide and conquer, then let patterns like MVC emerge',
      ),
    ],
    coreInsight:
        'You solve big problems the same way you solve small problems.',
  ),
  7: ChapterMeta(
    title: 'Architecture',
    subtitle: 'Bringing order to chaos',
    accentColor: Color(0xFF10B981),
    iconData: Icons.architecture_rounded,
    summary:
        'With modules and an MVC pattern in place, Gary\'s framework still '
        'feels like chaos. This chapter introduces the 3 Qs of architecture '
        'to find what matters most, then builds the Board, Tile, and Unit '
        'classes to reduce project risk first.',
    steps: [
      ChapterStep(
        title: 'Ask the 3 Qs',
        subtitle: 'Essence, meaning, and difficulty flag what matters most',
      ),
      ChapterStep(
        title: 'Reduce risk first',
        subtitle: 'Build the hardest, most uncertain features early',
      ),
      ChapterStep(
        title: 'Validate with scenarios',
        subtitle: 'A quick informal walkthrough catches missing requirements',
      ),
    ],
    coreInsight:
        'The problem isn\'t which feature to start with — the problem is '
        'risk. Focus on reducing risk, not on the order you tackle things in.',
  ),
  8: ChapterMeta(
    title: 'Design Principles',
    subtitle: 'Originality is overrated',
    accentColor: Color(0xFF06B6D4),
    iconData: Icons.rule_rounded,
    summary:
        'No new customer this chapter — just the design principles behind '
        'everything you\'ve already built. Meet OCP, DRY, SRP, and LSP, and '
        'learn when delegation, composition, or aggregation beats '
        'inheritance.',
    steps: [
      ChapterStep(
        title: 'Extend, don\'t modify',
        subtitle: 'The Open-Closed Principle keeps working code working',
      ),
      ChapterStep(
        title: 'One place, one responsibility',
        subtitle: 'DRY and SRP eliminate duplication and confusion',
      ),
      ChapterStep(
        title: 'Choose the right reuse tool',
        subtitle: 'Delegation, composition, or aggregation over broken inheritance',
      ),
    ],
    coreInsight:
        'If you favor delegation, composition, and aggregation over '
        'inheritance, your software will usually be more flexible, and '
        'easier to maintain, extend, and reuse.',
  ),
  9: ChapterMeta(
    title: 'Iterating and Testing',
    subtitle: 'The software is still for the customer',
    accentColor: Color(0xFF84CC16),
    iconData: Icons.science_rounded,
    summary:
        'Gary is losing patience — he wants to see running code, not more '
        'diagrams. This chapter completes the Unit class with tests written '
        'first, weighs commonality against encapsulation, and settles '
        'programming by contract vs. defensive programming.',
    steps: [
      ChapterStep(
        title: 'Write tests before code',
        subtitle: 'Test scenarios define behavior before implementation biases you',
      ),
      ChapterStep(
        title: 'Weigh commonality vs. encapsulation',
        subtitle: 'Every property tradeoff has pros and cons',
      ),
      ChapterStep(
        title: 'Pick a contract',
        subtitle: 'Programming by contract or defensive, driven by your customer',
      ),
    ],
    coreInsight:
        'Good software is built iteratively. Analyze, design, and then '
        'iterate again, working on smaller and smaller parts of your app.',
  ),
  10: ChapterMeta(
    title: 'The OOA&D Lifecycle',
    subtitle: 'Putting it all together',
    accentColor: Color(0xFFD946EF),
    iconData: Icons.route_rounded,
    summary:
        'Every tool from the book comes together into one repeatable '
        'lifecycle, proven by building the Objectville Travel RouteFinder '
        'from scratch — a subway routing app taken from vision statement to '
        'shipped, tested code.',
    steps: [
      ChapterStep(
        title: 'Run the full lifecycle',
        subtitle: 'Feature list through delivery, one iteration at a time',
      ),
      ChapterStep(
        title: 'Let usage drive design',
        subtitle: 'Skip a Line class because connections already carry it',
      ),
      ChapterStep(
        title: 'Reuse what\'s already solved',
        subtitle: 'Dijkstra\'s algorithm didn\'t need reinventing',
      ),
    ],
    coreInsight:
        'OOA&D is about having lots of options. There is never one right '
        'way to solve a problem, so the more options you have, the better '
        'chance you\'ll find a good solution to every problem.',
  ),
};
