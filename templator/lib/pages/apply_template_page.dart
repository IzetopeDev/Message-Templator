import 'package:flutter/material.dart';
import 'package:templator/classes/field.dart';
import 'package:templator/classes/template.dart';
import 'package:templator/models/text_template_card.dart';

class ApplyTemplatePage extends StatefulWidget {
  const ApplyTemplatePage({super.key, required this.title});

  final String title;

  @override
  State<ApplyTemplatePage> createState() => _ApplyTemplatePageState();
}

class _ApplyTemplatePageState extends State<ApplyTemplatePage> {
  final template = Template(
    templateText: '''
Location: {{location}}, 
Est Time Out: {{timeOut}}, 
Est Time In: {{timeIn}}, 
Rank/Name: 
{{names}}
    ''',
    fields: [
      LabelledTextField(keyword: "location"),
      LabelledTextField(keyword: "timeOut", label: "Est Time Out"),
      LabelledTextField(keyword: "timeIn", label: "Est Time In"),
      SelectionField(
        keyword: "names",
        label: "Rank/Name:",
        options: [
          "Alice Johnson",
          "Bob Smith",
          "Charlie Davis",
          "Diana Evans",
          "Ethan Harris",
          "Fiona Garcia",
          "George Brown",
          "Hannah Wilson",
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            TextTemplateCard(fields: template.createWidgetsByFieldType()),
            ResultText(template: template),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}

class ResultText extends StatefulWidget {
  final Template template;

  const ResultText({super.key, required this.template});

  @override
  State<ResultText> createState() => _ResultTextState();
}

class _ResultTextState extends State<ResultText> {
  String _generatedText = "";

  String _fillTemplate(Template template) {
    String result = template.templateText;
    for (var field in template.fields) {
      if (field.value == null) {
        throw ArgumentError.notNull("Field: ${field.keyword}");
      }

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

    return result;
  }

  void _generateText() {
    setState(() {
      _generatedText = _fillTemplate(widget.template);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              padding: EdgeInsets.all(16.0),
              child: Text(
                _generatedText.isEmpty
                    ? "Click 'Generate Text' to fill in values"
                    : _generatedText,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _generateText,
            child: Text("Generate Text"),
          ),
        ],
      ),
    );
  }
}
