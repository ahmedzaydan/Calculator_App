import 'package:calculator/cubit/calculator_cubit.dart';
import 'package:calculator/cubit/calculator_state.dart';
import 'package:calculator/screens/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPersonScreen extends StatelessWidget {
  AddPersonScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Person'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Person name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter person name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: percentageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Person percentage',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter person percentage';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CalculatorCubit.get(context).addPerson(
                            name: nameController.text,
                            percentage: double.parse(percentageController.text),
                          );
                          Navigator.pop(context);
                        }
                      },
                      text: 'Add',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
