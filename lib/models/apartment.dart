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
  String image0;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String image7;
  String image8;
  String image9;
  String image10;
  String image11;
  String image12;
  String image13;
  String image14;
  String image15;

  Images({
    this.image0,
    this.image1,
    this.id,
    this.apartment_id,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
    this.image9,
    this.image10,
    this.image11,
    this.image12,
    this.image13,
    this.image14,
    this.image15,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "image0",
    "image1",
    "image2",
    "image3",
    "image4",
    "image5",
    "image6",
    "image7",
    "image8",
    "image9",
    "image10",
    "image11",
    "image12",
    "image13",
    "image14",
    "image15"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "image0": image0,
      "image1": image1,
      "image2": image2,
      "image3": image3,
      "image4": image4,
      "image5": image5,
      "image6": image6,
      "image7": image7,
      "image8": image8,
      "image9": image9,
      "image10": image10,
      "image11": image11,
      "image12": image12,
      "image13": image13,
      "image14": image14,
      "image15": image15,
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
    images.image0 = map["image0"];
    images.image1 = map["image1"];
    images.image2 = map["image2"];
    images.image3 = map["image3"];
    images.image4 = map["image4"];
    images.image5 = map["image5"];
    images.image6 = map["image6"];
    images.image7 = map["image7"];
    images.image8 = map["image8"];
    images.image9 = map["image9"];
    images.image10 = map["image10"];
    images.image11 = map["image11"];
    images.image12 = map["image12"];
    images.image13 = map["image13"];
    images.image14 = map["image14"];
    images.image15 = map["image15"];

    return images;
  }
}

@JsonSerializable()
class Tags {
  String id;
  String apartment_id;
  String tag0;
  String tag1;
  String tag2;
  String tag3;
  String tag4;
  String tag5;
  String tag6;
  String tag7;
  String tag8;
  String tag9;
  String tag10;
  String tag11;
  String tag12;
  String tag13;
  String tag14;
  String tag15;

  Tags(
      {this.id,
      this.apartment_id,
      this.tag0,
      this.tag1,
      this.tag2,
      this.tag3,
      this.tag4,
      this.tag5,
      this.tag6,
      this.tag7,
      this.tag8,
      this.tag9,
      this.tag10,
      this.tag11,
      this.tag12,
      this.tag13,
      this.tag14,
      this.tag15});

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  Map<String, dynamic> toJson() => _$TagsToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "tag0",
    "tag1",
    "tag2",
    "tag3",
    "tag4",
    "tag5",
    "tag6",
    "tag7",
    "tag8",
    "tag9",
    "tag10",
    "tag11",
    "tag12",
    "tag13",
    "tag14",
    "tag15"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "tag0": tag0,
      "tag1": tag1,
      "tag2": tag2,
      "tag3": tag3,
      "tag4": tag4,
      "tag5": tag5,
      "tag6": tag6,
      "tag7": tag7,
      "tag8": tag8,
      "tag9": tag9,
      "tag10": tag10,
      "tag11": tag11,
      "tag12": tag12,
      "tag13": tag13,
      "tag14": tag14,
      "tag15": tag15,
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
    tags.tag0 = map["tag0"];
    tags.tag1 = map["tag1"];
    tags.tag2 = map["tag2"];
    tags.tag3 = map["tag3"];
    tags.tag4 = map["tag4"];
    tags.tag5 = map["tag5"];
    tags.tag6 = map["tag6"];
    tags.tag7 = map["tag7"];
    tags.tag8 = map["tag8"];
    tags.tag9 = map["tag9"];
    tags.tag10 = map["tag10"];
    tags.tag11 = map["tag11"];
    tags.tag12 = map["tag12"];
    tags.tag13 = map["tag13"];
    tags.tag14 = map["tag14"];
    tags.tag15 = map["tag15"];

    return tags;
  }
}
