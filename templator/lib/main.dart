import 'package:flutter/material.dart';
import 'text_template.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Templator',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.indigo),
      ),
      home: EnterTextPage(title: 'Text Templator'),
    );
  }
}

enum FieldType {
  InlineTextField,
  MultiLineListOptions,
} 

class Field {
  Field({
    required this.keyword,
    required this.fieldType,
    this.label,
    this.arg,
  });

  final String keyword;
  final FieldType fieldType;
  final String? label;
  final dynamic arg;
  
  dynamic value;
  
  
  Widget asInlineTextField(bool? isLast) {
    return InlineTextField(
      label ?? keyword,
      isLast: isLast ?? false,
      onSubmitted: (userVal) => value = userVal,
    );
  }

  Widget asMultilineListOptions(List<String> listOptions) {
    return MultiLineListOptions(
      listOptions,
      label: label,
      onSelected: (selectedOptions) => value = selectedOptions,
    );
  }
}


class Template {
  Template({
    required this.templateText,
    required this.fields,
  });

  final String templateText;
  final List<Field> fields;

  List<Widget> createWidgetsByFieldType() {
    return fields.map((field) {
      switch (field.fieldType) {

        case FieldType.InlineTextField:
          // TODO: Critical create a switch case for this!!
          return field.asInlineTextField(field.arg);

        case FieldType.MultiLineListOptions:
          return field.asMultilineListOptions(field.arg);
      }
    }).toList();
  }
}

class EnterTextPage extends StatefulWidget {
  const EnterTextPage({
    super.key, 
    required this.title,
  });

  final String title;

  @override
  State<EnterTextPage> createState() => _EnterTextPageState();
}

class _EnterTextPageState extends State<EnterTextPage> {

  final template = Template(
    templateText: '''
      Location: {{location}}, 
      Est Time Out: {{timeOut}}, 
      Est Time In: {{timeIn}}, 
      Rank/Name: 
      {{names}}
    ''', 
    fields: [
      Field(
        keyword: "location", 
        fieldType: FieldType.InlineTextField
      ),
      Field(
        keyword: "timeOut", 
        fieldType: FieldType.InlineTextField,
        label: "Est Time Out",
      ),
      Field(
        keyword: "timeIn", 
        fieldType: FieldType.InlineTextField,
        label: "Est Time In",
        arg: true
      ),
      Field(
        keyword: "names", 
        fieldType: FieldType.MultiLineListOptions,
        label: "Rank/Name:",
        arg: [
          "Alice Johnson",
          "Bob Smith",
          "Charlie Davis",
          "Diana Evans",
          "Ethan Harris",
          "Fiona Garcia",
          "George Brown",
          "Hannah Wilson",
        ],
      )
    ]
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
            SizedBox(height: 200)
          ],
        )
      ),
    );
  }
}

class ResultText extends StatefulWidget {
  final Template template;

  const ResultText({
    super.key,
    required this.template,
  });

  @override
  State<ResultText> createState() => _ResultTextState();
}

class _ResultTextState extends State<ResultText> {
  String _generatedText = "";

  String _fillTemplate(Template template) {
    String result = template.templateText;
    template.fields.forEach((field) {
      if (field.value != null) {
        switch (field.fieldType) {
          case FieldType.InlineTextField:
            result = result.replaceAll('{{${field.keyword}}}', field.value.toString());
            break;
          case FieldType.MultiLineListOptions:
            List<String> nameList = field.value as List<String>;
            String joinedNames = nameList.join(", ");
            result = result.replaceAll('{{${field.keyword}}}', joinedNames);
            break;
        }
      }
    });
    
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
              child: Text(_generatedText.isEmpty 
                ? "Click 'Generate Text' to fill in values" 
                : _generatedText
              ),
            )
          ),
          ElevatedButton(
            onPressed: _generateText, 
            child: Text("Generate Text"),
          )
        ],
      ),
    );
  }
}

