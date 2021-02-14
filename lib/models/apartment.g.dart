// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyApartment _$MyApartmentFromJson(Map<String, dynamic> json) {
  return MyApartment(
    id: json['id'] as String,
    vacant: json['vacant'] as bool,
    owner_id: json['owner_id'] as String,
    owner_name: json['owner_name'] as String,
    owner_logo: json['owner_logo'] as String,
    category: json['category'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    title: json['title'] as String,
    phone: json['phone'] as String,
    price: json['price'] as String,
    deposit: json['deposit'] as String,
    description: json['description'] as String,
    space: json['space'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    likes: json['likes'] as String,
    comments: json['comments'] as String,
    video: json['video'] as String,
    rating: json['rating'] as String,
    liked: json['liked'] as String,
    location: json['location'] as String,
    banner: json['banner'] as String,
    bannertag: json['bannertag'] as String,
    enabled: json['enabled'] as bool,
  );
}

Map<String, dynamic> _$MyApartmentToJson(MyApartment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.owner_id,
      'owner_name': instance.owner_name,
      'owner_logo': instance.owner_logo,
      'description': instance.description,
      'category': instance.category,
      'location': instance.location,
      'email': instance.email,
      'title': instance.title,
      'price': instance.price,
      'address': instance.address,
      'deposit': instance.deposit,
      'space': instance.space,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'likes': instance.likes,
      'comments': instance.comments,
      'banner': instance.banner,
      'bannertag': instance.bannertag,
      'video': instance.video,
      'rating': instance.rating,
      'liked': instance.liked,
      'enabled': instance.enabled,
      'vacant': instance.vacant,
    };

ApartmentList _$ApartmentListFromJson(Map<String, dynamic> json) {
  return ApartmentList(
    apartments: (json['apartments'] as List)
        ?.map((e) =>
            e == null ? null : MyApartment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ApartmentListToJson(ApartmentList instance) =>
    <String, dynamic>{
      'apartments': instance.apartments,
    };

MyApartmentResponse _$MyApartmentResponseFromJson(Map<String, dynamic> json) {
  return MyApartmentResponse(
    data: json['data'] == null
        ? null
        : ApartmentList.fromJson(json['data'] as List),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyApartmentResponseToJson(
        MyApartmentResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(
    image: json['image'] as String,
    id: json['id'] as String,
    tag: json['tag'] as String,
    tag_id: json['tag_id'] as String,
    apartment_id: json['apartment_id'] as String,
  );
}

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'apartment_id': instance.apartment_id,
      'tag': instance.tag,
      'tag_id': instance.tag_id,
      'image': instance.image,
    };

ImageList _$ImageListFromJson(Map<String, dynamic> json) {
  return ImageList(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Images.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ImageListToJson(ImageList instance) => <String, dynamic>{
      'data': instance.data,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    id: json['id'] as String,
    apartment_id: json['apartment_id'] as String,
    tag: json['tag'] as String,
    image_id: json['image_id'] as String,
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'id': instance.id,
      'apartment_id': instance.apartment_id,
      'image_id': instance.image_id,
      'tag': instance.tag,
    };

TagList _$TagListFromJson(Map<String, dynamic> json) {
  return TagList(
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Tags.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TagListToJson(TagList instance) => <String, dynamic>{
      'data': instance.data,
    };

TagsResponse _$TagsResponseFromJson(Map<String, dynamic> json) {
  return TagsResponse(
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    data: json['data'] == null ? null : TagList.fromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$TagsResponseToJson(TagsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

ImagesResponse _$ImagesResponseFromJson(Map<String, dynamic> json) {
  return ImagesResponse(
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    data:
        json['data'] == null ? null : ImageList.fromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$ImagesResponseToJson(ImagesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
