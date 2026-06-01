import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
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
        ),
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
              onPressed: (homeController.text.isEmpty)
                  ? null
                  : () async {
                      context.read<FormBloc>().add(HomeChanged(homeController.text));
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
