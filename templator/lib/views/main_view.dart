import 'package:flutter/material.dart';
import 'package:templator/types/field_config.dart';
import 'package:templator/types/template_builder.dart';
import 'package:templator/pages/apply_template_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final templates = [
    TemplateBuilder(
      name: "Individual Movement",
      templateText: '''Location: {{location}}, 
Est Time Out: {{timeOut}}, 
Est Time In: {{timeIn}}, 

Rank/Name: 
{{names}}''',
      fields: [
        LabelledTextFieldConfig(keyword: "location"),
        LabelledTextFieldConfig(keyword: "timeOut", label: "Est Time Out"),
        LabelledTextFieldConfig(keyword: "timeIn", label: "Est Time In"),
        SelectionFieldConfig(
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
    ),
    TemplateBuilder(
      name: "Vehicle Movement",
      templateText: '''{{VehicleNumber}}

{{Location 1}} > {{Location 2}}
{{Trades}}
''',  
      fields: [
        LabelledTextFieldConfig(keyword: "VehicleNumber", label: "Vehicle Number"),
        LabelledTextFieldConfig(keyword: "Location 1", label: "From:"),
        LabelledTextFieldConfig(keyword: "Location 2", label: "To:"),
        SelectionFieldConfig(
          keyword: "Trades", 
          options: [
            "trade123",
            "trade152",
            "trad372e",
            "trade6278",
            "trade2",
          ]
        )
      ] 
    )
  ];

  late final List<Widget> _pages = [
    TemplateManager(templates: templates,),
    ApplyTemplatePage(templates: templates),
  ]; 

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) { setState(() {_selectedIndex = value;}); },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: "Template"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Apply"
          ),
        ]
      )
    );
  }
}

class TemplateManager extends StatelessWidget {

  const TemplateManager({
    super.key,
    required this.templates,
  });

  final List<TemplateBuilder> templates;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: templates.map( (template) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(template.name),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => print("hello"), 
                )
              ],
            )
          );
        }).toList(),
      )
    );
  }
}