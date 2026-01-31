import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/types/field_config.dart';
import 'package:templator/states/field_configs/field_selector_config.dart';
import 'package:templator/states/template_builder.dart';
import 'package:templator/states/active_template_state.dart';
import 'package:templator/types/utils.dart';

class ActiveTemplateNotifier extends Notifier<ActiveTemplateState> {
  
  @override
  ActiveTemplateState build() {
    return ActiveTemplateState(activeTemplate: TemplateBuilder(uid: 'default'));
  }

  void selectTemplate({String? uid}) {
    TemplateBuilder template = 
      ref.read(templateManagerProvider).builders?[uid]
      ?? TemplateBuilder(uid: Utils.generateUid(10));

    state = ActiveTemplateState(activeTemplate: template);
  }

  void updateTemplateProperties({
    String? name,
    String? templateText,
  }) {
    var newTemplate = state.activeTemplate.copyWith(
      name: name ?? state.activeTemplate.name,
      templateText: templateText ?? state.activeTemplate.templateText,
    ); 

    state = state.copyWith(activeTemplate: newTemplate);
    //TODO: update parentName for fields
  }
  
  void createField() {

    var newFieldConfig = FieldSelectorConfig(
      uid: Utils.generateUid(15), 
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
  }

  void updateFieldConfig(FieldConfig newConfig) {
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
    var newFormResponses = {...state.formResponses, uid: value};
    
    state = state.copyWith(
      formResponses: newFormResponses,
    );
  }
  // void clearFields() {
  //   state = state.copyWith(fieldValues: {});
  // }

} 

final activeTemplateProvider = 
  NotifierProvider<ActiveTemplateNotifier, ActiveTemplateState>(() {
    return ActiveTemplateNotifier();
  });
