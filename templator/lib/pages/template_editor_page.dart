import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/providers/active_template_notifier.dart';
import 'package:templator/providers/template_manager_notifier.dart';
import 'package:templator/states/template_builder.dart';

class TemplateEditorPage extends ConsumerStatefulWidget {
  const TemplateEditorPage({
    super.key,
  });

  @override
  ConsumerState<TemplateEditorPage> createState() => _TemplateEditorPageState();
}

class _TemplateEditorPageState extends ConsumerState<TemplateEditorPage> {

  Timer? _timer;
  void _debounce(String value, void Function(String value) onValueUpdate){
    if (_timer?.isActive ?? false) _timer!.cancel();

    _timer = Timer(Duration(milliseconds: 500), () {
      onValueUpdate(value);
    });
  }

  late final TextEditingController templateNameController;
  late final TextEditingController templateTextController;

  @override
  void initState() {
    TemplateBuilder activeTemplate = ref.read(activeTemplateProvider.select((state) {
      return state.activeTemplate;
    }));

    templateNameController = TextEditingController(
      text: activeTemplate.name 
    );
    templateTextController = TextEditingController(
      text: activeTemplate.templateText 
    ); 

    super.initState();
  }

  @override
  void dispose() {
    templateNameController.dispose();
    templateTextController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(context) {
    var activeTemplateNotifier = ref.watch(activeTemplateProvider.notifier); 
    TemplateBuilder activeTemplate = ref.watch(activeTemplateProvider.select((state) {
      return state.activeTemplate;
    }));
    

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          
          ref.read(templateManagerProvider.notifier).updateBuilder(activeTemplate);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Add New Template"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                controller: templateNameController,
                onChanged: (value) => _debounce(value, (value) {
                  activeTemplateNotifier.updateTemplateProperties(name: value);
                }),
                decoration: InputDecoration(
                  hintText: "Your Template Name",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: templateTextController,
                  onChanged: (value) => _debounce(value, (value) {
                    activeTemplateNotifier.updateTemplateProperties(templateText: value);
                  }),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Your Template Text",
                    // ignore: prefer_adjacent_string_concatenation
                    helperText: "surround your text to replace like this: {{keyword}}. " +
                      "making the keyword succinct is reccommended",
                    helperMaxLines: 2,
                    border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  )
                ),
              ),
              Column(
                children: activeTemplate.buildEditorFields(
                  activeTemplateNotifier: activeTemplateNotifier,
                )
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                      activeTemplateNotifier.selectTemplate();
                    }, 
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            activeTemplateNotifier.createField();
          }
        ),
      ),
    );
  }
}