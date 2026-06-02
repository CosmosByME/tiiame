import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/core/widgets/phone_number_field.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';

class PhoneNumberSelecting extends StatefulWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  const PhoneNumberSelecting({super.key, this.onNext, this.onPrevious});

  @override
  State<PhoneNumberSelecting> createState() => _PhoneNumberSelectingState();
}

class _PhoneNumberSelectingState extends State<PhoneNumberSelecting>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(() {
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
              'Telefon raqami faqat raqamlardan iborat bo\'lsin. Kod avtomatik ravishda +998 qilib qo\'shiladi.',
        ),
        const SizedBox(height: 16),
        Text(
          "Telefon raqamingizni kiriting",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),

        SizedBox(height: 16),
        PhoneNumberField(controller: phoneNumberController),
        SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            CustomOutlinedButton(
              width: 140,
              onPressed: () {
                widget.onPrevious?.call();
              },
              text: "Orqaga",
            ),
            CustomElevatedButton(
              width: 140,
              isLoading: isLoading,
              onPressed: (phoneNumberController.text.length < 12)
                  ? null
                  : () async {
                      context.read<FormBloc>().add(
                        PhoneNumberChanged(
                          "+998-${phoneNumberController.text}",
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
