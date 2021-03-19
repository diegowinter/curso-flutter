import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function() onSubmitted;
  final String label;

  AdaptativeTextField({
    @required this.controller,
    @required this.onSubmitted,
    @required this.label,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
      ? Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CupertinoTextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: (_) => onSubmitted,
            placeholder: label,
            padding: EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12
            ),
          ),
      )
      : TextField(
          controller: controller,
          keyboardType: keyboardType,
          onSubmitted: (_) => onSubmitted,
          decoration: InputDecoration(labelText: label)
        );
  }
}