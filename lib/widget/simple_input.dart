import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  final TextEditingController edtTitle;
  final TextEditingController edtDescription;
  final VoidCallback buttonTap;
  final String buttonTitle;

  const SimpleInput(
      {super.key,
      required this.edtTitle,
      required this.edtDescription,
      required this.buttonTap,
      required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DInput(
          title: "Title",
          controller: edtTitle,
        ),
        const SizedBox(
          height: 15,
        ),
        DInput(
          title: "Description",
          controller: edtDescription,
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: buttonTap,
          child: Text(buttonTitle),
        )
      ],
    );
  }
}
