import 'package:flutter/material.dart';

class CustomButtons {
  Widget textButton({
    required String label,
    required Function() onTap,
    EdgeInsets padding = const EdgeInsets.all(8),
    bool revert = false,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: (revert) ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: (revert) ? Colors.white : Colors.black,
                size: 24,
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: (revert) ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget iconButton({
    required IconData icon,
    required Function() onTap,
    String label = '',
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            )
        ],
      ),
    );
  }
}
