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
    log('🏗️ INITIALIZING state', name: _logName);
    return ActiveTemplateState(
      activeTemplate: TemplateBuilder(
        uid: 'default',
        formFieldConfigs: { 'default' : FieldSelectorConfig(
          parentUid: 'default',
          uid: 'default'
        )
      }
      )
    );
  }

  void selectTemplate({String? uid}) {
    final oldUid = state.activeTemplate.uid;
    
    TemplateBuilder? template = ref.read(templateManagerProvider).builders?[uid];

    if (template == null) {
      String templateUid = Utils.generateUid(10);
      String fieldUid = Utils.generateUid(10); 

      template = TemplateBuilder(
        uid: templateUid,
        formFieldConfigs: {fieldUid : FieldSelectorConfig(
          uid: fieldUid, 
          parentUid: templateUid,
        ),}
      );
    }

    state = ActiveTemplateState(activeTemplate: template);
    
    log('🔄 TEMPLATE SWITCH: [$oldUid] -> [${state.activeTemplate.uid}]', name: _logName);
  }

  void updateTemplateProperties({String? name, String? templateText}) {
    final template = state.activeTemplate;

    state = state.copyWith(
      activeTemplate: template.copyWith(
        name: name ?? template.name,
        templateText: templateText ?? template.templateText,
      )
    );

    log('📝 PROP UPDATE: '
        'Name: "${template.name}" -> "${state.activeTemplate.name}", '
        'Text changed: ${templateText != null}', 
        name: _logName);
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
    final oldConfig = state.activeTemplate.formFieldConfigs[newConfig.uid];

    state = state.copyWith(
      activeTemplate: state.activeTemplate.copyWith(
        formFieldConfigs: {
          ...state.activeTemplate.formFieldConfigs,
          newConfig.uid: newConfig
        }
      )
    );

    log('⚙️ FIELD CONFIG CHANGED: '
        'UID: ${newConfig.uid} | '
        'Type: ${newConfig.runtimeType} | '
        'Old: ${oldConfig.toString()} | '
        'New: ${newConfig.toString()}', 
        name: _logName
      );
  }

  void updateFormResponse({required String uid, dynamic value}) {
    final oldValue = state.formResponses[uid];
    
    if (oldValue == value) {
      log('ℹ️ RESPONSE SKIPPED: Field $uid already holds value: $value', name: _logName);
      return;
    }

    state = state.copyWith(
      formResponses: {...state.formResponses, uid: value},
    );

    log('📥 RESPONSE UPDATE: '
        'Field: $uid | '
        'Value: [$oldValue] -> [$value]', 
        name: _logName);
  }
} 

final activeTemplateProvider = 
  NotifierProvider<ActiveTemplateNotifier, ActiveTemplateState>(() {
    return ActiveTemplateNotifier();
  });