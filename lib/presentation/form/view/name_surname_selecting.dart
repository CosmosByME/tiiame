import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';

class NameSurnameSelecting extends StatefulWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  const NameSurnameSelecting({super.key, this.onNext, this.onPrevious});

  @override
  State<NameSurnameSelecting> createState() => _NameSurnameSelectingState();
}

class _NameSurnameSelectingState extends State<NameSurnameSelecting>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    surnameController.addListener(() {
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
          text:
              'Ism va familiyani harflar bilan kiriting. Raqam va maxsus belgilarni ishlatmang.',
        ),
        const SizedBox(height: 16),
        Text(
          "O'quvchining ism va familiyasini kiriting",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),

        SizedBox(height: 16),
        CustomTextField(
          controller: nameController,
          hint: "Ism",
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я' -]")),
          ],
        ),
        SizedBox(height: 16),
        CustomTextField(
          controller: surnameController,
          hint: "Familiya",
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я' -]")),
          ],
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
              onPressed:
                  (nameController.text.isEmpty ||
                      surnameController.text.isEmpty)
                  ? null
                  : () async {
                      context.read<FormBloc>().add(
                        NameSurnameChanged(
                          name: nameController.text,
                          surname: surnameController.text,
                        ),
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
