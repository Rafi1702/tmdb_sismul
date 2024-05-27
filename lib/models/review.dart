// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  final String? author;
  final AuthorDetails? authorDetails;

  Review({
    this.author,
    this.authorDetails,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        author: json["author"],
        authorDetails: json["author_details"] == null
            ? null
            : AuthorDetails.fromJson(json["author_details"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "author_details": authorDetails?.toJson(),
      };
}

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
      };
}
