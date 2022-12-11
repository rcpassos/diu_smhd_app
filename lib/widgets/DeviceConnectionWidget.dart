import 'package:diu_smhd_app/services/service.dart';
import 'package:flutter/material.dart';

class DeviceConnectionWidget extends StatefulWidget {
  const DeviceConnectionWidget({super.key});

  @override
  State<DeviceConnectionWidget> createState() => _DeviceConnectionWidgetState();
}

class _DeviceConnectionWidgetState extends State<DeviceConnectionWidget> {
  String? _deviceId;
  TextEditingController _textFieldController = TextEditingController();
  String _newDeviceId = "";

  @override
  void initState() {
    super.initState();

    getDeviceId().then((value) =>
    {
      setState(() {
        _deviceId = value;
      })
    });
  }

  Future<void> _displayRemoveDeviceConfirmationDialog(
      BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Remover Dispositivo'),
            content: Text(
                "Tem a certeza que pretende remover o dispositivo ${_deviceId}?"),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // foreground
                ),
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    _newDeviceId = "";
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red, // foreground
                ),
                onPressed: () async {
                  await removeDeviceId();

                  final successSnackBar = SnackBar(
                    backgroundColor: Colors.green[900],
                    content: const Text('Dispositivo removido com sucesso'),
                  );

                  setState(() {
                    _deviceId = null;
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                  });
                },
                child: const Text('SIM'),
              ),
            ],
          );
        });
  }

  Future<void> _displayAddDeviceDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Adicionar Dispositivo'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _newDeviceId = value;
                });
              },
              autofocus: true,
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: "Nº Dispositivo",
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // foreground
                ),
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    _newDeviceId = "";
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // foreground
                ),
                onPressed: () async {
                  await saveDeviceId(_newDeviceId);

                  final successSnackBar = SnackBar(
                    backgroundColor: Colors.green[900],
                    content: const Text('Dispositivo adicionado com sucesso'),
                  );

                  setState(() {
                    _deviceId = _newDeviceId;
                    _newDeviceId = "";
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                  });
                },
                child: const Text('SUBMETER'),
              ),
            ],
          );
        });
  }

  void _onConnectDeviceButtonPressed(BuildContext context) {
    if (_deviceId != null) {
      _displayRemoveDeviceConfirmationDialog(context);
    } else {
      _displayAddDeviceDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            style: Theme
                .of(context)
                .textTheme
                .headline6,
            _deviceId != null
                ? "Dispositivo ${_deviceId} está conectado"
                : "Dispositivo não encontrado"),
        Container(
          margin: const EdgeInsets.all(20.0),
          width: double.infinity,
          child: FloatingActionButton.extended(
            label: Text(_deviceId != null ? 'REMOVER' : "ADICIONAR"),
            backgroundColor: Colors.black,
            icon: Icon(
              _deviceId != null ? Icons.delete_outline : Icons.add,
              size: 24.0,
            ),
            onPressed: () {
              _onConnectDeviceButtonPressed(context);
            },
          ),
        )
      ],
    );
  }
}
