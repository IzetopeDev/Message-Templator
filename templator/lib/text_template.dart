import 'package:flutter/material.dart';

class TextTemplateCard extends StatelessWidget {
  const TextTemplateCard({
    super.key,
    this.fields
  });

  final List<Widget>? fields;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: fields ?? [
              Text("No fields added yet."),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiLineListOptions extends StatefulWidget {
  const MultiLineListOptions(
    this.listOptions,
    { //named params
      super.key,
      this.onSelected,
      this.label,
    }
    );

  final List<String> listOptions;
  final void Function(List<String> selectedOptions)? onSelected;
  final String? label;

  @override
  State<MultiLineListOptions> createState() => _MultiLineListOptionsState();
}

class _MultiLineListOptionsState extends State<MultiLineListOptions> {
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

  List<String> _sortBySelected(List<String>list) {
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
    debugPrint("widget.label :>> ${widget.label}");

    return Column(
      children: [
        if (widget.label != null) Text(widget.label!),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: sortedList.map((option) => 
            CheckboxListTile(
              key: ValueKey(option),
              title: Text(option),
              value: selectedOptions.contains(option),
              onChanged: (bool? value) => _onNameSelected(value, option),
            )
          ).toList(),
        )
      ],
    );
  }
}

class InlineTextField extends StatelessWidget {
  const InlineTextField(
    this.optionName,
    { //named params
      super.key,
      this.onSubmitted,
      this.isLast = false,
    }
  );

  final String optionName;
  final ValueChanged<String>? onSubmitted;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$optionName:"),
          SizedBox(
            width: 200,
            child: TextField(
              textInputAction: isLast 
                ? TextInputAction.done 
                : TextInputAction.next,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: optionName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
