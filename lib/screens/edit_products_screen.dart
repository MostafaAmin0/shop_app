import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({Key? key}) : super(key: key);

  static const route ='/edit-product';

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {

  final _priceFocusNode = FocusNode();
  final _describtionNode=FocusNode();

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _describtionNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_describtionNode);
                  },
                  focusNode: _priceFocusNode,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'DescriPtion'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _describtionNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
