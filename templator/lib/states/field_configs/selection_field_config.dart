import 'package:flutter/material.dart';
import 'package:templator/models/selection_field_widget.dart';
import 'package:templator/states/field_configs/dropdown_field_config.dart';
import 'package:templator/states/field_configs/labelled_text_field_config.dart';
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

  void _toNewConfig({
    required String keyword, 
    required dynamic value,
    required void Function(dynamic value)? onValueUpdate,
  }) {
    Map<String, dynamic> keywordMap = {keyword: value};
    var newFieldConfig = copyWith(
      keyword: keywordMap["keyword"] ?? this.keyword,
      label: keywordMap["label"] ?? label,
      initialValue: keywordMap["initialValue"] ?? initialValue,
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
        OptionEditorField(),
        DropdownFieldConfig(
          uid: uid, 
          parentUid: parentUid,
          keyword: "initalValue",
          hintText: "Initial Value",
          label: "Initial Value",
          onValueUpdate: (value) => throw UnimplementedError(),
          //dropdownMenuEntries: ,
        ).buildFormField(),
      ],
    );
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

class OptionEditorField extends StatelessWidget {
  const OptionEditorField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text("Options:"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)) 
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed:() => throw UnimplementedError(), 
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          padding: const EdgeInsets.all(8.0),
          //TODO: style such that the button spans the whole width. 
          icon: Icon(Icons.add),
          onPressed: () => throw UnimplementedError(), 
        ),
      ],
    );
  }
}