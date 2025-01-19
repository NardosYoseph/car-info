import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  final double percentage;
  final Color color;
  final String label;

  const CircularIndicator({
    Key? key,
    required this.percentage,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey.shade200,
                color: color,
                strokeWidth: 4,
              ),
              Text(
                '${percentage.toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
