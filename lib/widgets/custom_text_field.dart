import 'package:diet_calculator/widgets/modified_text.dart';
import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final String fieldName;
  final TextEditingController controller;
  const CustomField({
    super.key,
    required this.controller,
    required this.fieldName,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: widget.fieldName,
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
              controller: widget.controller,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
