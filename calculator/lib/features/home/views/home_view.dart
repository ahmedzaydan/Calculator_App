import 'package:calculator/core/functions.dart';
import 'package:calculator/features/settings/views/settings_screen.dart';
import 'package:calculator/features/home/views/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        text: 'Home Calculator Screen',
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context: context, dest: const SttingsScreen());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: HomeScreenBody(),
        ),
      ),
    );
  }
}
