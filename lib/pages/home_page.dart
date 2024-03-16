import 'dart:developer';

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/custom_table_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/modified_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController milkCont;
  late TextEditingController breadCont;
  late TextEditingController fruitsCont;
  late TextEditingController nutsCont;
  late TextEditingController meatCont;
  late TextEditingController vegetablesCont;
  late TextEditingController fatsCont;
  late TextEditingController legumesCont;

  late List<TextEditingController> controllerList;

  late Map<TextEditingController, dynamic> controllerMap;
  int milkExchange = 6;

  int totalCalory = 0;
  int totalWeight = 0;
  int totalRatio = 100;

  int totalCarbMass = 0;
  int totalProteinMass = 0;
  int totalFatMass = 0;

  int totalCarbEnergy = 0;
  int totalProteinEnergy = 0;
  int totalFatEnergy = 0;

  String carbCalRatio = "0";
  String protCalRatio = "0";
  String fatCalRatio = "0";

  late bool _halfFat;

  @override
  void initState() {
    super.initState();

    // half fat option
    _halfFat = false;

    milkCont = TextEditingController();
    breadCont = TextEditingController();
    fruitsCont = TextEditingController();
    nutsCont = TextEditingController();
    meatCont = TextEditingController();
    vegetablesCont = TextEditingController();
    fatsCont = TextEditingController();
    legumesCont = TextEditingController();

    controllerList = [
      milkCont,
      breadCont,
      fruitsCont,
      nutsCont,
      meatCont,
      vegetablesCont,
      fatsCont,
      legumesCont,
    ];

    for (var i = 0; i < controllerList.length; i++) {
      controllerList[i].text = "0";
    }

    controllerMap = {
      milkCont: [9, 6, milkExchange],
      breadCont: [15, 2, 0],
      fruitsCont: [15, 0, 0],
      nutsCont: [0, 2, 5],
      meatCont: [0, 6, 5],
      vegetablesCont: [6, 2, 0],
      fatsCont: [0, 0, 5],
      legumesCont: [15, 5, 0],
    };
  }

  void calculate() {
    int totalGram = 0;
    int totalEnergy = 0;

    //total calories
    int totalCarbsCal = 0;
    int totalProteinCalory = 0;
    int totalFatCal = 0;

    //total mass
    int totalCarbsGram = 0;
    int totalProtGram = 0;
    int totalFatGram = 0;

    //ratios
    double carbRatio = 0;
    double protRatio = 0;
    double fatRatio = 0;

    for (var controller in controllerList) {
      List cofactors = controllerMap[controller];
      int choFactor = cofactors[0];
      int proteinFactor = cofactors[1];
      int fatFactor = cofactors[2];
      int enteredValue = int.parse(controller.text);

      log("entered value: $enteredValue , cho: $choFactor, prtin: $proteinFactor, fat: $fatFactor");

      // field  calculations
      int choGram = enteredValue * choFactor;
      int prtGram = enteredValue * proteinFactor;
      int fatGram = enteredValue * fatFactor;

      int totalFieldGram = choGram + prtGram + fatGram;
      int totalFieldEnergy = choGram * 4 + prtGram * 4 + fatGram * 9;

      //total calories for eachs kind of food
      totalCarbsCal += choGram * 4;
      totalProteinCalory += prtGram * 4;
      totalFatCal += fatGram * 9;

      //total mass values for each kind of food
      totalCarbsGram += choGram;
      totalProtGram += prtGram;
      totalFatGram += fatGram;

      //total mass and energy in the whole menu
      totalGram += totalFieldGram;
      totalEnergy += totalFieldEnergy;

      //set the ratios
      carbRatio = (totalCarbsCal / totalEnergy) * 100;
      protRatio = (totalProteinCalory / totalEnergy) * 100;
      fatRatio = (totalFatCal / totalEnergy) * 100;
    }

    setState(() {
      totalCalory = totalEnergy;
      totalWeight = totalGram;

      totalCarbMass = totalCarbsGram;
      totalProteinMass = totalProtGram;
      totalFatMass = totalFatGram;

      totalCarbEnergy = totalCarbsCal;
      totalProteinEnergy = totalProteinCalory;
      totalFatEnergy = totalFatCal;

      carbCalRatio = "%${carbRatio.toStringAsFixed(2)}";
      protCalRatio = "%${protRatio.toStringAsFixed(2)}";
      fatCalRatio = "%${fatRatio.toStringAsFixed(2)}";
    });
  }

  void printValues() async {
    for (var controller in controllerList) {
      log(controller.text);
    }
  }

  void clearFields() {
    for (var controller in controllerList) {
      controller.text = "0";
    }
    setState(() {
      totalCalory = 0;
      totalWeight = 0;

      totalCarbMass = 0;
      totalProteinMass = 0;
      totalFatMass = 0;

      totalCarbEnergy = 0;
      totalProteinEnergy = 0;
      totalFatEnergy = 0;

      carbCalRatio = "0";
      protCalRatio = "0";
      fatCalRatio = "0";
    });
  }

  @override
  void dispose() {
    for (var controller in controllerList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 65, child: Image.asset("assets/logo.png")),
            const SizedBox(width: 5),
            const CustomTableText(
              text: "Exchange\nCalculator",
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ModifiedText(
                              text: "milk",
                              fontSize: 22,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 175,
                              height: 45,
                              child: TextField(
                                enableInteractiveSelection: false,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                controller: milkCont,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: _halfFat
                                        ? const Icon(Icons.brightness_medium)
                                        : const Icon(Icons.brightness_high),
                                    onPressed: () {
                                      setState(() {
                                        _halfFat = !_halfFat;

                                        milkExchange = _halfFat ? 3 : 6;

                                        controllerMap = {
                                          milkCont: [9, 6, milkExchange],
                                          breadCont: [15, 2, 0],
                                          fruitsCont: [15, 0, 0],
                                          nutsCont: [0, 2, 5],
                                          meatCont: [0, 6, 5],
                                          vegetablesCont: [6, 2, 0],
                                          fatsCont: [0, 0, 5],
                                          legumesCont: [15, 5, 0],
                                        };
                                      });
                                    },
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomField(
                        controller: breadCont,
                        fieldName: "bread",
                      ),
                      CustomField(
                        controller: fruitsCont,
                        fieldName: "fruits",
                      ),
                      CustomField(
                        controller: nutsCont,
                        fieldName: "nuts",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomField(
                        controller: meatCont,
                        fieldName: "meat",
                      ),
                      CustomField(
                        controller: vegetablesCont,
                        fieldName: "vegetables",
                      ),
                      CustomField(
                        controller: fatsCont,
                        fieldName: "fats oils",
                      ),
                      CustomField(
                        controller: legumesCont,
                        fieldName: "legumes",
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        clearFields();
                      },
                      child: const CustomTableText(
                        fontSize: 20,
                        text: "CLEAR",
                        fontWeight: FontWeight.w900,
                      )),
                  const SizedBox(width: 15),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.green),
                      onPressed: () {
                        calculate();
                      },
                      child: const CustomTableText(
                        fontSize: 20,
                        text: "CALCULATE",
                        fontWeight: FontWeight.w900,
                      ))
                ],
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Table(
                  border: TableBorder.all(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  children: [
                    //header row
                    const TableRow(
                      children: [
                        TableCell(child: Text("")),
                        TableCell(
                          child: CustomTableText(text: "Gram"),
                        ),
                        TableCell(child: CustomTableText(text: "Calori")),
                        TableCell(child: CustomTableText(text: "%")),
                      ],
                    ),
                    // CHO row
                    TableRow(
                      children: [
                        const TableCell(child: CustomTableText(text: "CHO")),
                        TableCell(
                          child:
                              CustomTableText(text: totalCarbMass.toString()),
                        ),
                        TableCell(
                            child: CustomTableText(
                                text: totalCarbEnergy.toString())),
                        TableCell(child: CustomTableText(text: carbCalRatio)),
                      ],
                    ),
                    // Protein Row
                    TableRow(
                      children: [
                        const TableCell(
                            child: CustomTableText(text: "Protein")),
                        TableCell(
                          child: CustomTableText(
                              text: totalProteinMass.toString()),
                        ),
                        TableCell(
                            child: CustomTableText(
                                text: totalProteinEnergy.toString())),
                        TableCell(child: CustomTableText(text: protCalRatio)),
                      ],
                    ),
                    // Fat Row
                    TableRow(
                      children: [
                        const TableCell(child: CustomTableText(text: "Fat")),
                        TableCell(
                          child: CustomTableText(text: totalFatMass.toString()),
                        ),
                        TableCell(
                            child: CustomTableText(
                                text: totalFatEnergy.toString())),
                        TableCell(child: CustomTableText(text: fatCalRatio)),
                      ],
                    ),
                    //total row
                    TableRow(
                      children: [
                        const TableCell(child: CustomTableText(text: "Total")),
                        TableCell(
                          child: CustomTableText(text: totalWeight.toString()),
                        ),
                        TableCell(
                            child:
                                CustomTableText(text: totalCalory.toString())),
                        const TableCell(child: CustomTableText(text: "%100")),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
