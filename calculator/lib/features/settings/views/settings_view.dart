import 'package:calculator/app/calculator_cubit/calculator_cubit.dart';
import 'package:calculator/app/calculator_cubit/calculator_state.dart';
import 'package:calculator/app/models/person_model.dart';
import 'package:calculator/app/resources/color_manager.dart';
import 'package:calculator/app/resources/font_manager.dart';
import 'package:calculator/app/resources/strings_manager.dart';
import 'package:calculator/app/resources/values_manager.dart';
import 'package:calculator/app/utils/functions.dart';
import 'package:calculator/app/widgets/custom_elevated_button.dart';
import 'package:calculator/app/widgets/custom_list_view.dart';
import 'package:calculator/app/widgets/custom_text_form_field.dart';
import 'package:calculator/features/settings/views/edit_kit_list_view.dart';
import 'package:calculator/features/settings/views/edit_persons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SttingsView extends StatelessWidget {
  const SttingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (context2, state) {
        var cubit = CalculatorCubit.get(context2);
        return Scaffold(
          appBar: customAppBar(
            text: StringsManager.settings,
            onPressed: () {
              cubit.sortProfits();
              Navigator.pop(context);
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // adminstration percentage
                Padding(
                  padding: const EdgeInsets.all(
                    AppPadding.p20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomTextFormField(
                          controller: TextEditingController(
                            text: cubit.adminPercentage.toString(),
                          ),
                          fontSize: FontSize.s22,
                          labelText: StringsManager.adminPercentage,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          onChanged: (value) {
                            cubit.adminPercentage = double.parse(value);
                          },
                        ),
                      ),

                      const Gap(10),

                      // save button
                      Expanded(
                        flex: 2,
                        child: CustomElevatedButton(
                          onPressed: () {
                            cubit.savePersonsData();
                          },
                          text: StringsManager.save,
                        ),
                      ),
                    ],
                  ),
                ),

                // persons percentage
                CustomListView(
                  itemBuilder: (context, index) {
                    PersonModel person = cubit.personItems[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p20,
                        vertical: AppPadding.p10,
                      ),
                      width: double.infinity,
                      color: (index % 2 != 0) ? ColorManager.lightGrey2 : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            person.name,
                            style: getTextStyle(),
                          ),

                          // percentage
                          Text(
                            '${person.percentage}%',
                            style: getTextStyle(),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: cubit.personItems.length,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    right: AppPadding.p20,
                    top: AppPadding.p20,
                  ),
                  child: Column(
                    children: [
                      // edit persons list button
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EditPersonsListView(),
                              ),
                            );
                          },
                          text: StringsManager.editPersons,
                        ),
                      ),

                      const Gap(25),

                      // edit profit values button
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () {
                            navigateTo(
                              context: context,
                              dest: const EditKitListView(),
                            );
                          },
                          text: StringsManager.editKits,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
