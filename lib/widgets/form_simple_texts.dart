import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

class FormSimpleTexts extends StatelessWidget {
  const FormSimpleTexts(
      {super.key,
      required this.txtInType,
      this.atCorrect,
      this.enSuggest,
      this.labelTxt,
      required this.hint,
      this.icons,
      this.iconCol,
      required this.validator,
      this.obscure,
      required this.onSave,
      this.maxLen,
      this.intial,
      this.enabled});

  final TextInputType txtInType;
  final bool? atCorrect;
  final bool? enSuggest;
  final String? labelTxt;
  final int? maxLen;
  final String hint;
  final IconData? icons;
  final Color? iconCol;
  final bool? obscure;
  final String? intial;
  final FormFieldValidator<String> validator;
  final void Function(String value) onSave;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      autocorrect: atCorrect ?? false,
      initialValue: intial,
      maxLength: maxLen,
      enableSuggestions: enSuggest ?? false,
      keyboardType: txtInType,
      style: FontHelper().bodySmall(context),
      obscureText: obscure ?? false,
      enabled: enabled ?? true,
      decoration: InputDecoration(
        filled: false,
        counterText: "",
        hintStyle: FontHelper().bodySmall(context).copyWith(
            fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
        contentPadding: const EdgeInsets.all(10),
        errorBorder: InputBorder.none,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.green,
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )),
        fillColor: Colors.transparent,
        focusColor: Colors.transparent,
        errorStyle: const TextStyle(
          color: Colors.redAccent,
        ),
        label: labelTxt != null
            ? Text(
                labelTxt!,
                style: FontHelper()
                    .bodySmall(context)
                    .copyWith(color: Colors.black26),
              )
            : null,
        hintText: hint,
        prefixIcon: icons != null
            ? Icon(
                icons,
                color: iconCol,
              )
            : null,
      ),
      validator: validator,
      onSaved: (newValue) => onSave(newValue!),
    );
  }
}
