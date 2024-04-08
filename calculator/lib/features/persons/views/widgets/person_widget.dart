import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/widgets/actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PersonWidget extends StatelessWidget {
  PersonWidget({
    super.key,
    required this.person,
    required this.deleteOnPressed,
    required this.editOnPressed,
    required this.backgroundColor,
  });

  final PersonModel person;
  final void Function()? deleteOnPressed;
  final void Function()? editOnPressed;
  final Color backgroundColor;

  final cubit = locator<PersonsCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // person name
                Text(
                  person.name,
                  style: getTextStyle(),
                ),

                // person percentage
                Text(
                  '${person.percentage}%',
                  style: getTextStyle(),
                ),
              ],
            ),
          ),

          const Gap(15),

          // edit + delete buttons
          ActionsWidget(
            editOnPressed: editOnPressed,
            deleteOnPressed: deleteOnPressed,
            deleteButtonStyle: ButtonStyle(
              iconColor: MaterialStateProperty.all(ColorManager.red),
            ),
          ),
        ],
      ),
    );
  }
}
