import 'package:flutter/material.dart';
import 'package:templator/types/field_config.dart';

class TextFieldGUIBuilder{
  //TODO: CRITICAL create unique patterns for each textfield
  TextFieldGUIBuilder();

  List<FieldConfig> requiredFields = [
    LabelledTextFieldConfig(
      keyword: "keyword",
    ),
    LabelledTextFieldConfig(
      keyword: "label",
    )
  ];

  List<FieldConfig> optionalFields = [
    LabelledTextFieldConfig(
      keyword: "hintText",
      label: "Hint Text",
    )
  ];

  Widget buildRequired() {
    //TODO: implement on value change and initvalue shenanigans
    return Column(
      children: requiredFields.map((f) {
        return f.buildWidget("TextFieldGUIBuilder");
      }).toList()
    );
  }

  Widget buildOptional() {
    return Column(
      children: optionalFields.map((f) {
        return f.buildWidget("TextFieldGUIBuilder");
      }).toList()
    );
  }
}