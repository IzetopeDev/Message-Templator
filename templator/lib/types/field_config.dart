import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FieldConfig<T> extends Equatable {
  
  final String uid;
  final String parentUid;

  final String? keyword;
  final String? label;

  final void Function(T? value)? onValueUpdate;
  final T? initialValue;
  

  const FieldConfig({
    required this.uid,
    required this.parentUid,
    required this.keyword,
    this.label,
    this.onValueUpdate,
    this.initialValue,
  });

  Widget buildFormField({FieldConfig<T>? stateConfig});

  Widget buildEditorField({FieldConfig<T>? stateConfig});

  FieldConfig<T> copyWith({
    String? uid,
    String? parentUid,
    String? keyword,
    String? label,
    void Function(T? value)? onValueUpdate,
    T? initialValue,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [uid, parentUid, keyword, label];
}