import 'package:templator/types/template_builder.dart';

class TemplateManagerState {
  final Map<String, TemplateBuilder>? builders;

  TemplateManagerState({
    this.builders,
  });

  TemplateManagerState copyWith(
    Map<String, TemplateBuilder>? builders
  ) {
    return TemplateManagerState(
      builders: builders ?? this.builders
    );
  }
}