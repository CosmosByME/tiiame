import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/core/services/file_service.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';
import 'package:tiiame/presentation/form/view/widget/img_selecting.dart';

class PictureSelecting extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  const PictureSelecting({super.key, this.onPrevious, this.onNext, required this.isLoading});

  @override
  State<PictureSelecting> createState() => _PictureSelectingState();
}

class _PictureSelectingState extends State<PictureSelecting>
    with AutomaticKeepAliveClientMixin {
  PlatformFile? selectedImage;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<FormBloc, FormState>(
      listener: (context, state) {
        if (state.isUploaded) {
          widget.onNext?.call();
        }
      },
      child: Column(
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
          ImgSelecting(
            isLoading: widget.isLoading,
            onPressed: () async {
              final file = await FileService().pickImage();
              if (file != null) {
                setState(() {
                  selectedImage = file;
                });
              }
            },
            image: selectedImage,
            onCencel: () {
              setState(() {
                selectedImage = null;
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
                    onPressed: (selectedImage == null)
                        ? null
                        : () async {
                            context.read<FormBloc>().add(
                              PictureChanged(selectedImage!),
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
