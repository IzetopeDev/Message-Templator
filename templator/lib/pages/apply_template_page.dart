import 'package:flutter/material.dart';
import 'package:templator/classes/template.dart';
import 'package:templator/models/single_instance/result_text_section.dart';
import 'package:templator/models/single_instance/text_template_card.dart';

class ApplyTemplatePage extends StatefulWidget {
  const ApplyTemplatePage({
    super.key,
    required this.templates,
  });

  final List<Template> templates;

  @override
  State<ApplyTemplatePage> createState() => _ApplyTemplatePageState();
}

class _ApplyTemplatePageState extends State<ApplyTemplatePage> {
  Template? _selectedTemplate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [ 
          TextTemplateCard(
            widget.templates, 
            onTemplateSelected: (template) {
              setState(() {
                _selectedTemplate = template;
              });
            },
          ),
          ResultText(template: _selectedTemplate ?? widget.templates[0]),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}