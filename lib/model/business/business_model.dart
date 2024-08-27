// To parse this JSON data, do
//
//     final businessModel = businessModelFromJson(jsonString);

import 'dart:convert';

BusinessModel businessModelFromJson(String str) =>
    BusinessModel.fromJson(json.decode(str));

String businessModelToJson(BusinessModel data) => json.encode(data.toJson());

class BusinessModel {
  List<Result> results;
  int currentPage;
  int totalPages;
  int totalResults;

  BusinessModel({
    required this.results,
    required this.currentPage,
    required this.totalPages,
    required this.totalResults,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalResults": totalResults,
      };
}

class Result {
  String id;
  String? name;
  String? email;
  String? contact;
  String? website;
  String? description;
  List<Service>? services;
  dynamic location;
  String? category;
  List<Review>? reviews;
  List<String>? photos;
  int? v;
  String rating;
  String? fieldName;

  Result({
    required this.id,
    this.name,
    this.email,
    this.contact,
    this.website,
    this.description,
    this.services,
    this.location,
    this.category,
    this.reviews,
    this.photos,
    this.v,
    required this.rating,
    this.fieldName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        website: json["website"],
        description: json["description"],
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
        location: json["location"],
        category: json["category"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
        v: json["__v"],
        rating: json["rating"],
        fieldName: json["fieldName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "contact": contact,
        "website": website,
        "description": description,
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "location": location,
        "category": category,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "__v": v,
        "rating": rating,
        "fieldName": fieldName,
      };
}

class Review {
  String name;
  double? rating;
  String? comment;
  String id;
  String? charges;

  Review({
    required this.name,
    this.rating,
    this.comment,
    required this.id,
    this.charges,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        id: json["_id"],
        charges: json["charges"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rating": rating,
        "comment": comment,
        "_id": id,
        "charges": charges,
      };
}

class Service {
  Name name;
  dynamic charges;
  String id;
  String? description;

  Service({
    required this.name,
    required this.charges,
    required this.id,
    this.description,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: nameValues.map[json["name"]]!,
        charges: json["charges"],
        id: json["_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "charges": charges,
        "_id": id,
        "description": description,
      };
}

enum Name {
  DINNER_SERVICE,
  NETWORK_SECURITY,
  PRIVATE_EVENTS,
  SERVICE_1,
  SERVICE_2,
  SOFTWARE_DEVELOPMENT
}

final nameValues = EnumValues({
  "Dinner Service": Name.DINNER_SERVICE,
  "Network Security": Name.NETWORK_SECURITY,
  "Private Events": Name.PRIVATE_EVENTS,
  "Service 1": Name.SERVICE_1,
  "Service 2": Name.SERVICE_2,
  "Software Development": Name.SOFTWARE_DEVELOPMENT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
