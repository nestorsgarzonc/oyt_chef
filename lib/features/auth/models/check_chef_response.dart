import 'dart:convert';
import 'package:equatable/equatable.dart';

class CheckChefResponse extends Equatable {
  factory CheckChefResponse.fromJson(String source) =>
      CheckChefResponse.fromMap(json.decode(source));

  factory CheckChefResponse.fromMap(Map<String, dynamic> map) {
    return CheckChefResponse(
      restaurantId: map['restaurantId'] ?? '',
    );
  }
  const CheckChefResponse({
    required this.restaurantId,
  });

  final String restaurantId;

  CheckChefResponse copyWith({
    String? restaurantId,
  }) {
    return CheckChefResponse(
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CheckChefResponse(restaurantId: $restaurantId)';

  @override
  List<Object> get props => [restaurantId];
}
