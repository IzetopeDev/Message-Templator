import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:templator/classes/template.dart';

class TextTemplateCard extends StatefulWidget {
  const TextTemplateCard(
    this.templates, 
    {
      super.key,
      this.defaultTemplate,
    });

  //TODO: get template info by provider!
  final List<Template> templates;
  final Template? defaultTemplate;

  @override
  State<TextTemplateCard> createState() => _TextTemplateCardState();
}

class _TextTemplateCardState extends State<TextTemplateCard> {
  Template? _selectedTemplate;
  late List<Widget> _fields = _getFields();

  void _onTemplateSelected(Template? template) {
    log(
      "user selected template: ${template?.name ?? "no template"}", 
      name: "INFO",  
      level: 800,
    );

    setState(() {
      _selectedTemplate = template;
      _fields = _getFields();
    });
  }

  List<Widget> _getFields() {

    if (_selectedTemplate == null && widget.defaultTemplate != null) {
      _fields = widget.defaultTemplate!.createWidgetsByFieldType();
    }
    
    _fields = _selectedTemplate?.createWidgetsByFieldType() 
      ?? [Text("Select your template to generate fields!")];   

    log(
      "fields to generate ${_fields.length}", 
      name: "DEBUG",
      level: 500
    );

    log(
      "fields to generate: $_fields",
      name: "DEBUG (-v)",
      level: 300
    );

    return _fields;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TemplatePicker(
                widget.templates, 
                defaultTemplate: widget.defaultTemplate,
                onSelected: _onTemplateSelected),
              Column(
                children: _fields,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemplatePicker extends StatelessWidget {
  const TemplatePicker(
    this.templates,
    {
      super.key,
      this.onSelected,
      this.defaultTemplate,
    }
  );
  
  final List<Template> templates;
  final void Function(Template? value)? onSelected;
  final Template? defaultTemplate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Template: "),
          DropdownMenu(
            width: 200,
            hintText: "Your Template",
            onSelected: onSelected,
            initialSelection: defaultTemplate,
            dropdownMenuEntries: templates.map((t) {
              return DropdownMenuEntry(
                value: t,
                label: t.name
              );
            }).toList()
          ),
        ],
      ),
    );
  }
}
