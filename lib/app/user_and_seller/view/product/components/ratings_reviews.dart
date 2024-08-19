import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_int2/constants/apiEndPoints.dart' ;
class ReviewWidget extends StatefulWidget {
  final String productId;
  final String userEmail;

  ReviewWidget({required this.productId, required this.userEmail});

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final _ratingController = TextEditingController();
  final _reviewController = TextEditingController();

  Future<void> _submitReview() async {
    final rating = _ratingController.text;
    final review = _reviewController.text;

    try {
      var res = await http.post(
        Uri.parse(ApiEndPoints.baseURL + '/ratings_and_reviews.php'),
        body: {
          "product_id": widget.productId,
          "user_email": widget.userEmail,
          "rating": rating,
          "review": review,
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['message'] == "Review added successfully") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Success"),
              content: Text("Review added successfully."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(resBody['message']),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a Review',
            style: TextStyle(
                color: const Color(0xFFFEFEFE),
                fontWeight: FontWeight.w600,
                fontSize: 20.0),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _ratingController,
            decoration: InputDecoration(
              labelText: 'Rating (1-5)',
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _reviewController,
            decoration: InputDecoration(
              labelText: 'Review',
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
            maxLines: 4,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitReview,
            child: Text('Submit Review'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromRGBO(253, 192, 84, 1),
            ),
          ),
        ],
      ),
    );
  }
}
