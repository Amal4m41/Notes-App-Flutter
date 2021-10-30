import 'package:flutter/material.dart';

class RoundIconBorder extends StatelessWidget {
  final IconData icon;

  RoundIconBorder({required this.icon});

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
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
