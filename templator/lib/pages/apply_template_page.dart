import 'package:flutter/material.dart';
import 'package:templator/types/template_builder.dart';
import 'package:templator/models/single_instance/result_text_section.dart';
import 'package:templator/models/single_instance/text_template_card.dart';

class ApplyTemplatePage extends StatelessWidget {
  const ApplyTemplatePage({
    super.key,
    required this.templates,
  });

  final List<TemplateBuilder> templates;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [ 
          TextTemplateCard(),
          ResultText(),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}