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

  void addBuilder(TemplateBuilder builder) {
    state = state.copyWith({...state.builders ?? {}, builder.uid : builder});
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