import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class GstPanInputScreen extends StatefulWidget {
  static const routeName = "/GSTInfo";

  @override
  _GstPanInputScreenState createState() => _GstPanInputScreenState();
}

class _GstPanInputScreenState extends State<GstPanInputScreen> {
  final ImagePicker _picker = ImagePicker();
  final _gstNumberController = TextEditingController();
  final _panNumberController = TextEditingController();
  File? _gstCertificateImage;
  File? _panCardImage;

  @override
  void dispose() {
    _gstNumberController.dispose();
    _panNumberController.dispose();
    super.dispose();
  }

  Future<void> pickImage(bool isGstImage) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        if (isGstImage) {
          _gstCertificateImage = File(pickedFile.path);
        } else {
          _panCardImage = File(pickedFile.path);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload GST and PAN Documents'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GST Certificate Copy Picture:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => pickImage(true),
              child: Container(
                height: 100,
                color: Colors.grey[200],
                child: _gstCertificateImage == null
                    ? Center(
                  child: Text(
                    'Tap to select GST certificate picture',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                )
                    : Image.file(_gstCertificateImage!),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'GST Number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _gstNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter GST Number',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'PAN Card Copy Picture:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => pickImage(false),
              child: Container(
                height: 100,
                color: Colors.grey[200],
                child: _panCardImage == null
                    ? Center(
                  child: Text(
                    'Tap to select PAN card picture',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                )
                    : Image.file(_panCardImage!),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'PAN Card Number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _panNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter PAN Card Number',
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700], // Background color
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
