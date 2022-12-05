import 'package:diu_smhd_app/models/Alert.dart';
import 'package:diu_smhd_app/services/service.dart';
import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Alertas"),
      ),
      body: FutureBuilder(
          future: getAlerts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Alert alert = snapshot.data[index] as Alert;
                  return ListTile(
                      title: Text(alert.getCreatedAtFormatted()),
                      subtitle: Text(alert.message),
                      trailing: Text(alert.title));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    indent: 20,
                    endIndent: 20,
                  );
                },
              );
            }
          }),
    );
  }
}
