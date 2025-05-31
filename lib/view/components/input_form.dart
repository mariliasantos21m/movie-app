import 'package:flutter/material.dart';
import 'package:movie_app/app_colors.dart';

class InputForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? messageError;
  final int maxLines;

  const InputForm({
    super.key,
    required this.controller,
    required this.label,
    this.messageError = "Campo obrigatório",
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        maxLines: maxLines,
        style: TextStyle(color: AppColors.text),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.subTitle),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.subTitle),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryDark),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return messageError;
          }
          return null;
        },
      ),
    );
  }
}
