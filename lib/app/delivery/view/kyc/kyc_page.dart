import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickPanCardImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _panCardImage = pickedImage;
    });
  }

  Future<void> _pickAadhaarImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _aadhaarImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

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
                    // Process the KYC data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('KYC Completed')),
                    );
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
}
