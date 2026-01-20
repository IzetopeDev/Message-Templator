import 'package:flutter/material.dart';
import 'package:templator/models/labelled_text_field_widget.dart';
import 'package:templator/models/selection_field_widget.dart';

abstract class Field<T> {
  Field({required this.keyword, this.label});

  final String keyword;
  final String? label;

  T? value;

  void assignFieldValue(T userVal) {
    value = userVal;
  }

  Widget buildWidget();
}

class LabelledTextField extends Field<String> {
  LabelledTextField({required super.keyword, super.label, this.isLast = false});

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
  SelectionField({required super.keyword, required this.options, super.label});

  List<String> options;

  @override
  get value => super.value as List<String>;

  @override
  Widget buildWidget() {
    return SelectionFieldWidget(
      options,
      label: label,
      onSelected: assignFieldValue,
    );
  }
}
