import 'package:flutter/material.dart';
import 'package:templator/pages/template_manager_page.dart';
import 'package:templator/pages/apply_template_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  late final List<Widget> _pages = [
    TemplateManager(),
    ApplyTemplatePage(),
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
        onTap: (value) { setState(() {_selectedIndex = value;}); },
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
      )
    );
  }
}