import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustemScreen extends StatelessWidget {
  CustemScreen({
    super.key,
    required this.TextTitle,
    required this.Controller,
    required this.maxLines,
    required this.hint,
    this.validator,
  });

  final String TextTitle;
  final TextEditingController Controller;

  final int maxLines;
  final String hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(

          TextTitle,
          style:
          Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),

        ),
        SizedBox(height: 8),
        TextFormField(
          controller: Controller,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelMedium,
          validator: validator,
          decoration: InputDecoration(
            hint: Text(
              hint,
            ),
          ),
        ),
      ],
    );
  }
}
