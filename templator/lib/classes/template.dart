import 'package:flutter/material.dart';
import 'field.dart';

class Template {
  Template({required this.templateText, required this.fields});

  final String templateText;
  final List<Field> fields;

  List<Widget> createWidgetsByFieldType() {
    return fields.map((field) => field.buildWidget()).toList();
  }
}
