
import 'package:http/http.dart';

class APIResponse {

  final Response? response;

  final int statusCode;

  APIResponse({this.response, required this.statusCode});


}
