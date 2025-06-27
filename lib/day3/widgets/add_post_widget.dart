import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/day3/models/task.dart';
import 'package:flutter_application_1/day3/widgets/common_elevated_button_widget.dart';
import 'package:flutter_application_1/day3/widgets/login_textfield_widget.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddPostWidget extends StatefulWidget {
  final VoidCallback onAddTask;
  const AddPostWidget({super.key, required this.onAddTask});

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  final TextEditingController _descController = TextEditingController();
  late final GlobalKey<FormState> keyform;

  final List<Task> tasks = [];
  File? _selectedImage;
  String? _base64Image;

  @override
  void initState() {
    keyform = GlobalKey<FormState>();
    super.initState();
  }

  Future<void> _addPost() async {
    if (keyform.currentState!.validate()) {
      final description = _descController.text.trim();
      final user = FirebaseAuth.instance.currentUser;
      if (description.isNotEmpty && user != null) {
        try {
          await FirebaseFirestore.instance.collection('posts').add({
            'description': description,
            'image': _base64Image ?? '',
            'createdAt': FieldValue.serverTimestamp(),
            'userEmail': user.email ?? '',
            'userName': user.displayName ?? '',
            'userId': user.uid,
          });
          _descController.clear();
          setState(() {
            _selectedImage = null;
            _base64Image = null;
          });
          widget.onAddTask.call();
          Navigator.of(context).pop();
        } catch (e) {
          print(e);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to add post: $e')));
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      final bytes = await pickedFile.readAsBytes();
      _base64Image = base64Encode(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: const Text("Add new post")),
      content: SafeArea(
        child: Form(
          key: keyform,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 100),
                child: LoginTextFieldWidget(
                  controller: _descController,
                  labelText: "Description",
                  formFieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.description),
                  maxLines: null,
                  isExpanded: true,
                ),
              ),
              SizedBox(height: 12),
              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 100)
                  : SizedBox.shrink(),
              TextButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
              ),
            ],
          ),
        ),
      ),
      actions: [CommonElevatedButton(onTap: _addPost, text: "Add Post")],
    );
  }
}
