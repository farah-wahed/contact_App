import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/Constants/app_Assets.dart';
import '../../core/model/userModel.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _imagePath;

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'User Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xff29384D)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 9,
            children: [
              Row(
                spacing: 7,
                children: [
                  Bounceable(
                    onTap: () async {
                      await pickImageFromGallery();
                    },
                    child: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : AssetImage(AppAssets.imageIcon)
                                    as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xffE2F4F6),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userNameController.text.isEmpty
                            ? "User Name"
                            : userNameController.text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffE2F4F6),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: const Divider(color: Color(0xffE2F4F6)),
                      ),
                      Text(
                        emailController.text.isEmpty
                            ? "example@email.com"
                            : emailController.text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffE2F4F6),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: const Divider(color: Color(0xffE2F4F6)),
                      ),
                      Text(
                        phoneController.text.isEmpty
                            ? "+200000000000"
                            : phoneController.text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffE2F4F6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextFormField(
                controller: userNameController,
                validator: validateUserName,
                decoration: InputDecoration(
                  hintText: "Enter User Name ",
                  hintStyle: const TextStyle(
                    color: Color(0xffE2F4F6),
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xffE2F4F6),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xffE2F4F6),
                      width: 2,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: emailController,
                validator: validateEmail,
                decoration: InputDecoration(
                  hintText: "Enter User Email",
                  hintStyle: const TextStyle(
                    color: Color(0xffE2F4F6),
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xffE2F4F6),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xffE2F4F6),
                      width: 2,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: phoneController,
                validator: validatePhone,
                decoration: InputDecoration(
                  hintText: "Enter User Phone ",
                  hintStyle: const TextStyle(
                    color: Color(0xffE2F4F6),
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xffE2F4F6),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xffE2F4F6),
                      width: 2,
                    ),
                  ),
                ),
              ),
              Bounceable(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final user = UserModel(
                      name: userNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      imagePath: _imagePath,
                    );

                    Navigator.pop(context, user);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF1D4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Enter user",
                    style: TextStyle(color: Color(0xff29384D), fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
