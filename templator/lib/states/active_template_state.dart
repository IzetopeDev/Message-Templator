import 'package:templator/states/template_builder.dart';

class ActiveTemplateState {
  final TemplateBuilder activeTemplate;
  final bool showOptional;

  //String is the fieldID.
  final Map<String, dynamic> formResponses;
  
  const ActiveTemplateState({
    required this.activeTemplate,
    this.showOptional = false,
    this.formResponses = const {},
  });

  ActiveTemplateState copyWith({
    TemplateBuilder? activeTemplate,
    bool? showOptional,
    Map<String, dynamic>? formResponses,
  }) {
    return ActiveTemplateState(
      activeTemplate: activeTemplate ?? this.activeTemplate,
      showOptional: showOptional ?? this.showOptional,
      formResponses: formResponses ?? this.formResponses,
    );
  }
}