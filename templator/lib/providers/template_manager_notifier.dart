import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/states/template_manager_state.dart';
import 'package:templator/states/template_builder.dart';

class TemplateManagerNotifier extends Notifier<TemplateManagerState>{
  @override
  TemplateManagerState build() {
    return TemplateManagerState(
      builders: {}
    );
  }

  void updateBuilder(TemplateBuilder builder) {
    var newBuilders = {...state.builders ?? {}};
    newBuilders[builder.uid] = builder;

    state = state.copyWith(newBuilders);
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