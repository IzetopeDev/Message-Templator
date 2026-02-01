import 'package:flutter/material.dart';
import 'package:templator/models/dropdown_field_widget.dart';
import 'package:templator/types/field_config.dart';

class DropdownFieldConfig<T> extends FieldConfig<T> {

  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final String? hintText;

  const DropdownFieldConfig({
    required super.uid,
    required super.parentUid,
    super.keyword,
    super.label,
    super.onValueUpdate,
    super.initialValue,
    this.dropdownMenuEntries = const [],
    this.hintText,
  });

  @override
  Widget buildEditorField({stateConfig}) {
    // TODO: implement buildEditorField
    throw UnimplementedError();
  }

  @override
  Widget buildFormField({stateConfig}) {

    return DropdownFieldWidget<T>(this);
  }

  @override
  List<Object?> get props => [
    super.uid,
    super.parentUid,
    super.keyword,
    super.label,
    dropdownMenuEntries,
    hintText,
  ];

  @override
  DropdownFieldConfig<T> copyWith({
    String? uid,
    String? parentUid,
    String? keyword,
    String? label,
    void Function(dynamic value)? onValueUpdate,
    T? initialValue,
    List<DropdownMenuEntry<T>>? dropdownMenuEntries,
    String? hintText,
  }) {
    return DropdownFieldConfig<T>(
      uid: uid ?? this.uid,
      parentUid: parentUid ?? this.parentUid,
      keyword: keyword ?? this.keyword,
      label: label ?? this.label,
      onValueUpdate: onValueUpdate ?? this.onValueUpdate,
      initialValue: initialValue ?? this.initialValue,
      dropdownMenuEntries: dropdownMenuEntries ?? this.dropdownMenuEntries,
      hintText: hintText ?? this.hintText,
    );
  }
}