import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/template_form_notifier.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/states/template_form_state.dart';
import 'package:templator/types/field_config.dart';

class TextTemplateCard extends ConsumerWidget {
  const TextTemplateCard({super.key});

  void _onSelected(String? templateName, TemplateFormNotifier notifier) {
    try {
      ArgumentError.checkNotNull(templateName);
      log(
        "User selected template: ${templateName!}",
        name: "USER",
        level: 800
      );

      notifier.selectTemplate(templateName);

    } catch (e) {
      log(
        "User selected null template!",
        error: e,
        name: "WARNING",
        level: 900,
        stackTrace: StackTrace.current
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TemplateFormState formState = ref.watch(templateFormProvider);
    TemplateFormNotifier formNotifier = ref.watch(templateFormProvider.notifier);
    List<String>? templateNames = ref.watch(templateManagerProvider)
      .builders?.keys.toList(); 
  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownFieldConfig<String>(
                options: templateNames ?? ["No Options Passed"], 
                label: "Template:",
                keyword: "TemplateSelector",
                hintText: "Your Template",
                initialValue: formState.activeTemplate?.name,
                onSelected: (value) => _onSelected(value, formNotifier),
              ).buildWidget("TemplateSelector"),
              Column(
                children: formState
                  .activeTemplate?.buildWidgets(formNotifier, formState.fieldValues) 
                  ?? [Text("Select your template to generate fields!")],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
