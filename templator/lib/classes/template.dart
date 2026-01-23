import 'dart:developer';

import 'package:flutter/material.dart';
import 'field.dart';

class Template {
  Template({
    required this.templateText, 
    required this.fields,
    required this.name,
  }) {
    log(
      "new Template instance ($name)",
      name: "DEBUG",
      level: 500
    );

    log(
      // ignore: prefer_adjacent_string_concatenation
      "template text: $templateText\n" +
      "fields: ${fields.map((f) => "${f.runtimeType}(${f.keyword})").toList()}\n",
      name: "DEBUG (-v)",
      level: 300,
    );
  }

  final String templateText;
  final List<Field> fields;
  final String name;

  List<Widget> buildWidget() {
    return fields.map((field) => field.buildWidget(name)).toList();
  }
}
