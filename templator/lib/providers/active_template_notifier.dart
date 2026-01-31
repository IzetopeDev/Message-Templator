import 'dart:developer'; // 1. Import this
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/types/field_config.dart';
import 'package:templator/states/field_configs/field_selector_config.dart';
import 'package:templator/states/template_builder.dart';
import 'package:templator/states/active_template_state.dart';
import 'package:templator/types/utils.dart';

class ActiveTemplateNotifier extends Notifier<ActiveTemplateState> {
  
  // Define a constant log name for easy filtering in DevTools
  static const String _logName = 'ActiveTemplateNotifier';

  @override
  ActiveTemplateState build() {
    final initialState = ActiveTemplateState(activeTemplate: TemplateBuilder(uid: 'default'));
    
    log('Initialized ActiveTemplateState', name: _logName);
    
    return initialState;
  }

  void selectTemplate({String? uid}) {
    log('Selecting template with UID: $uid', name: _logName);

    TemplateBuilder template = 
      ref.read(templateManagerProvider).builders?[uid]
      ?? TemplateBuilder(uid: Utils.generateUid(10));

    if (ref.read(templateManagerProvider).builders?[uid] == null) {
      log('Template not found, created new template: ${template.uid}', name: _logName);
    }

    state = ActiveTemplateState(activeTemplate: template);
    
    log('State updated: Active template is now ${state.activeTemplate.name} (${state.activeTemplate.uid})', name: _logName);
  }

  void updateTemplateProperties({
    String? name,
    String? templateText,
  }) {
    // Log exactly what is being attempted
    log('User input properties: Name: $name, Text: ${templateText != null ? "[REDACTED LENGTH: ${templateText.length}]" : "Unchanged"}', name: _logName);
 
    var newTemplate = state.activeTemplate.copyWith(
      name: name ?? state.activeTemplate.name,
      templateText: templateText ?? state.activeTemplate.templateText,
    ); 

    state = state.copyWith(activeTemplate: newTemplate);
    //TODO: update parentName for fields
  }
  
  void createField() {
    var newUid = Utils.generateUid(15);
    log('Creating new field with UID: $newUid', name: _logName);

    var newFieldConfig = FieldSelectorConfig(
      uid: newUid, 
      parentUid: state.activeTemplate.uid,
    );

    state = state.copyWith(
      activeTemplate: state.activeTemplate.copyWith(
        formFieldConfigs: {
          ...state.activeTemplate.formFieldConfigs,
          newFieldConfig.uid : newFieldConfig,
        }
      )
    );

    log('Field created. Total fields: ${state.activeTemplate.formFieldConfigs.length}', name: _logName);
  }

  void updateFieldConfig(FieldConfig newConfig) {
    log('Updating config for field: ${newConfig.uid} (Type: ${newConfig.runtimeType})', name: _logName);

    var newConfigsMap = {
      ...state.activeTemplate.formFieldConfigs,
      newConfig.uid : newConfig 
    };

    state = state.copyWith(
      activeTemplate: state.activeTemplate.copyWith(
        formFieldConfigs: newConfigsMap
      )
    );
  }

  void updateFormResponse({required String uid, dynamic value}) {
    log('Updating form response - Field: $uid, Value: $value', name: _logName);

    var newFormResponses = {...state.formResponses, uid: value};
    
    state = state.copyWith(
      formResponses: newFormResponses,
    );
  }
} 

final activeTemplateProvider = 
  NotifierProvider<ActiveTemplateNotifier, ActiveTemplateState>(() {
    return ActiveTemplateNotifier();
  });