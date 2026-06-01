import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiiame/presentation/auth/log_in/bloc/login_bloc.dart';
import 'package:tiiame/presentation/form/view/grade_selecting.dart';
import 'package:tiiame/presentation/form/view/home_selecting.dart';
import 'package:tiiame/presentation/form/view/id_card_selecting.dart';
import 'package:tiiame/presentation/form/view/name_surname_selecting.dart';
import 'package:tiiame/presentation/form/view/phone_number_selecting.dart';
import 'package:tiiame/presentation/form/view/picture_selecting.dart';
import 'package:tiiame/presentation/form/view/school_selecting.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Muvaffaqiyatli kirildi!")),
          );
        }
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("background/photo1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: 400,
                    child: ExpandablePageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GradeSelecting(onNext: nextPage),
                        NameSurnameSelecting(
                          onNext: nextPage,
                          onPrevious: previousPage,
                        ),

                        SchoolSelecting(
                          onNext: nextPage,
                          onPrevious: previousPage,
                        ),
                        PhoneNumberSelecting(
                          onNext: nextPage,
                          onPrevious: previousPage,
                        ),
                        HomeSelecting(
                          onNext: nextPage,
                          onPrevious: previousPage,
                        ),

                        PictureSelecting(
                          onNext: nextPage,
                          onPrevious: previousPage,
                        ),
                        IdCardSelecting(
                          onNext: nextPage,
                          onPrevious: previousPage,
                        ),
                      ],
                    ),
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
