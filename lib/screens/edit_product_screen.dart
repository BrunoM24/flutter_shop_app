import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

  Product _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imgUrl: '',
    isFavorite: false,
  );

  String _imgUrl = '';

  void save() {
    setState(() {
      _isLoading = true;
    });

    if (!_form.currentState!.validate()) return;

    _form.currentState?.save();

    Provider.of<Products>(context, listen: false)
        .addProduct(_product)
        .catchError(
          (error) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('An Error occurred!'),
              content: const Text('Something went wrong.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        )
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Title')),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a vue.';
                      }
                    },
                    onSaved: (value) =>
                        _product = _product.copyWith(title: value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Price')),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PLease enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid price';
                      }
                    },
                    onSaved: (value) {
                      if (double.tryParse(value!) != null) {
                        _product =
                            _product.copyWith(price: double.parse(value));
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(label: Text('Description')),
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    onSaved: (value) =>
                        _product = _product.copyWith(description: value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Image Url')),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => setState(() => _imgUrl = value),
                    onSaved: (value) =>
                        _product = _product.copyWith(imgUrl: value),
                    onFieldSubmitted: (value) => save(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: MaterialButton(
                      height: 48,
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      onPressed: save,
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
