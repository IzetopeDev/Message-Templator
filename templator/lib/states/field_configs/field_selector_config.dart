import 'package:flutter/material.dart';
import 'package:templator/states/field_configs/dropdown_field_config.dart';
import 'package:templator/types/field_config.dart';
import 'package:templator/states/field_configs/labelled_text_field_config.dart';
import 'package:templator/states/field_configs/selection_field_config.dart';

class FieldSelectorConfig extends FieldConfig<FieldConfig> {
  
  const FieldSelectorConfig({
    required super.uid, 
    required super.parentUid,
    super.keyword,
    super.label,
    super.onValueUpdate,
    super.initialValue, 
  });

  List<FieldConfig> get _options => [
    LabelledTextFieldConfig(
      uid: uid, 
      parentUid: parentUid,
    ),
    SelectionFieldConfig(
      uid: uid, 
      parentUid: parentUid, 
    ),
    DropdownFieldConfig(
      uid: uid, 
      parentUid: parentUid,
    )
  ];

  @override
  Widget buildEditorField({stateConfig}) {
    return DropdownFieldConfig<FieldConfig>(
      uid: uid, 
      parentUid: parentUid, 
      keyword: "FieldSelector",
      hintText: "Select Field",
      label: "Select Field",
      onValueUpdate: onValueUpdate ?? stateConfig?.onValueUpdate, //TODO: for other OVUs, need to see how copy with will be used....
      dropdownMenuEntries: _options.map((opt) {
        return DropdownMenuEntry(
          value: opt, 
          label: opt.runtimeType.toString()
        );
      })
      .toList(),
    )
    .buildFormField();
  }

  @override
  Widget buildFormField({stateConfig}) {
    // This should be dead code.
    return Placeholder();
  }

  @override
  List<Object?> get props => [
    super.uid,
    super.parentUid,
    super.keyword,
    super.label,
  ];

  @override
  FieldSelectorConfig copyWith({
    String? uid,
    String? parentUid,
    String? keyword,
    String? label,
    void Function(dynamic value)? onValueUpdate,
    FieldConfig? initialValue,
  }) {
    return FieldSelectorConfig(
      uid: uid ?? this.uid,
      parentUid: parentUid ?? this.parentUid,
      keyword: keyword ?? this.keyword,
      label: label ?? this.label,
      onValueUpdate: onValueUpdate ?? this.onValueUpdate,
      initialValue: initialValue ?? this.initialValue,
    );
  }
}