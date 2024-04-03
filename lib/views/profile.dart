import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _profileBox = Hive.box('profile');

  @override
  void initState() {
    super.initState();

    _nameController.text = _profileBox.get('name') ?? '';
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _profileBox.put('name', _nameController.text);
      if (_image != null) {
        _profileBox.put('image', _image!.readAsBytesSync());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : (_profileBox.get('image') != null
                        ? Image.memory(_profileBox.get('image') as Uint8List)
                            .image
                        : null),
                child: _image == null && _profileBox.get('image') == null
                    ? Icon(Icons.camera_alt, size: 60.0)
                    : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
