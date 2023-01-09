import 'package:diu_smhd_app/models/LastDataItem.dart';
import 'package:diu_smhd_app/services/service.dart';
import 'package:flutter/material.dart';

class LastDataWidget extends StatefulWidget {
  const LastDataWidget({super.key});

  @override
  State<LastDataWidget> createState() => _LastDataWidgetState();
}

class _LastDataWidgetState extends State<LastDataWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLastDeviceData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                LastDataItem lastDataItem =
                    snapshot.data[index] as LastDataItem;
                return ListTile(
                  title: Text(lastDataItem.key),
                  trailing: Text(lastDataItem.value),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  indent: 20,
                  endIndent: 20,
                );
              },
            );
          }
        });
  }
}
