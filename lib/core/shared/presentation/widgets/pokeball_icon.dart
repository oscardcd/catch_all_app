import 'package:flutter/material.dart';

class PokeBallIcon extends StatelessWidget {
  const PokeBallIcon({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF4444), Color(0xFFCC0000)],
        ),
        boxShadow: [BoxShadow(color: const Color(0xFFFF4444).withValues(alpha: 0.3), blurRadius: 12, spreadRadius: 2)],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CustomPaint(painter: _PokeBallPainter()),
          ),
        ],
      ),
    );
  }
}

class _PokeBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Top half (red)
    final redPaint = Paint()..color = const Color(0xFFFF4444);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 3.14159, 3.14159, false, redPaint);

    // Bottom half (white)
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, 3.14159, false, whitePaint);

    // Middle line
    final linePaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..strokeWidth = size.width * 0.07;
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), linePaint);

    // Center circle (border)
    final borderPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07;
    canvas.drawCircle(center, size.width * 0.16, borderPaint);

    // Center circle (fill)
    final centerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, size.width * 0.11, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
