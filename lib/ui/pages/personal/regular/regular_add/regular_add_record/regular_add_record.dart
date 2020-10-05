import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/regular/regular_add/regular_add_record/regular_add_record_content.dart';

class DYXRegularAddRecordPage extends StatefulWidget {
  @override
  _DYXRegularAddRecordPageState createState() => _DYXRegularAddRecordPageState();
}

class _DYXRegularAddRecordPageState extends State<DYXRegularAddRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: DYXRegularAddRecordContent(),
    );
  }
}
