import 'package:flutter/material.dart';

import '../providers/product.dart';
import 'package:shop_app/widget/main_drawer.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({Key? key}) : super(key: key);

  static const route = '/edit-product';

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _describtionNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  // var product =Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  late String title;
  late String describtion;
  late String imageUrl;
  late double price;

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!(_imageUrlController.text.startsWith('http') ||
              _imageUrlController.text.startsWith('https')) ||
          !(_imageUrlController.text.endsWith('png') ||
              _imageUrlController.text.endsWith('jpeg') ||
              _imageUrlController.text.endsWith('jpg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _describtionNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  void _saveFrom() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveFrom,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title can\'t be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    title = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_describtionNode);
                  },
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter valid number';
                    } else if (double.parse(value) < 0) {
                      return 'Please enter positive number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    price = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'DescriPtion'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _describtionNode,
                  onSaved: (value) {
                    describtion = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your description';
                    } else if (value.length < 10) {
                      return 'it has to be at least 10 characters long';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(child: Text('Enter Url'))
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Image Url',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveFrom(),
                        onSaved: (value) {
                          imageUrl = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your image url';
                          } else if (!(value.startsWith('https') ||
                              value.startsWith('http'))) {
                            return 'Please enter valid url with https';
                          } else if (!(value.endsWith('png') ||
                              value.endsWith('jpg') ||
                              value.endsWith('jpeg'))) {
                            return 'please enter image';
                          }
                          return null;
                        },

                        ///works for me without these lines
                        // onEditingComplete: () {
                        //   setState(() {});
                        // },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
