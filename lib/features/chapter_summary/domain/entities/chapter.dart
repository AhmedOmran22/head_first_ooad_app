import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Chapter extends Equatable {
  final int number;
  final String title;
  final String subtitle;
  final String markdownContent;
  final Color accentColor;
  final IconData iconData;

  const Chapter({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.markdownContent,
    required this.accentColor,
    required this.iconData,
  });

  @override
  List<Object?> get props => [number, title, subtitle, markdownContent, accentColor, iconData];
}
