import 'package:diu_smhd_app/services/service.dart';
import 'package:flutter/material.dart';

class DeviceConnectionWidget extends StatefulWidget {
  const DeviceConnectionWidget({super.key});

  @override
  State<DeviceConnectionWidget> createState() => _DeviceConnectionWidgetState();
}

class _DeviceConnectionWidgetState extends State<DeviceConnectionWidget> {
  String? _deviceId;

  @override
  void initState() {
    super.initState();

    getDeviceId().then((value) => {
          setState(() {
            _deviceId = value;
          })
        });
  }

  void _onConnectDeviceButtonPressed() {
    // https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
    if (_deviceId != null) {
      // remove
    } else {
      // add
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            style: Theme.of(context).textTheme.headline6,
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
            onPressed: _onConnectDeviceButtonPressed,
          ),
        )
      ],
    );
  }
}
