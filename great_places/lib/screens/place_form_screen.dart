import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _tileController = TextEditingController();
  late File? _pickedImage;
  
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_tileController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _tileController.text,
      _pickedImage
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo lugar')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _tileController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    SizedBox(height: 10),
                    ImageInput(this._selectImage)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _submitForm,
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0
            ),
          )
        ],
      ),
    );
  }
}