import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';

class SubmissionSuccessPage extends StatelessWidget {
  const SubmissionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFFAF0),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Color(0xFF16A34A),
                          size: 42,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Ma\'lumotlar bazasiga muvaffaqiyatli ro\'yxatdan o\'tdingiz',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sizning ma\'lumotlaringiz qabul qilindi va saqlandi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 28),
                      CustomElevatedButton(
                        width: 320,
                        isLoading: false,
                        onPressed: () {
                          context.go('/');
                        },
                        text: 'Profilga o\'tish',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
