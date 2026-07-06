import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ChapterErrorView extends StatelessWidget {
  final String message;

  const ChapterErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: const TextStyle(color: AppColors.textSecondary)),
    );
  }
}
