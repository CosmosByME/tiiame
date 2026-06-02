import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web; // Modern 2026 web package

class StudentAvatar extends StatelessWidget {
  final String photoUrl;

  const StudentAvatar({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    // Generate a unique view identifier based on the image URL
    final String viewId = 'img_${photoUrl.hashCode}';

    // Register the native HTML <img> element to bypass CanvasKit CORS restrictions
    ui_web.platformViewRegistry.registerViewFactory(
      viewId,
      (int viewId) => web.HTMLImageElement()
        ..src = photoUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.borderRadius = '50%'
        ..style.objectFit = 'cover',
    );

    return CircleAvatar(
      radius: 36,
      backgroundColor: const Color(0xFFE2E8F0),
      child: SizedBox(
        width: 72,
        height: 72,
        child: ClipOval(
          child: HtmlElementView(viewType: viewId),
        ),
      ),
    );
  }
}