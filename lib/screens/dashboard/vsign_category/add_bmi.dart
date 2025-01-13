import 'package:flutter/material.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/providers/bmi_provider.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddBMIScreen extends StatefulWidget {
  const AddBMIScreen({super.key});

  @override
  State<AddBMIScreen> createState() => _AddBMIScreenState();
}

class _AddBMIScreenState extends State<AddBMIScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bmiProvider = Provider.of<BMIProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check BMI"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              MyTextInput(
                controller: _heightController,
                hideText: false,
                hintText: "Height",
                prefixicon: Icons.person,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextInput(
                controller: _weightController,
                hideText: false,
                hintText: "Weight",
                prefixicon: Icons.person,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    bmiProvider.calculateBMI(_heightController.text.trim(),
                        _weightController.text.trim());
                  }
                },
                text: "Calculate",
              ),
              const SizedBox(
                height: 20,
              ),
              _heightController.text.isEmpty
                  ? const SizedBox()
                  : Consumer<BMIProvider>(
                      builder: (context, provider, child) {
                        Color categoryColor = provider.bmiReport ==
                                    "You are underweight\n(BMI less than 18.5)" ||
                                provider.bmiReport ==
                                    "You are overweight\n(BMI 25 - 29.9)" ||
                                provider.bmiReport ==
                                    "Obesity\n(BMI 30 or higher)"
                            ? Colors.red
                            : Colors.green;
                        return Column(
                          children: [
                            Text(
                              provider.bmi == 0
                                  ? ''
                                  : "Your BMI: ${provider.bmi.toStringAsFixed(1)} kg/m2",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              provider.bmiReport,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: categoryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                await bmiProvider.saveBMI(
                                    _heightController.text.trim(),
                                    _weightController.text.trim(),
                                    provider.bmiReport);
                              },
                              child: Container(
                                height: 35,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: pkColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                    child: Text(
                                  "Save Record",
                                  style: TextStyle(
                                    color: whiteColor,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
