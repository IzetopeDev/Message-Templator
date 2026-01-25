import 'package:flutter/material.dart';
import 'package:templator/types/field_config.dart';
import 'package:templator/types/field_editor.dart';

class FieldSelectorWidget extends StatelessWidget {
  const FieldSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DropdownFieldConfig<String>(
            keyword: "FieldSelector", 
            options: FieldType.values.map((f) => f.name).toList(),
            hintText: "Select",
            initialValue: null,
            label: "Field Type"
          ).buildWidget("FieldSelector"),
          TextFieldGUIBuilder().buildRequired(),
          TextFieldGUIBuilder().buildOptional(),
        ],
      )
    );
  }
}