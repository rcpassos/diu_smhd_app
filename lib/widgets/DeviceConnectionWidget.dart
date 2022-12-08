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

  void _onConnectDeviceButtonPressed() {}

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
        ElevatedButton(
            onPressed: _onConnectDeviceButtonPressed,
            child: Text(_deviceId != null ? 'Remover' : "Adicionar"))
      ],
    );
  }
}
