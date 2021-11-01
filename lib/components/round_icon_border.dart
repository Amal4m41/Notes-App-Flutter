import 'package:flutter/material.dart';

class RoundIconBorder extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  RoundIconBorder({required this.icon, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
    );
  }
}
