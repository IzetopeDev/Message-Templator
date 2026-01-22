
import 'package:flutter/material.dart';

class SideLabelledDropdownMenuWidget<T> extends StatelessWidget {
  const SideLabelledDropdownMenuWidget(
    this.options,
    {
      super.key,
      required this.sideLabel,
      this.hintText,
      this.onSelected,
      this.defaultOption,
    }
  );
  
  final List<T> options;
  final String sideLabel;
  final String? hintText;
  final void Function(T? value)? onSelected;
  final T? defaultOption;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sideLabel),
          DropdownMenu(
            width: 200,
            hintText: hintText,
            initialSelection: defaultOption,
            onSelected: onSelected,
            dropdownMenuEntries: options.map((opt) {
              return DropdownMenuEntry(
                value: opt,
                label: opt?.name ?? opt.toString(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

extension <T> on Object? {
  String? get name {
    try {
      var e = this as dynamic;
      return e.name is String ? e.name : null;

    } catch(_) {
      return null;
    }
  }
}
