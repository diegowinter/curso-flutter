import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  void _updateImageUrl() {
    if(isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool isValidProtocol = url.toLowerCase().startsWith(RegExp('http(s)?:\/\/'));
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');

    return isValidProtocol && (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  void _saveForm() {
    bool isValid = _form.currentState.validate();

    if (!isValid) return;

    _form.currentState.save();
    final newProduct = Product(
      id: Random().nextDouble.toString(),
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl']
    );

    Provider.of<Products>(context, listen: false).addProduct(newProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child:
            ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Título'
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) => _formData['title'] = value,
                  validator: (value) {
                    bool isTitleEmpty = value.trim().isEmpty;
                    bool isTitleInvalid = value.trim().length < 3;
                    if (isTitleEmpty || isTitleInvalid) {
                      return 'Informe um título válido com no mínimo 3 caracteres.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preço'
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) => _formData['price'] = double.parse(value),
                  validator: (value) {
                    bool isPriceEmpty = value.trim().isEmpty;
                    var newPrice = double.tryParse(value);
                    bool isPriceInvalid = newPrice == null || newPrice <= 0;
                    if (isPriceEmpty || isPriceInvalid) {
                      return 'Informe um valor válido';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descrição'
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) => _formData['description'] = value,
                  validator: (value) {
                    bool isDescriptionEmpty = value.trim().isEmpty;
                    bool isDescriptionInvalid = value.trim().length < 10;
                    if (isDescriptionEmpty || isDescriptionInvalid) {
                      return 'Informe uma descrição válida com no mínimo 10 caracteres.';
                    }
                    
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'URL da Imagem'
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) => _formData['imageUrl'] = value,
                        validator: (value) {
                          bool isUrlEmpty = value.trim().isEmpty;
                          bool isUrlInvalid = !isValidImageUrl(value);
                          if (isUrlEmpty || isUrlInvalid) {
                            return 'Informe uma URL válida.';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        left: 10
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1
                        )
                      ),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty 
                        ? Text('Informe a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text
                            ),
                            fit: BoxFit.cover,
                          ),
                    )
                  ],
                )
              ],
          ),
        ),
      ),
    );
  }
}