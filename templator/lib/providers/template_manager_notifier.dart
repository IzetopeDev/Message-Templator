import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/states/template_manager_state.dart';
import 'package:templator/types/field_config.dart';
import 'package:templator/types/template_builder.dart';

class TemplateManagerNotifier extends Notifier<TemplateManagerState>{
  @override
  TemplateManagerState build() {
    return TemplateManagerState(
      builders: {
        "Individual Movement" : TemplateBuilder(
          name: "Individual Movement",
          templateText: '''Location: {{location}}, 
Est Time Out: {{timeOut}}, 
Est Time In: {{timeIn}}, 

Rank/Name: 
{{names}}''',
          fields: [
            LabelledTextFieldConfig(keyword: "location"),
            LabelledTextFieldConfig(keyword: "timeOut", label: "Est Time Out"),
            LabelledTextFieldConfig(keyword: "timeIn", label: "Est Time In"),
            SelectionFieldConfig(
              keyword: "names",
              label: "Rank/Name:",
              options: [
                "Alice Johnson",
                "Bob Smith",
                "Charlie Davis",
                "Diana Evans",
                "Ethan Harris",
                "Fiona Garcia",
                "George Brown",
                "Hannah Wilson",
              ],
            ),
          ],
        ),
        "Vehicle Movement" : TemplateBuilder(
          name: "Vehicle Movement",
          templateText: '''{{VehicleNumber}}

{{Location 1}} > {{Location 2}}
{{Trades}}
''',  
          fields: [
            LabelledTextFieldConfig(keyword: "VehicleNumber", label: "Vehicle Number"),
            LabelledTextFieldConfig(keyword: "Location 1", label: "From:"),
            LabelledTextFieldConfig(keyword: "Location 2", label: "To:"),
            SelectionFieldConfig(
              keyword: "Trades", 
              options: [
                "trade123",
                "trade152",
                "trad372e",
                "trade6278",
                "trade2",
              ]
            )
          ] 
        )
      }
    );
  }

  void addBuilder(TemplateBuilder builder) {
    state = state.copyWith({...state.builders ?? {}, builder.name : builder});
  }

  void removeBuilder(String builderName) {
    final builders = {...state.builders ?? {}};
    try {builders.remove(builderName);}
    catch (e) {
      log("unable to remove builder", name: "WARN", level: 800, error: e);
    }

    state = state.copyWith(builders);
  }
}

final templateManagerProvider = 
  NotifierProvider<TemplateManagerNotifier, TemplateManagerState>(() {
    return TemplateManagerNotifier();
});