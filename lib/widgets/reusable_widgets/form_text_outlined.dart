import 'package:flutter/material.dart';

class FormTextOutlined extends StatelessWidget {
  const FormTextOutlined(
      {super.key,
      this.onSave,
      this.maxLen,
      required this.iconData,
      required this.fieldlabel,
      required this.fieldHint,
      required this.fieldType,
      this.obsecureTXt,
      this.intValue,
      required this.vaildator,
      this.maxLines,
      this.isEnable});

  final IconData iconData;
  final String fieldlabel;
  final String fieldHint;
  final int? maxLen;
  final TextInputType fieldType;
  final bool? obsecureTXt;
  final String? intValue;
  final int? maxLines;
  final FormFieldValidator<String> vaildator;
  final void Function(String value)? onSave;
  final bool? isEnable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (e) => FocusScope.of(context).unfocus(),
      style: const TextStyle(color: Colors.black),
      maxLength: maxLen ?? 256,
      keyboardType: fieldType,
      maxLines: maxLines,
      obscureText: obsecureTXt ?? false,
      initialValue: intValue,
      enabled: isEnable,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(.1),
        counterText: maxLen == null ? '' : null,
        prefixIcon: Icon(
          iconData,
          color: Colors.blue,
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            gapPadding: 10,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            gapPadding: 10,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        label: Text(fieldlabel),
        hintText: fieldHint,
      ),
      validator: vaildator,
      onSaved: onSave != null ? (newValue) => onSave!(newValue!) : null,
    );
  }
}
