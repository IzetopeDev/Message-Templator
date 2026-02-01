import 'package:flutter/material.dart';
import 'package:templator/models/selection_field_widget.dart';
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
    this.options = const [],
  });

  @override
  Widget buildEditorField({stateConfig}) {
    // TODO: implement buildEditorField
    throw UnimplementedError();
  }

  @override
  Widget buildFormField({stateConfig}) {
    return SelectionFieldWidget(
      this,
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
    List<String>? options,

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