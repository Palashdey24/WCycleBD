import 'package:flutter/material.dart';

class DropdownWidgets extends StatefulWidget {
  const DropdownWidgets(
      {super.key,
      required this.formFieldValidator,
      required this.dropLevel,
      required this.dropHint,
      required this.dropDownList,
      this.labelTxtColor});

  final FormFieldValidator<String> formFieldValidator;
  final String dropLevel;
  final String dropHint;
  final List<String> dropDownList;
  final Color? labelTxtColor;

  @override
  State<DropdownWidgets> createState() => _DropdownWidgetsState();
}

class _DropdownWidgetsState extends State<DropdownWidgets> {
  String? selectDiv;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        validator: widget.formFieldValidator,
        value: selectDiv,
        hint: Text(
          widget.dropHint,
          style: const TextStyle(color: Colors.black),
        ),
        style: const TextStyle(color: Colors.orangeAccent),
        //this line for DropDown Dialog background color or Radius
        dropdownColor: Colors.black,
        borderRadius: BorderRadius.circular(30),

        //Decoration refer for hint and other outer
        decoration: InputDecoration(
            label: Text(
              widget.dropLevel,
              style: TextStyle(color: widget.labelTxtColor ?? Colors.black),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        items: [
          for (var dropDowns in widget.dropDownList)
            DropdownMenuItem(
              value: dropDowns,
              child: Text(dropDowns),
            )
        ],
        onChanged: (value) {
          setState(() {
            selectDiv = value;
          });
        },
      ),
    );
  }
}
