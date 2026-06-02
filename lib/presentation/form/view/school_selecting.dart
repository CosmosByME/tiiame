import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';

class SchoolSelecting extends StatefulWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  const SchoolSelecting({super.key, this.onNext, this.onPrevious});

  @override
  State<SchoolSelecting> createState() => _SchoolSelectingState();
}

class _SchoolSelectingState extends State<SchoolSelecting>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController schoolController = TextEditingController();
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    schoolController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const InfoWidget(
          icon: 'ℹ️',
          text: 'Maktab nomini to\'liq yozing. Qisqartmalardan qoching.',
        ),
        const SizedBox(height: 16),
        Text(
          "Qaysi maktabda o'qiysiz?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),

        SizedBox(height: 16),
        CustomTextField(
          controller: schoolController,
          hint: "Maktab nomi",
          textCapitalization: TextCapitalization.words,
          maxLength: 80,
        ),
        SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            CustomOutlinedButton(
              width: 150,
              onPressed: () {
                widget.onPrevious?.call();
              },
              text: "Orqaga",
            ),
            CustomElevatedButton(
              width: 150,
              isLoading: isLoading,
              onPressed: (schoolController.text.isEmpty)
                  ? null
                  : () async {
                      context.read<FormBloc>().add(
                        SchoolChanged(schoolController.text),
                      );
                      widget.onNext?.call();
                    },
              text: "Keyingisi",
            ),
          ],
        ),
      ],
    );
  }
}
