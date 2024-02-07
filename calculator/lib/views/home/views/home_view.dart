import 'package:calculator/core/utils/functions.dart';
import 'package:calculator/core/resources/strings_manager.dart';
import 'package:calculator/views/home/widgets/home_view_body.dart';
import 'package:calculator/views/settings/views/settings_view.dart';
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
            dest: const SttingsView(),
          );
        },
        icon: const Icon(Icons.settings),
      ),
    ],
  );
}
