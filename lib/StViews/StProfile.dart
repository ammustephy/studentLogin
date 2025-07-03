import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student/StProvider/StAuthentication_Provider.dart'; // keep your AuthProvider import

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImageFile;
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthProvider>();
    // Initialize controllers with stored student details or empty if null
    _nameCtrl = TextEditingController(text: auth.studentName ?? '');
    _emailCtrl = TextEditingController(text: auth.studentEmail ?? '');
    _phoneCtrl = TextEditingController(text: auth.studentPhone ?? '');
    // If you store profile photo path/url, initialize _profileImageFile from there
    // For now, let's assume no image stored:
    _profileImageFile = null;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? file = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (file != null) {
        setState(() => _profileImageFile = File(file.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() != true) return;

    final auth = context.read<AuthProvider>();

    // Save details to provider (and backend/local storage if needed)
    auth.updateProfile(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      photoFile: _profileImageFile,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile')
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Stack(alignment: Alignment.bottomRight, children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.indigo.shade200,
              backgroundImage: _profileImageFile != null
                  ? FileImage(_profileImageFile!)
                  : (auth.studentPhotoFile != null
                  ? FileImage(auth.studentPhotoFile!)
                  : const AssetImage('assets/logo.png')
              as ImageProvider),
            ),
            InkWell(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt, color: Colors.indigo.shade700),
              ),
            ),
          ]),
          const SizedBox(height: 25),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _nameCtrl,
                decoration:
                const InputDecoration(hintText: 'Enter your name'),
                validator: (v) => v?.isEmpty == true ? 'Enter name' : null,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _emailCtrl,
                decoration:
                const InputDecoration(hintText: 'Enter your email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter email';
                  final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                  return regex.hasMatch(v) ? null : 'Enter valid email';
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _phoneCtrl,
                decoration:
                const InputDecoration(hintText: 'Enter your phone number'),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter phone';
                  return RegExp(r'^\d{10}$').hasMatch(v)
                      ? null
                      : 'Enter 10-digit phone';
                },
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade900),
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save,color: Colors.white,),
                  label:
                  const Text('Save Profile', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              // const SizedBox(height: 40),
              // SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: ElevatedButton.icon(
              //     style:
              //     ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade900),
              //     icon: const Icon(Icons.logout),
              //     label:
              //     const Text('Logout', style: TextStyle(fontSize: 18)),
              //     onPressed: () {
              //       auth.logout();
              //       Navigator.pushNamedAndRemoveUntil(
              //           context, '/login', (r) => false);
              //     },
              //   ),
              // ),
            ]),
          ),
        ]),
      ),
    );
  }
}