import 'package:flutter/material.dart';

class Appheader extends StatelessWidget {
  final String title;
  final IconData icon;

  const Appheader({
    super.key,
    required this.title,
    this.icon = Icons.inventory_2_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue,
                  size: 26,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 30,
          child: CustomPaint(
            painter: _HeaderWavesPainter(
              theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderWavesPainter extends CustomPainter {
  final Color color;

  _HeaderWavesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height);

    path.quadraticBezierTo(
      size.width * 0.25,
      0,
      size.width * 0.5,
      size.height * 0.7,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height,
      size.width,
      size.height * 0.3,
    );

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}