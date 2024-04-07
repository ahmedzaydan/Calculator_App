import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/dependency_injection.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/features/persons/models/person_model.dart';
import 'package:calculator/features/persons/person_cubit/persons_cubit.dart';
import 'package:calculator/features/widgets/actions_widget.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  PersonWidget({
    super.key,
    required this.person,
    required this.deleteOnPressed,
    required this.editOnPressed,
  });

  final PersonModel person;
  final void Function()? deleteOnPressed;
  final void Function()? editOnPressed;

  final cubit = locator<PersonsCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cubit.getPersonColor(person),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
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

          // edit + delete buttons
          ActionsWidget(
            editOnPressed: editOnPressed,
            deleteOnPressed: deleteOnPressed,
          ),
        ],
      ),
    );
  }
}
