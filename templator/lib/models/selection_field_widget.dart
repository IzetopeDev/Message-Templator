import 'package:flutter/material.dart';
import 'package:templator/states/field_configs/selection_field_config.dart';

class SelectionFieldWidget extends StatefulWidget {
  final SelectionFieldConfig config;

  const SelectionFieldWidget(
    this.config, {
    super.key,
  });

  @override
  State<SelectionFieldWidget> createState() => _SelectionFieldWidgetState();
}

class _SelectionFieldWidgetState extends State<SelectionFieldWidget> {
  late List<String?> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = List.from(widget.config.initialValue ?? []);
  }

  void _onNameSelected(bool? isSelected, String option) {
    setState(() {
      if (isSelected == true) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });

    widget.config.onValueUpdate?.call(selectedOptions);
  }

  List<String> _sortBySelected(List<String?> list) {
    List<String> sortedList = List<String>.from(list);

    sortedList.sort((a, b) {
      bool isASelected = selectedOptions.contains(a);
      bool isBSelected = selectedOptions.contains(b);

      if (isASelected && !isBSelected) return -1;
      if (!isASelected && isBSelected) return 1;
      return a.compareTo(b);
    });

    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    List<String?> sortedList = _sortBySelected(widget.config.options);

    return Column(
      children: [
        if (widget.config.label != null) 
          Text(widget.config.label!),
          
        Column(
          mainAxisSize: MainAxisSize.min,
          children: sortedList.isEmpty 
            ? [Text("no options!")]
            : sortedList.map(
                (option) => CheckboxListTile(
                  key: ValueKey("${widget.config.uid}_$option"),
                  title: Text(option!),
                  value: selectedOptions.contains(option),
                  onChanged: (bool? value) => _onNameSelected(value, option),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}