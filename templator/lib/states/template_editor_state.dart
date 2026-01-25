import 'package:templator/types/template_builder.dart';

class TemplateEditorState {
  TemplateBuilder? activeTemplate;
  Map<String, dynamic> fieldValues;

  TemplateEditorState(
    this.activeTemplate,
    this.fieldValues,
  );
}