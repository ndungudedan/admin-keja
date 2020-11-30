import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'apartment.g.dart';

@JsonSerializable()
class MyApartment {
  String id;
  String owner_id;
  String owner_name;
  String owner_logo;
  String description;
  String category;
  String location;
  String email;
  String title;
  String price;
  String address;
  String deposit;
  String space;
  String phone;
  String latitude;
  String longitude;
  String likes;
  String comments;
  String banner;
  String video;
  String rating;
  String liked;

  MyApartment(
      {this.id,
      this.owner_id,
      this.owner_name,
      this.owner_logo,
      this.category,
      this.email,
      this.address,
      this.title,
      this.phone,
      this.price,
      this.deposit,
      this.description,
      this.space,
      this.latitude,
      this.longitude,
      this.likes,
      this.comments,
      this.video,
      this.rating,
      this.liked,
      this.location,
      this.banner,
});

  factory MyApartment.fromJson(Map<String, dynamic> json) =>
      _$MyApartmentFromJson(json);

  Map<String, dynamic> toJson() => _$MyApartmentToJson(this);

  static final columns = [
    "id",
    "online_id",
    "owner_id",
    "banner",
    "category",
    "title",
    "description",
    "location",
    "emailaddress",
    "address",
    "phone",
    "video",
    "price",
    "deposit",
    "space",
    "latitude",
    "longitude",
    "likes",
    "comments",
    "rating"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "owner_id": owner_id,
      "banner": banner,
      "category": category,
      "title": title,
      "description": description,
      "location": location,
      "emailaddress": email,
      "phone": phone,
      "address": address,
      "video": video,
      "price": price,
      "deposit": deposit,
      "space": space,
      "latitude": latitude,
      "longitude": longitude,
      "likes": likes,
      "comments": comments,
      "rating": rating,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    MyApartment myApartment = MyApartment();
    //myApartment.id = map["id"].toString();
    myApartment.id = map["online_id"];
    myApartment.owner_id = map["owner_id"];
    myApartment.banner = map["banner"];
    myApartment.category = map["category"];
    myApartment.title = map["title"];
    myApartment.description = map["description"];
    myApartment.location = map["location"];
    myApartment.email = map["emailaddress"];
    myApartment.video = map["video"];
    myApartment.price = map["price"];
    myApartment.phone = map["phone"];
    myApartment.address = map["address"];
    myApartment.deposit = map["deposit"];
    myApartment.space = map["space"];
    myApartment.latitude = map["latitude"];
    myApartment.longitude = map["longitude"];
    myApartment.likes = map["likes"];
    myApartment.comments = map["comments"];
    myApartment.rating = map["rating"];

    return myApartment;
  }
}

@JsonSerializable()
class ApartmentList {
  List<MyApartment> apartments;

  ApartmentList({this.apartments});

  factory ApartmentList.fromJson(List<dynamic> json) {
    return ApartmentList(
        apartments: json
            .map((e) => MyApartment.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

@JsonSerializable()
class MyApartmentResponse {
  ApartmentList data;
  Status status;

  MyApartmentResponse({
    this.data,
    this.status,
  });

  factory MyApartmentResponse.fromJson(Map<String, dynamic> json) =>
      _$MyApartmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyApartmentResponseToJson(this);
}

@JsonSerializable()
class Images {
  String id;
  String apartment_id;
  String image;

  Images({
    this.image,
    this.id,
    this.apartment_id,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "image"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "image": image,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Images images = Images();
    //images.id = map["id"].toString();
    images.id = map["online_id"];
    images.apartment_id = map["apartment_id"];
    images.image = map["image"];
    return images;
  }
}
@JsonSerializable()
class ImageList {
  List<Images> data;
  ImageList({this.data});

  factory ImageList.fromJson(List<dynamic> json) {
    return ImageList(
        data: json
            .map((e) => Images.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
@JsonSerializable()
class Tags {
  String id;
  String apartment_id;
  String image_id;
  String tag;

  Tags(
      {this.id,
      this.apartment_id,
      this.tag,
      this.image_id
      });

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  Map<String, dynamic> toJson() => _$TagsToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "image_id",
    "tag0"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "image_id": image_id,
      "tag": tag,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Tags tags = Tags();
    //images.id = map["id"].toString();
    tags.id = map["online_id"];
    tags.apartment_id = map["apartment_id"];
    tags.tag = map["tag"];
    tags.image_id = map["image_id"];

    return tags;
  }
}
@JsonSerializable()
class TagList {
  List<Tags> data;
  TagList({this.data});

  factory TagList.fromJson(List<dynamic> json) {
    return TagList(
        data: json
            .map((e) => Tags.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
@JsonSerializable()
class TagsResponse {
  TagList data;
  Status status;

  TagsResponse({
    this.status,
    this.data,
  });

  factory TagsResponse.fromJson(Map<String, dynamic> json) =>
      _$TagsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TagsResponseToJson(this);
}
@JsonSerializable()
class ImagesResponse {
  ImageList data;
  Status status;

  ImagesResponse({
    this.status,
    this.data,
  });

  factory ImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesResponseToJson(this);
}