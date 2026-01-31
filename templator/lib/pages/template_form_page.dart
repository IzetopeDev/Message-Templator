import 'package:flutter/material.dart';
import 'package:templator/models/single_instance/result_text_section.dart';
import 'package:templator/models/single_instance/text_template_card.dart';

class TemplateFormPage extends StatelessWidget {
  const TemplateFormPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [ 
          TextTemplateCard(),
          //ResultText(),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}