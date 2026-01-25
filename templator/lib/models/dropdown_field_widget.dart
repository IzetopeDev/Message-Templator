
import 'package:flutter/material.dart';
import 'package:templator/types/field_config.dart';

class DropdownFieldWidget<T> extends StatelessWidget {
  const DropdownFieldWidget(this.config, {super.key,});
  
  final DropdownFieldConfig<T> config;

  @override
  Widget build(BuildContext context) {
    late final options = config.options;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(config.label ?? ""),
          DropdownMenu<T>(
            width: 200,
            hintText: config.hintText,
            initialSelection: config.initialValue,
            onSelected: config.onSelected,
            dropdownMenuEntries: options.map((opt) {
              return DropdownMenuEntry<T>(
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
