import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _tileController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPostion(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValidForm() {
    return _tileController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _tileController.text,
      _pickedImage,
      _pickedPosition,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo lugar')),
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
                    ImageInput(this._selectImage),
                    SizedBox(height: 10),
                    LocationInput(this._selectPostion),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isValidForm() ? _submitForm : null,
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
