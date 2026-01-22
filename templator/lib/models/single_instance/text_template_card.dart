import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:templator/classes/template.dart';
import 'package:templator/models/side_labelled_dropdown_widget.dart';

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
      _fields = widget.defaultTemplate!.buildWidget();
    }
    
    _fields = _selectedTemplate?.buildWidget() 
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
              SideLabelledDropdownMenuWidget(
                widget.templates, 
                sideLabel: "Template:",
                hintText: "Your Template",
                defaultOption: widget.defaultTemplate,
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
