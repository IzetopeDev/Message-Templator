import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/active_template_notifier.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/states/field_configs/dropdown_field_config.dart';
import 'package:templator/states/template_builder.dart';

class TextTemplateCard extends ConsumerWidget {
  const TextTemplateCard({super.key});

  void _onTemplateSelected(TemplateBuilder? builder, ActiveTemplateNotifier notifier) {
    try {
      ArgumentError.checkNotNull(builder);
      log(
        "User selected template: ${builder!.name}",
        name: "INFO",
        level: 800
      );

      notifier.selectTemplate(uid: builder.uid);

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
    var activeTemplate = ref.watch(activeTemplateProvider.select((state) {
      return state.activeTemplate;
    },));
    var activeTemplateNotifier = ref.watch(activeTemplateProvider.notifier);
    List<TemplateBuilder>? builders = ref.watch(templateManagerProvider)
      .builders?.values.toList(); 
  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownFieldConfig<TemplateBuilder?>(
                dropdownMenuEntries: builders?.map((b) {
                  return DropdownMenuEntry(
                    value: b, 
                    label: b.name ?? "unnamed template"
                  );
                })
                .toList() 
                ?? [DropdownMenuEntry(value: null, label: "no templates!")], 
                uid: "FormTemplateSelector",
                parentUid: "TextTemplateCard",
                label: "Template:",
                hintText: "Your Template",
                initialValue: activeTemplate,
                onValueUpdate: (value) => _onTemplateSelected(value, activeTemplateNotifier),
              )
              .buildFormField(),
              Column(
                children: activeTemplate.buildFormFields(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
