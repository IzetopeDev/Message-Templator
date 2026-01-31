import 'package:flutter/material.dart';
import 'package:templator/types/field_config.dart';

abstract class EditorFieldConfig {

  const EditorFieldConfig();

  List<FieldConfig> get requiredFields;
  List<FieldConfig> get optionalFields;

  Widget buildWidgets({
    required String templateName, 
    bool showOptional = false
  }) {

    List<FieldConfig> fields = [];
    fields.addAll(requiredFields);
    fields.addAll(showOptional ? optionalFields : []);

    return Column(
      children: fields.map((f) {
        return f.buildFormField();
      }).toList()
    );
  }
}

class TextEditorFieldConfig extends EditorFieldConfig{
  const TextEditorFieldConfig();

  @override
  List<FieldConfig<dynamic>> get requiredFields => throw UnimplementedError();

  @override
  List<FieldConfig<dynamic>> get optionalFields => throw UnimplementedError();
}

class SelectionEditorFieldConfig extends EditorFieldConfig {
  const SelectionEditorFieldConfig();

  @override
  List<FieldConfig<dynamic>> get requiredFields => throw UnimplementedError();

  @override
  List<FieldConfig<dynamic>> get optionalFields => throw UnimplementedError();

}

class DropdownEditorFieldConfig extends EditorFieldConfig {
  const DropdownEditorFieldConfig();

  @override
  List<FieldConfig<dynamic>> get requiredFields => throw UnimplementedError();

  @override
  List<FieldConfig<dynamic>> get optionalFields => throw UnimplementedError();
}

enum FieldType {
  labelledTextField("Text Field", TextEditorFieldConfig()),
  selectionField("Selection Field", SelectionEditorFieldConfig()),
  dropdownField("Dropdown Field", DropdownEditorFieldConfig());

  final String? name;
  final EditorFieldConfig fieldGUIBuilder;

  const FieldType(
    this.name,
    this.fieldGUIBuilder,
  );
}
