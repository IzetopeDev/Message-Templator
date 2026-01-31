
import 'package:flutter/material.dart';
import 'package:templator/states/field_configs/dropdown_field_config.dart';

class DropdownFieldWidget<T> extends StatelessWidget {
  const DropdownFieldWidget(this.config, {super.key,});
  
  final DropdownFieldConfig<T> config;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(config.label ?? ""),
          DropdownMenu<T?>(
            width: 200,
            hintText: config.hintText,
            initialSelection: config.initialValue,
            onSelected: config.onValueUpdate,
            dropdownMenuEntries: config.dropdownMenuEntries.isEmpty 
              ? [DropdownMenuEntry<T?>(value: null, label: "no options provided!")]
              : config.dropdownMenuEntries
          ),
        ],
      ),
    );
  }
}
