import 'package:flutter/material.dart';

class SelectionFieldWidget extends StatefulWidget {
  const SelectionFieldWidget(
    this.listOptions, { //named params
    super.key,
    this.onSelected,
    this.label,
  });

  final List<String> listOptions;
  final void Function(List<String> selectedOptions)? onSelected;
  final String? label;

  @override
  State<SelectionFieldWidget> createState() => _SelectionFieldWidgetState();
}

class _SelectionFieldWidgetState extends State<SelectionFieldWidget> {
  List<String> selectedOptions = [];

  void _onNameSelected(bool? value, String option) {


    setState(() {
      if (value == true) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });

    if (widget.onSelected != null) {
      widget.onSelected!(selectedOptions);
    }
  }

  List<String> _sortBySelected(List<String> list) {
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
    List<String> sortedList = _sortBySelected(widget.listOptions);

    return Column(
      children: [
        if (widget.label != null) Text(widget.label!),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: sortedList
              .map(
                (option) => CheckboxListTile(
                  key: ValueKey(option),
                  title: Text(option),
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
