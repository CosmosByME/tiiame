import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class LaunchableFileTile extends StatelessWidget {
  const LaunchableFileTile({
    super.key,
    required this.title,
    required this.fileName,
    required this.fileSizeLabel,
    required this.fileTypeLabel,
    required this.icon,
    this.url,
    this.onTap,
  });

  final String title;
  final String fileName;
  final String fileSizeLabel;
  final String fileTypeLabel;
  final IconData icon;
  final String? url;
  final VoidCallback? onTap;

  Future<void> _openFile() async {
    if (onTap != null) {
      onTap!.call();
      return;
    }

    final value = url;
    if (value == null || value.isEmpty) return;

    web.window.open(value, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: hasUrl ? _openFile : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Icon(icon, color: _iconColor(), size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _iconColor().withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            fileTypeLabel,
                            style: TextStyle(
                              color: _iconColor(),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fileSizeLabel,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                hasUrl ? Icons.open_in_new_rounded : Icons.lock_outline,
                color: const Color(0xFF64748B),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _iconColor() {
    switch (fileTypeLabel.toUpperCase()) {
      case 'PDF':
        return const Color(0xFFDC2626);
      case 'JPG':
      case 'JPEG':
      case 'PNG':
      case 'WEBP':
        return const Color(0xFF2563EB);
      default:
        return const Color(0xFF475569);
    }
  }
}
