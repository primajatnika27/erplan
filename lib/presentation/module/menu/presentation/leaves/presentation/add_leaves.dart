import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddLeavesPage extends StatefulWidget {
  const AddLeavesPage({Key? key}) : super(key: key);

  @override
  State<AddLeavesPage> createState() => _AddLeavesPageState();
}

class _AddLeavesPageState extends State<AddLeavesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 37, 43, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add Leaves"),
        centerTitle: false,
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
