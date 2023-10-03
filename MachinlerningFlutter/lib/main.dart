import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String? selectedComputerTypeValue;
  String? selectedCorIValue;
  String? selectedGenerationValue;
  String? selectedFirstHardDriveTypeValue;
  String? selectedFirstHardDriveSizeValue;
  String? selectedSecondHardDriveTypeValue;
  String? selectedSecondHardDriveSizeValue;
  String? selectedRamSizeValue;
  String? selectedBatteryLifeValue;
  String? selectedScreenSizeValue;
  String? selectedScreenTypeValue;
  String? selectedGraphicCardTypeValue;
  String? selectedLaptopCaseValue;
  String? predictedPrice = '';
  bool allFieldsFilled = false;


  void _showPriceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Predicted Price',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Text(
                'The predicted price is:',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '\$$predictedPrice',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Machine Learning Form',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTwoFieldsInRow(
              buildDropdown(
                'Computer Type',
                ['HP', 'LENOVO', 'ASUS', 'TOSHIBA', 'DELL', 'MSI', 'ACER'],
                selectedComputerTypeValue,
                    (String? newValue) {
                  setState(() {
                    selectedComputerTypeValue = newValue;
                  });
                },
              ),
              buildDropdown(
                'COR I',
                ['Core 3', 'Core 5', 'Core 7', 'Core 9'],
                selectedCorIValue,
                    (String? newValue) {
                  setState(() {
                    selectedCorIValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            buildTwoFieldsInRow(
              buildDropdown(
                'Generation',
                ['4', '5', '6', '7', '8', '9', '10', '11', '12', '13'],
                selectedGenerationValue,
                    (String? newValue) {
                  setState(() {
                    selectedGenerationValue = newValue;
                  });
                },
              ),
              buildDropdown(
                '1st Hard Drive Type',
                ['HDD', 'SSD'],
                selectedFirstHardDriveTypeValue,
                    (String? newValue) {
                  setState(() {
                    selectedFirstHardDriveTypeValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            buildTwoFieldsInRow(
              buildDropdown(
                '1st Hard Drive Size',
                ['240 GB', '256 GB', '512 GB', '325 GB', '1 T'],
                selectedFirstHardDriveSizeValue,
                    (String? newValue) {
                  setState(() {
                    selectedFirstHardDriveSizeValue = newValue;
                  });
                },
              ),
              buildDropdown(
                '2nd Hard Drive Type (if available)',
                ['HDD', 'SSD', 'Nothing'],
                selectedSecondHardDriveTypeValue,
                    (String? newValue) {
                  setState(() {
                    selectedSecondHardDriveTypeValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            buildTwoFieldsInRow(
              buildDropdown(
                '2nd Hard Drive Size (if any)',
                ['240 GB', '256 GB', '512 GB', '325 GB', '1 T', 'Nothing'],
                selectedSecondHardDriveSizeValue,
                    (String? newValue) {
                  setState(() {
                    selectedSecondHardDriveSizeValue = newValue;
                  });
                },
              ),
              buildDropdown(
                'RAM Size',
                ['4', '8', '12', '16', '32'],
                selectedRamSizeValue,
                    (String? newValue) {
                  setState(() {
                    selectedRamSizeValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            buildTwoFieldsInRow(
              buildDropdown(
                'Battery Life',
                ['HOUERS 1', 'HOUERS 2', 'HOUERS 3', 'HOUERS 4', 'HOUERS 8'],
                selectedBatteryLifeValue,
                    (String? newValue) {
                  setState(() {
                    selectedBatteryLifeValue = newValue;
                  });
                },
              ),
              buildDropdown(
                'Screen Size',
                ['INCH 13', 'INCH 14', 'INCH 15.6', 'INCH 17.3'],
                selectedScreenSizeValue,
                    (String? newValue) {
                  setState(() {
                    selectedScreenSizeValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            buildTwoFieldsInRow(
              buildDropdown(
                'Screen Type',
                ['HD', 'FHD'],
                selectedScreenTypeValue,
                    (String? newValue) {
                  setState(() {
                    selectedScreenTypeValue = newValue;
                  });
                },
              ),
              buildDropdown(
                'Graphic Card Type',
                ['MX330', 'MX150','Built-in', 'MX100', 'MX940', 'GTX1060', 'GTX1660', 'GTX1050', 'RTX3080', 'RTX3070', 'RTX3060', 'RTX3050', 'RTX30', 'RTX2060'],
                selectedGraphicCardTypeValue,
                    (String? newValue) {
                  setState(() {
                    selectedGraphicCardTypeValue = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            buildDropdown(
              'Laptop Case',
              ['Used', 'New'],
              selectedLaptopCaseValue,
                  (String? newValue) {
                setState(() {
                  selectedLaptopCaseValue = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (
                    selectedCorIValue != null &&
                    selectedGenerationValue != null &&
                    selectedFirstHardDriveTypeValue != null &&
                    selectedFirstHardDriveSizeValue != null &&
                    selectedRamSizeValue != null &&
                    selectedBatteryLifeValue != null &&
                    selectedScreenSizeValue != null &&
                    selectedScreenTypeValue != null &&
                    selectedGraphicCardTypeValue != null &&
                    selectedLaptopCaseValue != null) {
                final Map<String, dynamic> requestData = {
                  "data": {
                    "CORI": int.parse(selectedCorIValue!.replaceAll('Core ', '')),
                    "Generation": int.parse(selectedGenerationValue!),
                    "firstHardType": selectedFirstHardDriveTypeValue,
                    "firstHardSize": selectedFirstHardDriveSizeValue,
                    "SizeRam": int.parse(selectedRamSizeValue!),
                    "BatteryLife": selectedBatteryLifeValue,
                    "ScreenSize": selectedScreenSizeValue,
                    "ScreenType": selectedScreenTypeValue,
                    "GraphicCardType": selectedGraphicCardTypeValue,
                    "laptopCase": selectedLaptopCaseValue,
                  }
                };
                print(requestData);
                final response = await http.post(
                  Uri.parse('http://localhost:8000/predict_price'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(requestData),
                );

                if (response.statusCode == 200) {
                  final Map<String, dynamic> responseData = jsonDecode(response.body);
                  final double predictedPriceValue = responseData['predicted_price'];
                  setState(() {
                    predictedPrice = predictedPriceValue.toStringAsFixed(2);
                  });
                  _showPriceDialog(context);
                } else {
                  print('Failed to send data. Error code: ${response.statusCode}');
                }
              }else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Fill in the data, there is empty data.',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).brightness == Brightness.dark ? Colors.brown : Colors.blue,
                onPrimary: Colors.white,
              ),
              child: Text(
                'Send Data',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> options, String? selectedValue, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: options.map<DropdownMenuItem<String>>((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.brown),
        ),
        filled: true,
        fillColor: Colors.brown,
        labelStyle: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget buildTwoFieldsInRow(Widget field1, Widget field2) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: field1,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10.0),
            child: field2,
          ),
        ),
      ],
    );
  }
}
