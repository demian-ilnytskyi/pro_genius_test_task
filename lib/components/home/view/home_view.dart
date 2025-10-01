import 'package:flutter/material.dart';
import 'package:pro_genius_test_task/components/home/widget/body/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: SafeArea(child: Scaffold(body: HomeBody())),
    );
  }
}
