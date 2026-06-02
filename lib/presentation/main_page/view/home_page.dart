import 'package:flutter/material.dart';
import 'package:tiiame/presentation/main_page/logic/home_page_controller.dart';
import 'package:tiiame/presentation/main_page/view/home_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomePageController()..loadProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageView(controller: _controller);
  }
}
