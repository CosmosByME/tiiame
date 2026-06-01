import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/services/file_service.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';
import 'package:tiiame/presentation/form/view/widget/doc_selecting.dart';

class IdCardSelecting extends StatefulWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  const IdCardSelecting({super.key, this.onPrevious, this.onNext});

  @override
  State<IdCardSelecting> createState() => _IdCardSelectingState();
}

class _IdCardSelectingState extends State<IdCardSelecting>
    with AutomaticKeepAliveClientMixin {
  PlatformFile? selectedDoc;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Oxirgi 2 oy davomida tushgan fotosuratingizni joylang",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),
    
        SizedBox(height: 16),
        SizedBox(
          width: 400,
          child: DocSelecting(
            onPressed: () async {
              final file = await FileService().pickFile();
              if (file != null) {
                debugPrint("Selected file path: ${file.path}");
                setState(() {
                  selectedDoc = file;
                });
              }
            },
            doc: selectedDoc,
            onCencel: () {
              setState(() {
                selectedDoc = null;
              });
            },
          ),
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
            BlocBuilder<FormBloc, FormState>(
              builder: (context, state) {
                return CustomElevatedButton(
                  width: 150,
                  isLoading: state.isLoading,
                  onPressed: (selectedDoc == null)
                      ? null
                      : () async {
                          context.read<FormBloc>().add(
                            IdCardChanged(selectedDoc!),
                          );
                        },
                  text: "Keyingisi",
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
