// settings_page.dart
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_settings/app_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _storage = const FlutterSecureStorage();
  bool _darkMode = false, _notifications = false, _changingPassword = false;
  double _fontSize = 16;
  String _language = 'English';
  final _curCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final dark = await _storage.read(key: 'darkMode') == 'true';
    final notif = await _storage.read(key: 'notifications') == 'true';
    final fontStr = await _storage.read(key: 'fontSize');
    final lang = await _storage.read(key: 'language') ?? 'English';

    setState(() {
      _darkMode = dark;
      _notifications = notif;
      _fontSize = double.tryParse(fontStr ?? '') ?? 16;
      _language = lang;
    });

    if (_darkMode) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  Future<void> _updateBool(String key, bool value) =>
      _storage.write(key: key, value: value.toString());

  Future<void> _updateFontSize(double value) =>
      _storage.write(key: 'fontSize', value: value.toString());

  Future<void> _updateLanguage(String value) =>
      _storage.write(key: 'language', value: value);

  Future<void> _changePassword() async {
    final cur = _curCtrl.text, neu = _newCtrl.text, con = _confirmCtrl.text;

    if (neu != con || neu.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(neu != con ? "New passwords don't match." : "Password too short.")),
      );
      return;
    }

    final stored = await _storage.read(key: 'userPassword');
    if (stored != cur) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Current password incorrect.')),
      );
      return;
    }

    await _storage.write(key: 'userPassword', value: neu);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully!')),
    );
    setState(() => _changingPassword = false);
    _curCtrl.clear();
    _newCtrl.clear();
    _confirmCtrl.clear();
  }

  Future<void> _reset() async {
    await _storage.deleteAll();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          secondary: const Icon(Icons.dark_mode),
          value: _darkMode,
          onChanged: (v) async {
            setState(() => _darkMode = v);
            await _storage.write(key: 'darkMode', value: v.toString());
            if (v) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
          },
        ),
        SwitchListTile(
          title: const Text('Notifications'),
          secondary: const Icon(Icons.notifications_active),
          value: _notifications,
          onChanged: (v) {
            setState(() => _notifications = v);
            _updateBool('notifications', v);
          },
        ),
        ListTile(
          leading: const Icon(Icons.text_fields),
          title: const Text('Font Size'),
          subtitle: Text(_fontSize.toStringAsFixed(0)),
          trailing: SizedBox(
            width: 150,
            child: Slider(
              min: 12,
              max: 24,
              divisions: 12,
              value: _fontSize,
              label: _fontSize.toStringAsFixed(0),
              onChanged: (v) {
                setState(() => _fontSize = v);
                _updateFontSize(v);
              },
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          trailing: DropdownButton<String>(
            value: _language,
            items: ['English', 'Spanish', 'Hindi']
                .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => _language = v);
                _updateLanguage(v);
              }
            },
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.vpn_key),
          title: const Text('Change Password'),
          trailing:
          Icon(_changingPassword ? Icons.expand_less : Icons.chevron_right),
          onTap: () => setState(() => _changingPassword = !_changingPassword),
        ),
        if (_changingPassword)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              TextField(
                controller: _curCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Current Password'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _newCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm New Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade900, // Set your desired button color
                  foregroundColor: Colors.white, // Text color (optional)
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: const Text('Update Password'),
              ),
            ]),
          ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Open App Settings'),
          onTap: () => AppSettings.openAppSettings(),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () => showAboutDialog(
            context: context,
            applicationName: 'Student App',
            applicationVersion: '1.0.0',
            children: const [Text('Custom settings demo')],
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.restore),
          title: const Text('Reset Settings'),
          onTap: _reset,
        ),
      ]),
    );
  }
}
