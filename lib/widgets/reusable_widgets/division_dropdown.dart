import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/division_data.dart';

class DivisionDropdown extends StatefulWidget {
  const DivisionDropdown(
      {super.key,
      required this.formFieldValidator,
      required this.onDropdownFn,
      required this.dropLevel,
      required this.dropHint});

  final void Function(String value) onDropdownFn;
  final FormFieldValidator<String> formFieldValidator;
  final String dropLevel;
  final String dropHint;

  @override
  State<DivisionDropdown> createState() => _DivisionDropdownState();
}

class _DivisionDropdownState extends State<DivisionDropdown> {
  String? selectDiv;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: widget.formFieldValidator,
      value: selectDiv,
      hint: Text(
        widget.dropHint,
        style: const TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.orangeAccent),
      //this line for DropDown Dialog background color or Radius
      dropdownColor: Colors.black,
      borderRadius: BorderRadius.circular(30),

      //Decoration refer for hint and other outer
      decoration: InputDecoration(
          label: Text(
            widget.dropLevel,
            style: const TextStyle(color: Colors.white),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      items: [
        for (var divisions in division)
          DropdownMenuItem(
            value: divisions,
            child: Text(divisions),
          )
      ],
      onChanged: (value) {
        setState(() {
          selectDiv = value;
        });
      },
    );
  }
}
