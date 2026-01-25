import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:templator/providers/template_form_notifier.dart';
import 'field_config.dart';

class TemplateBuilder {
  
  final String templateText;
  final List<FieldConfig> fields;
  final String name;

  TemplateBuilder({
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

  List<Widget> buildWidgets(
    TemplateFormNotifier notifier, 
    Map<String, dynamic> fieldValues,
  ) {

    return fields.map((field) {
      return field.buildWidget(
        name,  
        initialValue: fieldValues[field.keyword],
        callback: (value) {
          log(
            "User updated field (${field.keyword}): $value",
            name: "INFO",
            level: 800,
          );
          notifier.updateField(field.keyword, value);
        }
      );
    })
    .toList();
  }
}
