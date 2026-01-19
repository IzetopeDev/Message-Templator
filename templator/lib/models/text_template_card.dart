import 'package:flutter/material.dart';

class TextTemplateCard extends StatelessWidget {
  const TextTemplateCard({super.key, this.fields});

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
            children: fields ?? [Text("No fields added yet.")],
          ),
        ),
      ),
    );
  }
}
