import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/history_record_model.dart';

DateFormat format = DateFormat('yyyy年MM月dd日 HH:mm:ss');

class MuyuRecordModel extends StatelessWidget {
  final List<HistoryRecordModel> records;

  const MuyuRecordModel({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(),
      body: ListView.builder(
        itemBuilder: _buildItem, itemCount: records.length,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() =>
      AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          '功德记录', style: TextStyle(color: Colors.black, fontSize: 16),),
        elevation: 0,
        backgroundColor: Colors.white,
      );

  Widget _buildItem(BuildContext context, int index) {
    HistoryRecordModel merit = records[index];
    String date = format.format(DateTime.fromMillisecondsSinceEpoch(merit.timestamp));
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(merit.image),
      ),
      title: Text('功德 +${merit.value}'),
      subtitle: Text(
        date, style: const TextStyle(fontSize: 12, color: Colors.grey),),
      trailing: Text(merit.audio),
    );
  }
}