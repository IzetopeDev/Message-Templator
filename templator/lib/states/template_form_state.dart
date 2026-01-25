import 'package:templator/types/template_builder.dart';

class TemplateFormState {
  const TemplateFormState({
    this.activeTemplate, 
    this.fieldValues = const {},
  });

  final TemplateBuilder? activeTemplate;
  
  final Map<String, dynamic> fieldValues;

  TemplateFormState copyWith({
    TemplateBuilder? activeTemplate,
    Map<String, dynamic>? fieldValues,
  }) {
    return TemplateFormState(
      activeTemplate: activeTemplate ?? this.activeTemplate,
      fieldValues: fieldValues ?? this.fieldValues,
    );
  }
}