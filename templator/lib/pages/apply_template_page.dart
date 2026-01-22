import 'package:flutter/material.dart';
import 'package:templator/classes/field.dart';
import 'package:templator/classes/template.dart';
import 'package:templator/models/single_instance/result_text_section.dart';
import 'package:templator/models/single_instance/text_template_card.dart';

class ApplyTemplatePage extends StatefulWidget {
  const ApplyTemplatePage({super.key, required this.title});

  final String title;

  @override
  State<ApplyTemplatePage> createState() => _ApplyTemplatePageState();
}

class _ApplyTemplatePageState extends State<ApplyTemplatePage> {
  final template = Template(
    name: "Individual Movement",
    templateText: '''Location: {{location}}, 
Est Time Out: {{timeOut}}, 
Est Time In: {{timeIn}}, 

Rank/Name: 
{{names}}''',
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
            TextTemplateCard([template]),
            ResultText(template: template),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
