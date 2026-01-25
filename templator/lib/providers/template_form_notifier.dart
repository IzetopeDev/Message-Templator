
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/types/template_builder.dart';
import 'package:templator/states/template_form_state.dart';

class TemplateFormNotifier extends Notifier<TemplateFormState> {
  
  @override
  TemplateFormState build() {
    return TemplateFormState();
  }

  void selectTemplate(String templateName) {

    TemplateBuilder? template = ref.read(templateManagerProvider).builders?[templateName];

    state = TemplateFormState(activeTemplate: template);
  }

  void updateField(String keyword, dynamic value) {
    state = state.copyWith(fieldValues: {...state.fieldValues, keyword: value});
  }

  void clearFields() {
    state = state.copyWith(fieldValues: {});
  }
} 

final templateFormProvider = 
  NotifierProvider<TemplateFormNotifier, TemplateFormState>(() {
    return TemplateFormNotifier();
  });
