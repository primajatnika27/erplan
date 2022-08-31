import 'package:flutter/material.dart';

import 'approval_leave/page.dart';
import 'approval_replacement/page.dart';

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Approval'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Leave Approval',
              ),
              Tab(
                text: 'Replacement Approval',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ApprovalLeavePage(),
            ApprovalReplacementPage(),
          ],
        ),
      ),
    );
  }
}
