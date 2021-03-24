import 'package:flutter/material.dart';

import '../components/main_drawer.dart';
import '../models/settings.dart';
import '../utils/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChanged;
  const SettingsScreen(this.settings, this.onSettingsChanged);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(String title, String subtitle, bool value, Function(bool) onChange) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChange(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
        ),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Filtros',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem glúten',
                  'Exibir apenas refeições sem glúten',
                  settings.isGlutenFree,
                  (value) => setState(() => settings.isGlutenFree = value)
                ),
                _createSwitch(
                  'Sem lactose',
                  'Exibir apenas refeições sem lactose',
                  settings.isLactoseFree,
                  (value) => setState(() => settings.isLactoseFree = value)
                ),
                _createSwitch(
                  'Vegana',
                  'Exibir apenas refeições veganas',
                  settings.isVegan,
                  (value) => setState(() => settings.isVegan = value)
                ),
                _createSwitch(
                  'Vegetariana',
                  'Exibir apenas refeições vegetarianas',
                  settings.isVegetarian,
                  (value) => setState(() => settings.isVegetarian = value)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}