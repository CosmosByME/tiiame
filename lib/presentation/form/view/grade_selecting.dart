import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';

class GradeSelecting extends StatefulWidget {
  final VoidCallback? onNext;
  const GradeSelecting({super.key, this.onNext});

  @override
  State<GradeSelecting> createState() => _GradeSelectingState();
}

class _GradeSelectingState extends State<GradeSelecting>
    with AutomaticKeepAliveClientMixin {
  int? selectedGrade;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final dropdownWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 300.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InfoWidget(
              icon: 'ℹ️',
              text: 'Faqat o\'zingiz o\'qimoqchi bo\'lgan sinfni tanlang.',
            ),
            const SizedBox(height: 16),
            Text(
              "Qaysi sinf uchun xujjat topshirmoqchisiz?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            DropdownMenu(
              width: dropdownWidth,
              hintText: "Sinfni tanlang",
              onSelected: (value) {
                setState(() {
                  selectedGrade = value;
                });
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 7, label: "7-sinf"),
                DropdownMenuEntry(value: 8, label: "8-sinf"),
                DropdownMenuEntry(value: 9, label: "9-sinf"),
                DropdownMenuEntry(value: 10, label: "10-sinf"),
                DropdownMenuEntry(value: 11, label: "11-sinf"),
              ],
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              isLoading: isLoading,
              onPressed: selectedGrade == null
                  ? null
                  : () async {
                      context.read<FormBloc>().add(
                        GradeChanged(selectedGrade!),
                      );
                      widget.onNext?.call();
                    },
              text: "Keyingisi",
            ),
          ],
        );
      },
    );
  }
}
