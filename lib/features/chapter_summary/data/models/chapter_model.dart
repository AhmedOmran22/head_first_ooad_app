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
  });
}

/// Static metadata for each chapter. New chapters register themselves here
/// with a title, subtitle, icon and accent color; the markdown body itself
/// is loaded separately from `assets/summaries/chapter<N>.md`.
class ChapterMeta {
  final String title;
  final String subtitle;
  final Color accentColor;
  final IconData iconData;

  const ChapterMeta({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.iconData,
  });
}

const Map<int, ChapterMeta> kChapterMetadata = {
  1: ChapterMeta(
    title: 'Well-Designed Apps Rock',
    subtitle: 'Understand what "great software" really means',
    accentColor: Color(0xFFE8974E),
    iconData: Icons.auto_awesome_rounded,
  ),
};
