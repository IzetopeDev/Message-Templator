import 'package:flutter/material.dart';
import 'package:templator/models/option_editor_field.dart';
import 'package:templator/models/selection_field_widget.dart';
import 'package:templator/states/field_configs/labelled_text_field_config.dart';
import 'package:templator/types/exceptions.dart';
import 'package:templator/types/field_config.dart';

class SelectionFieldConfig extends FieldConfig<List<String?>> {
  
  final List<String?> options;

  const SelectionFieldConfig({
    required super.uid,
    required super.parentUid,
    super.keyword,
    super.label,
    super.onValueUpdate,
    super.initialValue,
    this.options = const [null],
  });

  void _toNewConfig({
    required String keyword, 
    required dynamic value,
    required void Function(dynamic value)? onValueUpdate,
  }) {
    Map<String, dynamic> keywordMap = {keyword: value};
    var newFieldConfig = copyWith(
      keyword: keywordMap["keyword"] ?? this.keyword,
      label: keywordMap["label"] ?? label,
      options: keywordMap["options"] ?? options,
    );

    onValueUpdate?.call(newFieldConfig);

  }

  @override
  Widget buildEditorField({stateConfig}) {
    return Column(
      children: [
        LabelledTextFieldConfig(
          uid: uid, 
          parentUid: parentUid,
          keyword: "keyword",
          initialValue: keyword,
          onValueUpdate: (value) { 
            _toNewConfig(
              keyword: "keyword",
              value: value,
              onValueUpdate: stateConfig?.onValueUpdate,
            );
          },
        ).buildFormField(),
        LabelledTextFieldConfig(
          uid: uid, 
          parentUid: parentUid,
          keyword: "label",
          initialValue: label,
          onValueUpdate: (value) { 
            _toNewConfig(
              keyword: "label",
              value: value,
              onValueUpdate: stateConfig?.onValueUpdate,
            );
          },
        ).buildFormField(),
        OptionEditorField(
          options: options,
          onChanged: (value) {
            _toNewConfig(
              keyword: "options",
              value: value,
              onValueUpdate: stateConfig?.onValueUpdate,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget buildFormField({stateConfig}) {
    if (
      stateConfig.runtimeType != SelectionFieldConfig
      && stateConfig != null
    ) {
      throw UnpredictedException(context: "building form field for $this");
    }

    return SelectionFieldWidget(
      stateConfig as SelectionFieldConfig?
      ?? this
    );
  }

  @override
  List<Object?> get props => [
    super.uid,
    super.parentUid,
    super.keyword,
    super.label,
    options,
  ];

  @override
  SelectionFieldConfig copyWith({
    String? uid,
    String? parentUid,
    String? keyword,
    String? label,
    void Function(dynamic value)? onValueUpdate,
    List<String?>? initialValue,
    List<String?>? options,

  }) {
    return SelectionFieldConfig(
      uid: uid ?? this.uid,
      parentUid: parentUid ?? this.parentUid,
      keyword: keyword ?? this.keyword,
      label: label ?? this.label,
      onValueUpdate: onValueUpdate ?? this.onValueUpdate,
      initialValue: initialValue ?? this.initialValue,
      options: options ?? this.options,
    );
  }
}

