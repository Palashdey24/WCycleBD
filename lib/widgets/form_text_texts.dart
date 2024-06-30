import 'package:flutter/material.dart';

class FormTextTexts extends StatelessWidget {
  const FormTextTexts(
      {super.key,
      required this.txtInType,
      this.atCorrect,
      this.enSuggest,
      required this.labelTxt,
      required this.hint,
      required this.icons,
      required this.iconCol,
      required this.vaildator,
      this.obscure,
      required this.onSave,
      this.maxLen,
      this.intial});

  final TextInputType txtInType;
  final bool? atCorrect;
  final bool? enSuggest;
  final String labelTxt;
  final int? maxLen;
  final String hint;
  final IconData icons;
  final Color iconCol;
  final bool? obscure;
  final String? intial;
  final FormFieldValidator<String> vaildator;
  final void Function(String value) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      autocorrect: atCorrect ?? false,
      initialValue: intial,
      maxLength: maxLen,
      enableSuggestions: enSuggest ?? false,
      keyboardType: txtInType,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.all(0),
        errorBorder: InputBorder.none,
        fillColor: Colors.black,
        errorStyle: const TextStyle(
          color: Colors.redAccent,
        ),
        label: Text(labelTxt),
        hintText: hint,
        prefixIcon: Icon(
          icons,
          color: iconCol,
        ),
      ),
      validator: vaildator,
      onSaved: (newValue) => onSave(newValue!),
    );
  }
}
