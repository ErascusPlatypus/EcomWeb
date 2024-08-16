import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension bCtx<T> on BuildContext {
  void toast(T msg) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(msg.toString())));
  }

  T? get extra => GoRouterState.of(this).extra as T;
}

extension ListExtension on List<String?> {
  List<int> get removeAndReturnIndices {
    List<int> removedIndices = [];
    List<String> filteredList = [];

    for (int i = 0; i < this.length; i++) {
      String? currentString = this[i];

      if (currentString != null && currentString.trim().isNotEmpty) {
        // Check if the string contains only numbers after removing spaces
        bool containsOnlyNumbers = currentString.replaceAll(' ', '').contains(RegExp(r'^[0-9]+$'));

        if (!containsOnlyNumbers) {
          filteredList.add(currentString);
        } else {
          removedIndices.add(i);
        }
      } else {
        removedIndices.add(i);
      }
    }

    // Now, filteredList contains the valid strings
    print("Filtered List: $filteredList");
    print("Removed Indices: $removedIndices");

    return removedIndices;
  }

  List<String?> rem(List<int> indicesToRemove) {
    List<String?> filteredList = List.from(this);

    for (int index in indicesToRemove.reversed) {
      filteredList.removeAt(index);
    }

    return filteredList;
  }
}

extension MapE on Map<String?, String?> {
  void get mremove {
    var data = this;
    data.removeWhere((key, value) {
      // Remove items if key is null, empty, or contains only digits
      if (key == null || key.isEmpty || _containsOnlyDigits(key)) {
        return true;
      }
      return false;
    });

    // Remove subsequent items with duplicated values
    Set<dynamic> seenValues = {};
    data.removeWhere((key, value) {
      if (value != null && seenValues.contains(value)) {
        return true;
      }
      seenValues.add(value);
      return false;
    });

    //print(data); // The filtered map
  }

  bool _containsOnlyDigits(String str) {
    return str.replaceAll(' ', '').contains(RegExp(r'^[0-9]+$'));
  }
}
