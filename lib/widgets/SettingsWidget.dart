import 'package:app_settings/app_settings.dart';
import 'package:diu_smhd_app/helpers/helpers.dart';
import 'package:diu_smhd_app/pages/AboutAppPage.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  void _onContactSupportTapped() {
    openUrl("mailto:helpdesk@smhd.org");
  }

  void _onManageNotificationsTapped() {
    AppSettings.openNotificationSettings();
  }

  void _onAboutAppTapped(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutAppPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
          //          <-- ListTile.divideTiles
          context: context,
          tiles: [
            ListTile(
              title: Text(
                  style: Theme.of(context).textTheme.headline6,
                  'Definições da Aplicação'),
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline,
                size: 20.0,
              ),
              title: const Text('Contactar Suporte'),
              onTap: _onContactSupportTapped,
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications_active_outlined,
                size: 20.0,
              ),
              title: const Text('Gerir Notificações'),
              onTap: _onManageNotificationsTapped,
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                size: 20.0,
              ),
              title: const Text('Sobre a Aplicação'),
              onTap: () {
                _onAboutAppTapped(context);
              },
            ),
          ]).toList(),
    );
  }
}
