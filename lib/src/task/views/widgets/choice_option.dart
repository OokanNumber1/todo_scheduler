import 'package:flutter/material.dart';

class ChoiceOption extends StatefulWidget {
  ChoiceOption({required this.isSelected, required this.label, Key? key})
      : super(key: key);
  final String label;
  bool isSelected;

  @override
  State<ChoiceOption> createState() => _ChoiceOptionState();
}

class _ChoiceOptionState extends State<ChoiceOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.isSelected = !widget.isSelected;
      }),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(4),
        child: Text(
          widget.label,
          style:
              TextStyle(color: widget.isSelected ? Colors.white : Colors.black),
        ),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.lightBlue[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}