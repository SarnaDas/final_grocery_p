import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_p/screens/my_product.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadProduct() async {
    if (_image == null ||
        _titleController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      // Show some error message
      return;
    }

    // Upload image to Firebase Storage
    String imageUrl;
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_image!);
      imageUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print(e);
      return;
    }

    // Add product details to Firestore
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'title': _titleController.text,
        'quantity': int.parse(_quantityController.text),
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the form fields
      _titleController.clear();
      _quantityController.clear();
      _priceController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
      });

      // Navigate to ProductListPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyProducts()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[300],
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 50)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Product Title'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Number of Products'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price per Unit'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
