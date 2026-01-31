import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:templator/providers/active_template_notifier.dart';
import '../types/field_config.dart';

class TemplateBuilder {
  final String uid;
  final String? name;
  final String? templateText;

  /// String refers to uid
  final Map<String, FieldConfig> formFieldConfigs;
  final List<String> fieldOrder;

  const TemplateBuilder({
    required this.uid,
    this.name,
    this.templateText,
    this.formFieldConfigs = const {},
    this.fieldOrder = const [],
  });


  List<Widget> buildEditorFields({ActiveTemplateNotifier? activeTemplateNotifier}) {

    List<Widget> widgets = [];
    for (FieldConfig fc in formFieldConfigs.values) {

      FieldConfig stateConfig = fc.copyWith(
        onValueUpdate: (value) => activeTemplateNotifier?.updateFieldConfig(value),
      );

      log("stateConfig :>> $stateConfig", name: "TemplateBuilder");

      widgets.add(
        Card(
          child: fc.buildEditorField(stateConfig: stateConfig)
        )
      );
    }

    // TODO: replace Placeholder for no fields
    if (widgets.isEmpty) widgets= [Placeholder()]; 
    return widgets;
  }


  List<Widget> buildFormFields({ActiveTemplateNotifier? activeTemplateNotifier}) {

    List<Widget> widgets = [];
    for (FieldConfig fc in formFieldConfigs.values) {
      FieldConfig stateConfig = fc.copyWith(
        onValueUpdate: (value) => activeTemplateNotifier?.updateFormResponse(
          uid: fc.uid, 
          value: value,
        ),
      );

      widgets.add(
        Card(
          child: fc.buildEditorField(stateConfig: stateConfig)
        )
      );
    }

    // TODO: replace Placeholder for no fields
    if (widgets.isEmpty) widgets= [Text("Select your template to generate fields!")]; 
    return widgets;
  }


  TemplateBuilder copyWith({
    String? uid,
    String? name,
    String? templateText,
    Map<String, FieldConfig>? formFieldConfigs,
    List<String>? fieldOrder,
  }) {
    return TemplateBuilder(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      templateText: templateText ?? this.templateText,
      formFieldConfigs: formFieldConfigs ?? this.formFieldConfigs,
      fieldOrder: fieldOrder ?? this.fieldOrder,
    );
  }
}