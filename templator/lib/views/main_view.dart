import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:templator/pages/template_editor_page.dart';
import 'package:templator/pages/template_form_page.dart';
import 'package:templator/pages/template_manager_page.dart';
import 'package:templator/providers/active_template_notifier.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {

  late final List<Widget> _pages = [
    TemplateManager(),
    TemplateFormPage(),
  ]; 

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) { setState(() => _selectedIndex = value); },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: "Template"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Apply"
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(activeTemplateProvider.notifier).selectTemplate();
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) {
              return TemplateEditorPage();
            },)
          );
        }
      ),
    );
  }
}