import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:templator/models/labelled_text_field_widget.dart';
import 'package:templator/models/selection_field_widget.dart';
import 'package:templator/models/dropdown_field_widget.dart';

enum FieldType {
  labelledTextField("Text Field"),
  selectionField("Selection Field"),
  dropdownField("Dropdown Field");
  
  final String name;

  const FieldType(this.name);
}

abstract class FieldConfig<T> {
  final String keyword;
  final String? label;
  T? initialValue;

  FieldConfig({required this.keyword, this.label, this.initialValue}) {
    log(
      "new $runtimeType ($keyword)",
      name: "DEBUG",
      level: 500,
    );

    final rawContent = "props($keyword)\n$props";

    // ignore: prefer_interpolation_to_compose_strings
    final taggedContent = rawContent.replaceAll('\n', ' (-v)\n') + ' (-v)';

    log(
      taggedContent,
      name: "DEBUG", // The tag is now inside the message lines
      level: 300,
    );
  }

  String get props => "keyword: $keyword,\nlabel: $label,\ninitialValue: $initialValue";

  Widget buildWidget(
    String parentName, {
    void Function(T? value)? callback,
    T? initialValue,
  });
}

class LabelledTextFieldConfig extends FieldConfig<String> {
  
  final bool isLast;
  void Function(String value)? onStoppedTyping;

  LabelledTextFieldConfig({
    required super.keyword, 
    super.label, 
    super.initialValue,
    this.isLast = false,
    this.onStoppedTyping,
  });

  @override
  String get props {
    return "${super.props}\nisLast: $isLast";
  }

  @override
  Widget buildWidget(parentName, {callback, initialValue}) {

    if (callback != null) onStoppedTyping = callback;
    if (initialValue != null) super.initialValue = initialValue;

    return LabelledTextFieldWidget(this, key: ValueKey("$parentName:$keyword"),);
  }
}

class SelectionFieldConfig extends FieldConfig<List<String>> {
  
  final List<String> options;
  void Function(List<String> selectedOptions)? onChanged;

  SelectionFieldConfig({
    required super.keyword, 
    required this.options, 
    super.initialValue,
    super.label, 
    this.onChanged,
  });


  @override
  String get props {
    return "${super.props}\noptions: $options";
  }


  @override
  Widget buildWidget(parentName, {callback, initialValue}) {

    if (callback != null) onChanged = callback;
    if (initialValue != null) super.initialValue = initialValue;

    return SelectionFieldWidget(this, key: ValueKey("$parentName:{{$keyword}}"),);
  }

}

class DropdownFieldConfig<T> extends FieldConfig<T> {

  final List<T> options;
  final String? hintText;
  void Function(T? value)? onSelected;

  DropdownFieldConfig({
    required super.keyword,
    required this.options,
    super.initialValue,
    super.label,
    this.hintText,
    this.onSelected,
  });
  
  @override
  String get props {
    // ignore: prefer_adjacent_string_concatenation
    return "${super.props},\nhintText: $hintText,\noptions: $options";
  }

  @override
  Widget buildWidget(parentName, {callback, initialValue}) {

    if (callback != null) onSelected = callback;
    if (initialValue != null) super.initialValue = initialValue;

    return DropdownFieldWidget<T>(
      this, 
      key: ValueKey("$parentName:{{$keyword}}"),
    );
  }

}
