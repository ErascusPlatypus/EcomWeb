import 'package:flutter/material.dart';

class AddSellerItemScreen extends StatefulWidget {
  @override
  _AddSellerItemScreenState createState() => _AddSellerItemScreenState();
}

class _AddSellerItemScreenState extends State<AddSellerItemScreen> {
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageLinksController = TextEditingController();

  String? _selectedCategory;

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageLinksController.dispose();
    super.dispose();
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
                label: 'Product Price:',
                controller: _priceController,
                hintText: 'Enter product price',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text(
                'Category:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: ['Headphone', 'Clothes', 'Watch', 'Shoes', 'Bag']
                    .map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select category',
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
        ),
      ],
    );
  }
}
