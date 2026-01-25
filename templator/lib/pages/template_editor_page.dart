import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/models/field_selector_widget.dart';

class TemplateEditorPage extends ConsumerWidget {
  const TemplateEditorPage({
    super.key,
  });

  void doSomething(dynamic param) {
    log("doing something");
  }

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add New Template"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text:null),
              onChanged: doSomething,
              decoration: InputDecoration(
                hintText: "Your Template Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: TextEditingController(text:null),
                onChanged: doSomething,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Your Template Text",
                  // ignore: prefer_adjacent_string_concatenation
                  helperText: "surround your text to replace like this: {{keyword}}. " +
                    "making the keyword succinct is reccommended",
                  helperMaxLines: 2,
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                )
              ),
            ),
            FieldSelectorWidget()
      
          ],
        ),
      ),
    );
  }
}