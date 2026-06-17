import 'package:flutter/material.dart';

class AppProgressBar extends StatelessWidget {
  final double value;
  final String? label;
  final String? trailingText;
  final Color? color;
  final double height;
  final bool showPercentage;

  const AppProgressBar({
    super.key,
    required this.value,
    this.label,
    this.trailingText,
    this.color,
    this.height = 10,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final progress = value.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || trailingText != null || showPercentage)
          Row(
            children: [
              if (label != null)
                Expanded(
                  child: Text(label!, style: theme.textTheme.bodyMedium),
                ),

              Text(
                trailingText ??
                    (showPercentage
                        ? '${(progress * 100).toStringAsFixed(0)}%'
                        : ''),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
