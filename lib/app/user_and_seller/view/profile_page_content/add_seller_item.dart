import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class AddSellerItemScreen extends StatefulWidget {
  @override
  _AddSellerItemScreenState createState() => _AddSellerItemScreenState();
}

class _AddSellerItemScreenState extends State<AddSellerItemScreen> {
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _mrpController = TextEditingController();
  final _imageLinksController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorOptionsController = TextEditingController();
  final _weightController = TextEditingController();
  final _deliveryFeeController = TextEditingController();
  final _stockController = TextEditingController();
  final _gstRateController = TextEditingController();
  final _customCategoryController = TextEditingController();

  String? _selectedCategory;
  String? _deliveryPaidBy; // To choose between User or Seller for delivery fee
  double _totalPrice = 0.0;
  bool _isCustomCategory = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _mrpController.dispose();
    _imageLinksController.dispose();
    _brandController.dispose();
    _colorOptionsController.dispose();
    _weightController.dispose();
    _deliveryFeeController.dispose();
    _stockController.dispose();
    _gstRateController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    final mrp = double.tryParse(_mrpController.text) ?? 0.0;
    final gstRate = double.tryParse(_gstRateController.text) ?? 0.0;
    final gstAmount = mrp * gstRate / 100;
    setState(() {
      _totalPrice = mrp + gstAmount;
    });
  }

  Future<void> _addNewItem() async {
    try {
      var response = await http.post(
        Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.add_seller_item),
        body: {
          'product_name': _productNameController.text,
          'description': _descriptionController.text,
          'mrp': _mrpController.text,
          'gst_rate': _gstRateController.text,
          'total_price': _totalPrice.toString(),
          'category': _isCustomCategory ? _customCategoryController.text : _selectedCategory ?? '',
          'brand': _brandController.text,
          'color_options': _colorOptionsController.text,
          'weight': _weightController.text,
          'delivery_paid_by': _deliveryPaidBy ?? '',
          'available_stock': _stockController.text,
          'image_links': _imageLinksController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          _showDialog('Success', 'Item added successfully');
        } else {
          _showDialog('Failure', 'Failed to insert item');
        }
      } else {
        _showDialog('Error', 'Server error. Please try again later.');
      }
    } catch (e) {
      _showDialog('Error', 'An error occurred: $e');
    }
  }

// Method to show dialog box
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                label: 'Product Name:',
                controller: _productNameController,
                hintText: 'Enter product name',
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'Description:',
                controller: _descriptionController,
                hintText: 'Enter product description',
                maxLines: 3,
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'MRP:',
                controller: _mrpController,
                hintText: 'Enter MRP',
                keyboardType: TextInputType.number,
                onChanged: (value) => _calculateTotalPrice(),
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'GST Rate (%):',
                controller: _gstRateController,
                hintText: 'Enter GST rate',
                keyboardType: TextInputType.number,
                onChanged: (value) => _calculateTotalPrice(),
              ),
              SizedBox(height: 16),
              Text(
                'Total Price (including GST): $_totalPrice',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Category:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _isCustomCategory ? null : _selectedCategory,
                items: [
                  'Headphone', 'Clothes', 'Watch', 'Shoes', 'Bag', 'Custom'
                ].map((category) => DropdownMenuItem<String>(
                  value: category == 'Custom' ? null : category,
                  child: Text(category),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      _isCustomCategory = true;
                    } else {
                      _isCustomCategory = false;
                      _selectedCategory = value;
                    }
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select category',
                ),
              ),
              if (_isCustomCategory) ...[
                SizedBox(height: 16),
                _buildInputField(
                  label: 'Custom Category:',
                  controller: _customCategoryController,
                  hintText: 'Enter custom category',
                ),
              ],
              SizedBox(height: 16),
              _buildInputField(
                label: 'Brand Name:',
                controller: _brandController,
                hintText: 'Enter brand name',
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'Color Options (comma-separated):',
                controller: _colorOptionsController,
                hintText: 'Enter color options',
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'Weight (in grams):',
                controller: _weightController,
                hintText: 'Enter weight',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'Available Stock:',
                controller: _stockController,
                hintText: 'Enter available stock',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text(
                'Delivery Fee to be Paid by:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _deliveryPaidBy,
                items: ['User', 'Seller']
                    .map((role) => DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _deliveryPaidBy = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select who pays the delivery fee',
                ),
              ),
              SizedBox(height: 16),
              _buildInputField(
                label: 'Image Links (comma-separated):',
                controller: _imageLinksController,
                hintText: 'Enter image URLs',
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                    _addNewItem();
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
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
