import 'package:calculator/core/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/features/home/views/widgets/home_view_body.dart';
import 'package:calculator/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: HomeViewBody(),
        ),
      ),
    );
  }
}

AppBar homeAppBar(BuildContext context) {
  return customAppBar(
    text: StringsManager.homeScreen,
    leading: false,
    actions: [
      IconButton(
        onPressed: () {
          navigateTo(
            context: context,
            dest: const SttingsScreen(),
          );
        },
        icon: const Icon(Icons.settings),
      ),
    ],
  );
}
