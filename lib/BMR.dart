import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firstApp/components/bottom_button.dart';
import 'package:firstApp/components/icon_content.dart';
import 'package:firstApp/components/reusable_card.dart';
import 'package:firstApp/components/round_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstApp/constants.dart';
import 'package:firstApp/BMRresult.dart';
// import 'result_screen.dart';

enum Gender {
  male,
  female,
}

class BMRCalculatorScreen extends StatefulWidget {
  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<BMRCalculatorScreen> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;
  double bmr, calc;
  String dropdownValue = "Sendentary";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAlORIE COUNTER'),
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  colour: selectedGender == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  colour: selectedGender == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(
                                  () {
                                    age--;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kActiveCardColour,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text("ACTIVITY",
                      textAlign: TextAlign.center, style: kLabelTextStyle),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        items: [
                          DropdownMenuItem(
                            child: Text("Sendentary : little or No Exercise"),
                            value: "Sendentary",
                          ),
                          DropdownMenuItem(
                            child: Text("Light : Exercise 1-3 times per week "),
                            value: "Light",
                          ),
                          DropdownMenuItem(
                              child: Text(
                                  "Moderate : Exercise 4-5 times per week"),
                              value: "Moderate"),
                          DropdownMenuItem(
                              child: Text(
                                  "Active : intence Exercise 6-7 times per week"),
                              value: "Active"),
                          DropdownMenuItem(
                              child: Text(
                                  "Very Active :  Very intence Exercise daily or physical Job"),
                              value: "Very Active"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              // BmiLogic calc = BmiLogic(height: height, weight: weight);
              if (selectedGender == Gender.male) {
                bmr = 5 + (10 * weight) + 6.25 * height - 5 * age;
              }
              if (selectedGender == Gender.female) {
                bmr = (10 * weight) + 6.25 * height - 5 * age - 161;
              }
              if (dropdownValue == "Sendentary") {
                calc = bmr * 1.2;
              }
              if (dropdownValue == "Light") {
                calc = bmr * 1.375;
              }
              if (dropdownValue == "Moderate") {
                calc = bmr * 1.55;
              }
              if (dropdownValue == "Active") {
                calc = bmr * 1.725;
              }
              if (dropdownValue == "Very Active") {
                calc = bmr * 1.9;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BMRResultsPage(
                    calc,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
