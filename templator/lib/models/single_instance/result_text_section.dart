
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:templator/classes/field.dart';

import '../../classes/template.dart';

class ResultText extends StatefulWidget {
  const ResultText({super.key, required this.template});
  final Template? template;

  @override
  State<ResultText> createState() => _ResultTextState();
}

class _ResultTextState extends State<ResultText> {
  String _generatedText = "";

  String _fillTemplate(Template? template) {
    ArgumentError.checkNotNull(template, "no template chosen!");

    String result = template!.templateText;

    log(
      "applying field values to template (${template.name})",
      name: "INFO",
      level: 800
    );
    
    for (var field in template.fields) {
      log(
        "reading Field: ${field.keyword}, value: ${field.value}",
        name: "DEBUG (-v)",
        level: 300
      );

      ArgumentError.checkNotNull(field.value, "Field: ${field.keyword}");

      switch (field) {
        case LabelledTextField f:
          result = result.replaceAll('{{${f.keyword}}}', f.value!);
          break;

        case SelectionField f:
          String joinedNames = f.value!.join("\n");
          result = result.replaceAll('{{${field.keyword}}}', joinedNames);
          break;
      }
    }

    log("applied values to template, result:\n $result", name: "INFO", level: 800);
    return result;
  }

  void _generateText() {
    String templateResult;

    log("user pressed generate text", name: "INFO", level: 800);

    try {
      templateResult = _fillTemplate(widget.template);
    } catch (e) {
      log("null value!", level: 900, error: e, name: "WARN");
      templateResult = "please submit your fields.";
    }

    setState(() {
      _generatedText = templateResult; 
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
                child: Text(
                  _generatedText.isEmpty
                      ? "Click 'Generate Text' to fill in values"
                      : _generatedText,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _generateText,
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
