import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.hintedtext,
    required this.labeltext,
    required this.inputController,
  });

  final String hintedtext;
  final String labeltext;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextFormField(
        controller: inputController,
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value!.isEmpty) {
            return "$labeltext is required";
          }
        },
        decoration: InputDecoration(
            hintText: hintedtext,
            labelText: labeltext,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Color(0xFF50CDD1)),
                borderRadius: BorderRadius.circular(60.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Color(0xFF50CDD1)),
                borderRadius: BorderRadius.circular(60.0)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.red),
                borderRadius: BorderRadius.circular(60.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.red),
                borderRadius: BorderRadius.circular(60.0)),
            labelStyle: const TextStyle(
              color: Color(0xFF50CDD1), // Ganti dengan warna yang diinginkan
            )),
      ),
    );
  }
}
