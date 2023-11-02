This package streamlines the task of formatting a number or string to your preferred style, allowing for customization according to your needs. It offers a convenient solution for achieving the desired format, including the flexibility to adjust the input size to meet your specific requirements. The length of the list determines the number of blocks, and the charsCount parameter specifies the number of characters in each specific block to meet the format.

![My Image Alt Text](https://drive.google.com/uc?export=view&id=1WSxz08RcPr2npL8JHHA417tYogHU_MzS)

## Installation

You can install this package by adding it to your `pubspec.yaml` file. Here's how:

```yaml
dependencies:
  your_package_name: ^1.0.0
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_input_formatter/flutter_input_formatter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Input Formatter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestFormatterScreen(),
    );
  }
}

class TestFormatterScreen extends StatefulWidget {
  const TestFormatterScreen({super.key});

  @override
  State<TestFormatterScreen> createState() => _TestFormatterScreenState();
}

class _TestFormatterScreenState extends State<TestFormatterScreen> {
  List<InputFormatter> emiratesIdFormatters = [
    InputFormatter(
      charsCount: 3,
      hintText: "XXX",
    ),
    InputFormatter(
      charsCount: 4,
      hintText: "XXXX",
    ),
    InputFormatter(
      charsCount: 7,
      hintText: "XXXXXXX",
    ),
    InputFormatter(
      charsCount: 1,
      hintText: "X",
    ),
  ];

  List<InputFormatter> pakistaniIdFormatter = [
    InputFormatter(
      charsCount: 5,
      hintText: "*****",
    ),
    InputFormatter(
      charsCount: 7,
      hintText: "*******",
    ),
    InputFormatter(
      charsCount: 1,
      hintText: "*",
    ),
  ];

  List<InputFormatter> usaIdFormatters = [
    InputFormatter(
      charsCount: 3,
      hintText: "XXX",
    ),
    InputFormatter(
      charsCount: 2,
      hintText: "XX",
    ),
    InputFormatter(
      charsCount: 4,
      hintText: "XXXX",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                "UAE Input formatter",
              ),
              const SizedBox(
                height: 10,
              ),
              _buildFormatter(
                size,
                emiratesIdFormatters,
                (String val) {
                  debugPrint(val);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Pakistan Input formatter",
              ),
              const SizedBox(
                height: 10,
              ),
              _buildFormatter(
                size,
                pakistaniIdFormatter,
                (String val) {
                  debugPrint(val);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "USA Input formatter",
              ),
              const SizedBox(
                height: 10,
              ),
              _buildFormatter(
                size,
                usaIdFormatters,
                (String val) {
                  debugPrint(val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormatter(Size size, List<InputFormatter> formatters, Function(String) onChange) {
    return FlutterInputFormatters(
      formatters: formatters,
      onChange: onChange,
      baseWidth: size.width * 0.03,
      margin: const EdgeInsetsDirectional.only(end: 5),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 2),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
        color: Colors.grey,
      ),
      cursorColor: Colors.black,
      borderColor: Colors.grey,
    );
  }
}

```

