import 'package:crud_app/Pages/add_page.dart';
import 'package:crud_app/Pages/app_bar.dart';
import 'package:crud_app/Pages/item_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const AppBarNew(
          sectionName: ' CRUD',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: const ItemList(),
          ),
        ),
      ),
    );
  }
}
