import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'key_takeaway_card.dart';

/// Vertical checklist of chapter takeaways. Staggers its entrance animation
/// only the first time the tab is opened.
class KeyPointsTab extends StatefulWidget {
  final List<String> takeaways;

  const KeyPointsTab({super.key, required this.takeaways});

  @override
  State<KeyPointsTab> createState() => _KeyPointsTabState();
}

class _KeyPointsTabState extends State<KeyPointsTab> with AutomaticKeepAliveClientMixin {
  bool _hasAnimated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final animate = !_hasAnimated;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasAnimated) setState(() => _hasAnimated = true);
    });

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: widget.takeaways.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return KeyTakeawayCard(
          text: widget.takeaways[index],
          index: index,
          animate: animate,
        );
      },
    );
  }
}
