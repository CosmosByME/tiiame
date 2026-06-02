import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/core/widgets/info_widget.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';

class HomeSelecting extends StatefulWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  const HomeSelecting({super.key, this.onPrevious, this.onNext});

  @override
  State<HomeSelecting> createState() => _HomeSelectingState();
}

class _HomeSelectingState extends State<HomeSelecting>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController homeController = TextEditingController();
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    homeController.addListener(() {
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
              'Manzilni viloyat, shahar va tuman bilan birga yozing. Qancha aniq bo\'lsa, shuncha yaxshi.',
        ),
        const SizedBox(height: 16),
        Text(
          "Yashash manzilingiz (viloyat, shahar, tuman)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),

        SizedBox(height: 16),
        CustomTextField(
          controller: homeController,
          hint: "Manzil",
          maxLines: 2,
          textCapitalization: TextCapitalization.words,
          maxLength: 120,
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
              onPressed: (homeController.text.isEmpty)
                  ? null
                  : () async {
                      context.read<FormBloc>().add(
                        HomeChanged(homeController.text),
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
