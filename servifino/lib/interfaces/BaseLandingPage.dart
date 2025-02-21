import 'package:flutter/material.dart';
import 'package:servifino/utils/app_texts.dart';

abstract class BaseLandingPage extends StatelessWidget {
  final List<Widget> pages;
  final String title;
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(1);


  BaseLandingPage({super.key, required this.pages, required this.title, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, child) {
          return pages[selectedIndex];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: AppTexts.bottomBarTexts.firstIconText,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppTexts.bottomBarTexts.secondIconText,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: AppTexts.bottomBarTexts.thirdIconText,
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (index) {
              _selectedIndex.value = index;
            },
          );
        },
      ),
    );
  }
}
