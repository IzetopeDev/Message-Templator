
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/template_form_notifier.dart';
import 'package:templator/states/template_form_state.dart';
import 'package:templator/types/Exceptions.dart';
import 'package:templator/types/template_builder.dart';


class ResultText extends ConsumerStatefulWidget {

  const ResultText({super.key});

  @override
  ConsumerState createState() => _ResultTextState();
}

class _ResultTextState extends ConsumerState<ResultText> {
  String _generatedText = "please select a template!";
  
  void _generateText() {
    TemplateFormState state = ref.read(templateFormProvider);
    NullValueException.check(state.activeTemplate, context: "template");

    TemplateBuilder template = state.activeTemplate!;
    String appliedTemplateText = template.templateText; 

    for (var field in template.fields) {
      dynamic value = state.fieldValues[field.keyword];

      log(
        "searched ${field.keyword}, value: $value",
        name: "DEBUG (-v)",
        level: 300,  
      );

      NullValueException.check(value, context: "field");

      if (value is List<String>) {
        value = value.join(",\n");
      } else if (value !is String) {
        UnpredictedException(value: value, context: "field");
      }

      appliedTemplateText = appliedTemplateText
        .replaceAll("{{${field.keyword}}}", value!);
    }

    setState(() {
      _generatedText = appliedTemplateText;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(_generatedText),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      log(
                        "User pressed generate text button",
                        name: "INFO",
                        level: 800,
                      );
                      try {_generateText();}
                      catch (e) {
                        log("Exception caught:", name: "WARN", level: 900, error: e);
                        if (e is NullValueException) {
                          switch (e.context) {
                            case "template":
                              setState(() =>_generatedText = "please select a template!");
                              break;

                            case "field":
                              setState(() =>_generatedText = "please fill in all the fields!");
                              break;
                          }
                        } else if (e is UnpredictedException) {
                          log(e.message, name:"ERROR", level: 1200);
                        }
                      }  
                    },
                    child: Text("Generate Text"),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy), 
                    onPressed: () async {
                      log(
                        "User pressed Copy Text!",
                        name: "INFO",
                        level: 800
                      );
                  
                      await Clipboard.setData(ClipboardData(text: _generatedText));
                  
                      if (!context.mounted) return;
                  
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Copied to Clipboard!"))
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
