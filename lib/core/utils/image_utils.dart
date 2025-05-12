import 'package:flutter/material.dart';

class ImageUtils {
  // Generate a colored placeholder for missing images
  static Widget generateColoredPlaceholder(String assetPath) {
    // Generate a color based on the asset path
    final int hashCode = assetPath.hashCode;
    final Color color = Color((hashCode & 0x00FFFFFF) | 0xFF000000);

    return Container(
      color: color,
      child: const Center(
        child: Icon(Icons.image, color: Colors.white70, size: 50),
      ),
    );
  }

  // Get a placeholder image based on the index
  static String getPlaceholderImage(int index) {
    final List<String> placeholders = [
      'assets/images/a1.png',
      'assets/images/a2.png',
      'assets/images/b.png',
    ];

    // Use modulo to cycle through the available placeholders
    return placeholders[index % placeholders.length];
  }
}
