import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChapterStep extends Equatable {
  final String title;
  final String subtitle;

  const ChapterStep({required this.title, required this.subtitle});

  @override
  List<Object?> get props => [title, subtitle];
}

class Chapter extends Equatable {
  final int number;
  final String title;
  final String subtitle;
  final String markdownContent;
  final Color accentColor;
  final IconData iconData;
  final String summary;
  final List<ChapterStep> steps;
  final String coreInsight;

  const Chapter({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.markdownContent,
    required this.accentColor,
    required this.iconData,
    required this.summary,
    required this.steps,
    required this.coreInsight,
  });

  @override
  List<Object?> get props => [
        number,
        title,
        subtitle,
        markdownContent,
        accentColor,
        iconData,
        summary,
        steps,
        coreInsight,
      ];
}
