import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImgSelecting extends StatefulWidget {
  final Uint8List? image;
  final void Function() onPressed;
  final void Function()? onCencel;

  const ImgSelecting({
    super.key,
    required this.onPressed,
    this.image,
    this.onCencel,
  });

  @override
  State<ImgSelecting> createState() => _ImgSelectingState();
}

class _ImgSelectingState extends State<ImgSelecting> {
  Uint8List? get _fileBytes => widget.image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 7],
          strokeWidth: 1.6,
          radius: Radius.circular(15),
          color: Color(0xFFE2E8F0),
          padding: EdgeInsets.all(2),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFF8FAFC),
          ),
          child: widget.image != null
              ? Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _fileBytes != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.memory(
                                    _fileBytes!,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 20,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: widget.onCencel,
                          ),
                        ),
                      ],
                    ),

                    Expanded(child: SizedBox()),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("📷", style: TextStyle(fontSize: 30)),
                      SizedBox(height: 10),
                      Text(
                        "Maksimum 3MB hajmdagi rasm yuklang",
                        style: TextStyle(
                          color: Color(0xFF334155),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Rasm oq fonda ortiqcha elementlarsiz bo'lishi kerak",
                        style: TextStyle(
                          color: Color(0xFF16A34A),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          backgroundColor: Color(0xFFF0FDF4),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
