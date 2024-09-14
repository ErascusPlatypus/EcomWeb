import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../../../constants/apiEndPoints.dart';
import '../profile_page/profile_page_driver.dart';

class KycPageDriver extends StatefulWidget {
  static const routeName = "/kyc_page_driver";

  @override
  _KycPageDriverState createState() => _KycPageDriverState();
}

class _KycPageDriverState extends State<KycPageDriver> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _pricePerKmController = TextEditingController();
  final _panCardController = TextEditingController();
  final _aadhaarController = TextEditingController();

  XFile? _panCardImage;
  XFile? _aadhaarImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadKycData();
  }

  Future<void> _loadKycData() async {
    final String email = ModalRoute
        .of(context as BuildContext)!
        .settings
        .arguments as String;

    var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.check_kyc);
    var response = await http.post(url, body: {"email": email});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data.containsKey('error')) {
        print('No data found');
      } else {
        _cityController.text = data['city'] ?? '';
        _areaController.text = data['area'] ?? '';
        _stateController.text = data['state'] ?? '';
        _pincodeController.text = data['pincode'] ?? '';
        _pricePerKmController.text = data['price_per_km'] ?? '';
        _panCardController.text = data['pan_card'] ?? '';
        _aadhaarController.text = data['aadhaar'] ?? '';

        // Set images if available
        setState(() {
          _panCardImage =
          data['pan_card_image'] != null ? XFile(data['pan_card_image']) : null;
          _aadhaarImage =
          data['aadhaar_image'] != null ? XFile(data['aadhaar_image']) : null;
        });
      }
    } else {
      print('Failed to load KYC data');
    }
  }

  Future<void> _pickPanCardImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _panCardImage = pickedImage;
      });
    }
  }

  Future<void> _pickAadhaarImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _aadhaarImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete KYC'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Email: $email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _cityController,
                label: 'City',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _pincodeController,
                label: 'Pincode',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _areaController,
                label: 'Area',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _stateController,
                label: 'State',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _pricePerKmController,
                label: 'Price per Km',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _panCardController,
                label: 'PAN Card Number',
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(_panCardImage == null
                    ? 'Upload PAN Card Image'
                    : 'PAN Card Image Uploaded'),
                trailing: Icon(Icons.camera_alt),
                onTap: _pickPanCardImage,
              ),
              Divider(),
              _buildTextField(
                controller: _aadhaarController,
                label: 'Aadhaar Number',
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(_aadhaarImage == null
                    ? 'Upload Aadhaar Image'
                    : 'Aadhaar Image Uploaded'),
                trailing: Icon(Icons.camera_alt),
                onTap: _pickAadhaarImage,
              ),
              Divider(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitKycData(email);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                ),
                child: Text('Submit KYC'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Future<void> _submitKycData(String email) async {
    var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.driver_kyc);

    var request = http.MultipartRequest('POST', url)
      ..fields['email'] = email
      ..fields['city'] = _cityController.text
      ..fields['area'] = _areaController.text
      ..fields['state'] = _stateController.text
      ..fields['pincode'] = _pincodeController.text
      ..fields['price_per_km'] = _pricePerKmController.text
      ..fields['pan_card'] = _panCardController.text
      ..fields['aadhaar'] = _aadhaarController.text;

    if (_panCardImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'pan_card_image',
        _panCardImage!.path,
      ));
    }

    if (_aadhaarImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'aadhaar_image',
        _aadhaarImage!.path,
      ));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();

      if (responseBody.trim() == "true") {
        Navigator.pushReplacementNamed(context as BuildContext, ProfilePageDriver.routeName, arguments: email);

      } else {
        print('Error: $responseBody');
      }
    } else {
      print('Failed to submit KYC');
    }
  }

}