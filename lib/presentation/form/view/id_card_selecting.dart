import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tiiame/core/services/file_service.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';
import 'package:tiiame/presentation/form/view/widget/doc_selecting.dart';

class IdCardSelecting extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  const IdCardSelecting({super.key, required this.isLoading, this.onPrevious, this.onNext});

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
    return BlocListener<FormBloc, FormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go('/');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "O'quvchining tug'ilganlik guvohnomasini yoki ID kartasini yuklang",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),

          SizedBox(height: 16),
          DocSelecting(
            isLoading: widget.isLoading,
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
      ),
    );
  }
}
