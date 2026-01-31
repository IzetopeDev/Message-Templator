import 'dart:async';
import 'package:flutter/material.dart';
import 'package:templator/states/field_configs/labelled_text_field_config.dart';

class LabelledTextFieldWidget extends StatefulWidget {
  
  final LabelledTextFieldConfig config;

  const LabelledTextFieldWidget(this.config, {super.key});

  @override
  State<LabelledTextFieldWidget> createState() => _LabelledTextFieldWidgetState();
}

class _LabelledTextFieldWidgetState extends State<LabelledTextFieldWidget> {
  Timer? _timer;
  
  void _onChanged(String value, {int time = 500}) {
    if (_timer?.isActive ?? false) _timer!.cancel();

    _timer = Timer(Duration(milliseconds: time), () {
      widget.config.onValueUpdate?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${widget.config.label ?? widget.config.uid}:"),
          SizedBox(
            width: 200,
            child: TextField(
              textInputAction: widget.config.isLast
                  ? TextInputAction.done
                  : TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.config.label ?? widget.config.uid,
              ),
              onChanged: _onChanged,
              controller: TextEditingController(text: widget.config.initialValue),

            ),
          ),
        ],
      ),
    );
  }
}

