import 'package:diu_smhd_app/widgets/DeviceConnectionWidget.dart';
import 'package:diu_smhd_app/widgets/MetricsWidget.dart';
import 'package:flutter/material.dart';

class DeviceTabsWidget extends StatefulWidget {
  const DeviceTabsWidget({super.key});

  @override
  State<DeviceTabsWidget> createState() => _DeviceTabsWidgetState();
}

class _DeviceTabsWidgetState extends State<DeviceTabsWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.green,
            indicatorColor: Colors.green,
            tabs: const [
              Tab(
                text: 'DISPOSITIVO',
              ),
              Tab(
                text: 'MÉTRICAS',
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                DeviceConnectionWidget(),
                MetricsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
