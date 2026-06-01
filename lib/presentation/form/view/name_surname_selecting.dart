import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
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
        Text(
          "Ism va familiyani kiriting",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),

        SizedBox(height: 16),
        CustomTextField(controller: nameController, hint: "Ism"),
        SizedBox(height: 16),
        CustomTextField(controller: surnameController, hint: "Familiya"),
        SizedBox(height: 24),
        OverflowBar(
          spacing: 16,
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
