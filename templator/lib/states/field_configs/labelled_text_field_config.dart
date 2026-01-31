import 'package:flutter/material.dart';
import 'package:templator/models/labelled_text_field_widget.dart';
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
  
  @override
  Widget buildEditorField({stateConfig}) {
    // TODO: implement buildEditorField
    throw UnimplementedError();
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
    void Function(String? value)? onValueUpdate,
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