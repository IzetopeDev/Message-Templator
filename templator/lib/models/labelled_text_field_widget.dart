import 'package:flutter/material.dart';

class LabelledTextFieldWidget extends StatelessWidget {
  const LabelledTextFieldWidget(
    this.optionName, { //named params
    super.key,
    this.onSubmitted,
    this.isLast = false,
  });

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
