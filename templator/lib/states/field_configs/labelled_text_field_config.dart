import 'package:flutter/material.dart';
import 'package:templator/models/labelled_text_field_widget.dart';
import 'package:templator/states/field_configs/selection_field_config.dart';
import 'package:templator/types/field_config.dart';

class LabelledTextFieldConfig extends FieldConfig<String> {
  
  final bool isLast;

  const LabelledTextFieldConfig({
    required super.uid,
    required super.parentUid,
    super.keyword,
    super.label,
    super.onValueUpdate,
    super.initialValue,
    this.isLast = false,
  });
  
  void _toFieldConfig({
    required String keyword, 
    required dynamic value,
    required void Function(dynamic value)? onValueUpdate,
  }) {
    Map<String, dynamic> keywordMap = {keyword: value};
    var newFieldConfig = copyWith(
      keyword: keywordMap["keyword"] ?? this.keyword,
      label: keywordMap["label"] ?? label,
      initialValue: keywordMap["initialValue"] ?? initialValue,
      isLast: keywordMap["isLast"] ?? isLast,
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
            _toFieldConfig(
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
            _toFieldConfig(
              keyword: "label",
              value: value,
              onValueUpdate: stateConfig?.onValueUpdate,
            );
          },
        ).buildFormField(),
        LabelledTextFieldConfig(
          uid: uid, 
          parentUid: parentUid,
          keyword: "initial value",
          label: "inital value",
          initialValue: initialValue,
          onValueUpdate: (value) { 
            _toFieldConfig(
              keyword: "initialValue",
              value: value,
              onValueUpdate: stateConfig?.onValueUpdate,
            );
          },
        ).buildFormField(),
        SelectionFieldConfig(
          uid: uid, 
          parentUid: parentUid,
          label: "last text field?",
          options: ["yes", "no"],
          onValueUpdate: (value) { 
            bool actualVal = value == "yes" ? true : false;

            _toFieldConfig(
              keyword: "isLast",
              value: actualVal,
              onValueUpdate: stateConfig?.onValueUpdate,
            );
          },
        ).buildFormField()
      ],
    );
  }

  @override
  Widget buildFormField({stateConfig}) {
    return LabelledTextFieldWidget(this);
  }

  @override
  List<Object?> get props => [
    super.uid,
    super.parentUid,
    super.keyword,
    super.label,
    isLast,
  ];

  @override
  LabelledTextFieldConfig copyWith({
    String? uid,
    String? parentUid,
    String? keyword,
    String? label,
    void Function(dynamic value)? onValueUpdate,
    String? initialValue,
    bool? isLast,
  }) {
    return LabelledTextFieldConfig(
      uid: uid ?? this.uid,
      parentUid: parentUid ?? this.parentUid,
      keyword: keyword ?? this.keyword,
      label: label ?? this.label,
      onValueUpdate: onValueUpdate ?? this.onValueUpdate,
      initialValue: initialValue ?? this.initialValue,
      isLast: isLast ?? this.isLast,
    );
  }
}