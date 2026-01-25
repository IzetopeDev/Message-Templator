import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/pages/template_editor_page.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/states/template_manager_state.dart';
import 'package:templator/types/template_builder.dart';

class TemplateManager extends ConsumerWidget {

  const TemplateManager({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    TemplateManagerState state = ref.watch(templateManagerProvider);
    TemplateManagerNotifier notifier = ref.watch(templateManagerProvider.notifier);
    
    Map<String, TemplateBuilder>? templateBuilders = state.builders;

    return Center(
      child: ListView(
        children: templateBuilders?.values.map((template) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(template.name),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateEditorPage()
                      )
                    );
                  }, 
                )
              ],
            )
          );
        })
        .toList()
        ?? [Text("No Templates found.")],
      )
    );
  }
}