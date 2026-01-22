import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:templator/models/labelled_text_field_widget.dart';
import 'package:templator/models/selection_field_widget.dart';
import 'package:templator/models/side_labelled_dropdown_widget.dart';

abstract class Field<T> {
  Field({required this.keyword, this.label});

  final String keyword;
  final String? label;

  T? value;
  Timer? _debounceTimer;

  void assignFieldValue(T? userVal) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      value = userVal;

      log(
        "user update Field ($keyword) with value: $value", 
        name: "INFO", 
        level: 800
      );
    });
  }

  Widget buildWidget();
}

class LabelledTextField extends Field<String> {
  LabelledTextField({required super.keyword, super.label, this.isLast = false}) {
    log(
      "new LabelledTextField instance ($keyword)",
      name: "DEBUG",
      level: 500
    );
    
    log(
      "label: $label, is last?: $isLast",
      name: "DEBUG (-v)",
      level: 300
    );
  }

  bool isLast;

  @override
  Widget buildWidget() {
    return LabelledTextFieldWidget(
      label ?? keyword,
      isLast: isLast,
      onChanged: assignFieldValue,
    );
  }
}

class SelectionField extends Field<List<String>> {
  SelectionField({required super.keyword, required this.options, super.label}) {
   log(
      "new SelectionField instance ($keyword)",
      name: "DEBUG",
      level: 500
    );
    
    log(
      // ignore: prefer_adjacent_string_concatenation
      "label: $label\n" +
      "options: ${options.toList()}",
      name: "DEBUG (-v)",
      level: 300
    ); 
  }

  List<String> options;

  @override
  Widget buildWidget() {
    return SelectionFieldWidget(
      options,
      label: label,
      onSelected: assignFieldValue,
    );
  }
}

class DropdownField<T> extends Field<T> {

  DropdownField({
    required super.keyword,
    required this.options,
    this.defaultOption,
    super.label,
    this.hintText,
  }){
    log(
      "new DropdownField instance ($keyword)",
      name: "DEBUG",
      level: 500
    );
    log(
      "templates: ${options.toList()}}" +
      "this.defaultTemplate",
      name: "DEBUG (-v)",
      level: 300
    );
  }

  List<T> options;
  T? defaultOption;
  String? hintText;
  
  @override
  Widget buildWidget() {
    return SideLabelledDropdownMenuWidget(
      options, 
      sideLabel: label ?? keyword,
      defaultOption: defaultOption,
      hintText: hintText,
      onSelected: assignFieldValue,
    );
  }

}
