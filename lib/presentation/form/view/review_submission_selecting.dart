import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/presentation/form/bloc/form_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewSubmissionSelecting extends StatelessWidget {
  final VoidCallback? onPrevious;

  const ReviewSubmissionSelecting({super.key, this.onPrevious});

  Widget _buildItem(String label, String? value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E8EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF667085)),
          ),
          const SizedBox(height: 6),
          SelectableText(
            value?.isNotEmpty == true ? value! : '-',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkItem(BuildContext context, String label, String? url) {
    final hasUrl = url?.isNotEmpty == true;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E8EC)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF667085),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  hasUrl ? 'Havolani ochish uchun bosing' : '-',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: hasUrl
                ? () async {
                    final uri = Uri.tryParse(url!);
                    if (uri != null) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  }
                : null,
            child: const Text('Ochish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloc, FormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go('/registration-success');
        }
      },
      child: BlocBuilder<FormBloc, FormState>(
        builder: (context, state) {
          final student = state.studentData;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                const Text(
                  'Ma\'lumotlarni tekshiring',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Yuborishdan oldin quyidagi ma\'lumotlarni bir bor ko\'rib chiqing.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF667085)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildItem('Ism', student?.firstName),
                const SizedBox(height: 10),
                _buildItem('Familiya', student?.lastName),
                const SizedBox(height: 10),
                _buildItem(
                  'Sinf',
                  student?.grade == null ? null : '${student?.grade}-sinf',
                ),
                const SizedBox(height: 10),
                _buildItem('Home', student?.home),
                const SizedBox(height: 10),
                _buildItem('Telefon raqami', student?.phoneNumber),
                const SizedBox(height: 10),
                _buildLinkItem(context, 'Profil rasmi', student?.photoUrl),
                const SizedBox(height: 10),
                _buildLinkItem(context, 'ID karta', student?.passportUrl),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    CustomOutlinedButton(
                      width: 150,
                      onPressed: () {
                        onPrevious?.call();
                      },
                      text: 'Orqaga',
                    ),
                    CustomElevatedButton(
                      width: 150,
                      isLoading: state.isLoading,
                      onPressed: student == null
                          ? null
                          : () {
                              context.read<FormBloc>().add(FormSubmitted());
                            },
                      text: 'Yuborish',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
