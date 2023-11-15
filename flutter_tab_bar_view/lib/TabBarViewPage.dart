import 'dart:async';

import 'package:flutter/material.dart';

class TabBarViewExample extends StatefulWidget {
  @override
  _TabBarViewExampleState createState() => _TabBarViewExampleState();
}

class _TabBarViewExampleState extends State<TabBarViewExample> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //Sample data for List 1
  List<String> list1 = ["Bahtınur Sinik", "Item 2", "Item 3" ,"Item 4","Item 5","Item 6","Item 7","Item 8"];

  //Sample data for List 2
  List<String> list2 = ["Item A", "Item B", "Item C","Item D","Item E","Item F"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabbar and Refresh'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshTabContent,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1
          RefreshIndicator(
            onRefresh: () => _refreshList(1),
            child: ListView.builder(
              itemCount: list1.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list1[index]),
                );
              },
            ),
          ),
          // Tab 2
          RefreshIndicator(
            onRefresh: () => _refreshList(2),
            child: ListView.builder(
              itemCount: list2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list2[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

// Metod to refresh the content of the tab
  Future<void> _refreshList(int tab) async {
    // Refresh the content based on the tab
    if (tab == 1) {
      setState(() {
        // Using a loop to update each item in list1
        for (int i = 0; i < list1.length; i++) {
          list1[i] = "${list1[i]} (Updated)";
        }
      });

      // Delay for 5 seconds and then remove the "(Updated)" suffix
      Timer(Duration(seconds: 3), () {
        setState(() {
          for (int i = 0; i < list1.length; i++) {
            list1[i] = list1[i].replaceAll(" (Updated)", "");
          }
        });
      });
    } else if (tab == 2) {
      setState(() {
        // Using a loop to update each item in list2
        for (int i = 0; i < list2.length; i++) {
          list2[i] = "${list2[i]} (Updated)";
        }
      });
      // Delay for 5 seconds and then remove the "(Updated)" suffix
      Timer(Duration(seconds: 3), () {
        setState(() {
          for (int i = 0; i < list2.length; i++) {
            list2[i] = list2[i].replaceAll(" (Updated)", "");
          }
        });
      });
    }
  }

// Method to refresh the content of both tabs when the refresh button is pressed
  Future<void> _refreshTabContent() async {
    await _refreshList(1);
    await _refreshList(2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
