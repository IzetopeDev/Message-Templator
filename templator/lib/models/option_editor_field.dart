import 'dart:async';

import 'package:flutter/material.dart';

class OptionEditorField extends StatefulWidget {
  final List<String?> options;
  final ValueChanged<List<String?>> onChanged;

  const OptionEditorField({
    super.key,
    this.options = const [],
    required this.onChanged,
  });

  @override
  State<OptionEditorField> createState() => _OptionEditorFieldState();
}

class _OptionEditorFieldState extends State<OptionEditorField> {
  late List<TextEditingController> _controllers;
  
  Timer? _timer;
  void _onValueUpdate(dynamic value, int index) {
    if (_timer?.isActive ?? false) _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 500), () {
      final newOptions = List<String?>.from(widget.options);
      newOptions[index] = value;
      widget.onChanged(newOptions);
    });
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _controllers = widget.options.map((e) => TextEditingController(text: e ?? '')).toList();
  }

  @override
  void didUpdateWidget(covariant OptionEditorField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options.length != _controllers.length) {
      for (var controller in _controllers) {
        controller.dispose();
      }
      _initControllers();
    } else {
      for (int i = 0; i < widget.options.length; i++) {
        if (_controllers[i].text != (widget.options[i] ?? '')) {
          _controllers[i].text = widget.options[i] ?? '';
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text("Options:"),
        ),
        ...widget.options.asMap().entries.map((entry) {
          final index = entry.key;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _controllers[index],
                        onChanged: (value) => _onValueUpdate(value, index),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1)
                          )
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final newOptions = List<String?>.from(widget.options);
                      newOptions.removeAt(index);
                      widget.onChanged(newOptions);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        }),
        IconButton(
          onPressed: () {
            final newOptions = List<String?>.from(widget.options);
            newOptions.add('');
            widget.onChanged(newOptions);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}