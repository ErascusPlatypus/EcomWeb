import 'package:ecommerce_int2/app/user_and_seller/model/coordinates.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/timezone.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location1 {
  String street;
  String city;
  String state;
  String postcode;
  Coordinates coordinates;
  Timezone timezone;

  Location1({
    required this.street,
    required this.city,
    required this.state,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory Location1.fromJson(Map<String, dynamic> json) =>
      _$Location1FromJson(json);

  Map<String, dynamic> toJson() => _$Location1ToJson(this);
}


