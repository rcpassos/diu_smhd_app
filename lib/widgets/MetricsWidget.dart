import 'package:diu_smhd_app/models/Metrics.dart';
import 'package:diu_smhd_app/services/service.dart';
import 'package:flutter/material.dart';

class MetricsWidget extends StatefulWidget {
  const MetricsWidget({super.key});

  @override
  State<MetricsWidget> createState() => _MetricsWidgetState();
}

class _MetricsWidgetState extends State<MetricsWidget> {
  bool _editing = false;
  final TextEditingController _phSoilMinTextFieldController =
      TextEditingController();
  final TextEditingController _phSoilMaxTextFieldController =
      TextEditingController();
  final TextEditingController _soilMoistureMinTextFieldController =
      TextEditingController();
  final TextEditingController _soilMoistureMaxTextFieldController =
      TextEditingController();
  final TextEditingController _uvIndexMinTextFieldController =
      TextEditingController();
  final TextEditingController _uvIndexMaxTextFieldController =
      TextEditingController();
  final TextEditingController _temperatureMinTextFieldController =
      TextEditingController();
  final TextEditingController _temperatureMaxTextFieldController =
      TextEditingController();
  final TextEditingController _humidityMinTextFieldController =
      TextEditingController();
  final TextEditingController _humidityMaxTextFieldController =
      TextEditingController();
  final TextEditingController _lightIntensityMinTextFieldController =
      TextEditingController();
  final TextEditingController _lightIntensityMaxTextFieldController =
      TextEditingController();

  void _getMetrics() {
    getMetrics().then((metrics) {
      setState(() {
        _phSoilMinTextFieldController.text = metrics.phSoilMin;
        _phSoilMaxTextFieldController.text = metrics.phSoilMax;
        _soilMoistureMinTextFieldController.text = metrics.soilMoistureMin;
        _soilMoistureMaxTextFieldController.text = metrics.soilMoistureMax;
        _uvIndexMinTextFieldController.text = metrics.uvIndexMin;
        _uvIndexMaxTextFieldController.text = metrics.uvIndexMax;
        _temperatureMinTextFieldController.text = metrics.temperatureMin;
        _temperatureMaxTextFieldController.text = metrics.temperatureMax;
        _humidityMinTextFieldController.text = metrics.humidityMin;
        _humidityMaxTextFieldController.text = metrics.humidityMax;
        _lightIntensityMinTextFieldController.text = metrics.lightIntensityMin;
        _lightIntensityMaxTextFieldController.text = metrics.lightIntensityMax;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _getMetrics();
  }

  Future<void> _saveMetrics() async {
    Metrics metrics = Metrics(
      _phSoilMinTextFieldController.text,
      _phSoilMaxTextFieldController.text,
      _soilMoistureMinTextFieldController.text,
      _soilMoistureMaxTextFieldController.text,
      _uvIndexMinTextFieldController.text,
      _uvIndexMaxTextFieldController.text,
      _temperatureMinTextFieldController.text,
      _temperatureMaxTextFieldController.text,
      _humidityMinTextFieldController.text,
      _humidityMaxTextFieldController.text,
      _lightIntensityMinTextFieldController.text,
      _lightIntensityMaxTextFieldController.text,
    );

    await saveMetrics(metrics);

    final successSnackBar = SnackBar(
      backgroundColor: Colors.green[900],
      content: const Text('Métricas atualizadas com sucesso'),
    );

    setState(() {
      _editing = false;

      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
    });
  }

  Widget _getActionsWidget() {
    if (_editing) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: SizedBox(
              height: 48.0,
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  side: const BorderSide(width: 2.0, color: Colors.black),
                ),
                icon: const Icon(Icons.cancel_outlined, size: 24),
                label: const Text("CANCELAR"),
                onPressed: () {
                  setState(() {
                    _getMetrics();
                    _editing = false;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              height: 48.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                label: const Text("GUARDAR"),
                backgroundColor: Colors.black,
                icon: const Icon(
                  Icons.save_outlined,
                  size: 24.0,
                ),
                onPressed: _saveMetrics,
              ),
            ),
          ),
        ],
      );
    } else {
      return FloatingActionButton.extended(
        label: const Text("EDITAR"),
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.edit_outlined,
          size: 24.0,
        ),
        onPressed: () {
          setState(() {
            _editing = true;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PH Solo",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mínimo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller: _phSoilMinTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Máximo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller: _phSoilMaxTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ColoredBox(color: Colors.black12),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Humidade Solo",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mínimo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _soilMoistureMinTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Máximo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _soilMoistureMaxTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ColoredBox(color: Colors.black12),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Índice UV",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mínimo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _uvIndexMinTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Máximo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _uvIndexMaxTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ColoredBox(color: Colors.black12),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Temperature",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mínimo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _temperatureMinTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Máximo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _temperatureMaxTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ColoredBox(color: Colors.black12),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Humidade",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mínimo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _humidityMinTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Máximo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _humidityMaxTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ColoredBox(color: Colors.black12),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Luminosidade",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mínimo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _lightIntensityMinTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Máximo"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: TextField(
                                      controller:
                                          _lightIntensityMaxTextFieldController,
                                      keyboardType: TextInputType.number,
                                      enabled: _editing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ColoredBox(color: Colors.black12),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          width: double.infinity,
          child: _getActionsWidget(),
        ),
      ],
    );
  }
}
