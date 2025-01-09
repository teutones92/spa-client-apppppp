import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spa_client_app/domain/service/client_app_settings_service/client_app_settings_service.dart';
import 'package:spa_client_app/models/server/client_app_settings_model/client_app_settings_model.dart';

import '../../../config/bloc_config.dart';

class ClientAppSettingsBloc extends Cubit<ClientAppSettingsModel> {
  ClientAppSettingsBloc() : super(ClientAppSettingsModel());
  late TextEditingController controller =
      TextEditingController(text: state.setting?.value);

  final _fromKey = GlobalKey<FormState>();

  Future<void> getSettings() async {
    final settings = await ClientAppSettingsService.read();
    if (settings != null) emit(settings);
  }

  void setAccessTime(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Temp User Access Time'),
          content: Form(
            key: _fromKey,
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                  labelText: 'Time in Hours', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_fromKey.currentState!.validate()) {
                  Navigator.pop(context);
                  saveSettings();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void saveSettings() async {
    if (_fromKey.currentState!.validate()) {
      final setting = SettingModel(
        key: 'temp_user_access_time',
        value: controller.text,
      );
      final settings = state.copyWith(setting: setting);
      await ClientAppSettingsService.update(settings);
      emit(settings);
    }
  }
}
