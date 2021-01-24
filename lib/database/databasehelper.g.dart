// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databasehelper.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MyApartmentTableData extends DataClass
    implements Insertable<MyApartmentTableData> {
  final String onlineid;
  final String banner;
  final String bannertag;
  final String description;
  final String title;
  final String category;
  final String emailaddress;
  final String location;
  final String address;
  final String phone;
  final String video;
  final String price;
  final String deposit;
  final String space;
  final String latitude;
  final String longitude;
  final String rating;
  final String likes;
  final String comments;
  final bool enabled;
  MyApartmentTableData(
      {@required this.onlineid,
      @required this.banner,
      @required this.bannertag,
      this.description,
      @required this.title,
      @required this.category,
      this.emailaddress,
      this.location,
      this.address,
      this.phone,
      this.video,
      @required this.price,
      @required this.deposit,
      @required this.space,
      @required this.latitude,
      @required this.longitude,
      @required this.rating,
      @required this.likes,
      @required this.comments,
      @required this.enabled});
  factory MyApartmentTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MyApartmentTableData(
      onlineid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      banner:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}banner']),
      bannertag: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}bannertag']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      emailaddress: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}emailaddress']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      address:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}address']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      video:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}video']),
      price:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      deposit:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}deposit']),
      space:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}space']),
      latitude: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      longitude: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      rating:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      likes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}likes']),
      comments: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}comments']),
      enabled:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}enabled']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<String>(onlineid);
    }
    if (!nullToAbsent || banner != null) {
      map['banner'] = Variable<String>(banner);
    }
    if (!nullToAbsent || bannertag != null) {
      map['bannertag'] = Variable<String>(bannertag);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || emailaddress != null) {
      map['emailaddress'] = Variable<String>(emailaddress);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<String>(video);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<String>(price);
    }
    if (!nullToAbsent || deposit != null) {
      map['deposit'] = Variable<String>(deposit);
    }
    if (!nullToAbsent || space != null) {
      map['space'] = Variable<String>(space);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<String>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<String>(longitude);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<String>(rating);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<String>(likes);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<String>(comments);
    }
    if (!nullToAbsent || enabled != null) {
      map['enabled'] = Variable<bool>(enabled);
    }
    return map;
  }

  MyApartmentTableCompanion toCompanion(bool nullToAbsent) {
    return MyApartmentTableCompanion(
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      banner:
          banner == null && nullToAbsent ? const Value.absent() : Value(banner),
      bannertag: bannertag == null && nullToAbsent
          ? const Value.absent()
          : Value(bannertag),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      emailaddress: emailaddress == null && nullToAbsent
          ? const Value.absent()
          : Value(emailaddress),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      video:
          video == null && nullToAbsent ? const Value.absent() : Value(video),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      deposit: deposit == null && nullToAbsent
          ? const Value.absent()
          : Value(deposit),
      space:
          space == null && nullToAbsent ? const Value.absent() : Value(space),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      likes:
          likes == null && nullToAbsent ? const Value.absent() : Value(likes),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      enabled: enabled == null && nullToAbsent
          ? const Value.absent()
          : Value(enabled),
    );
  }

  factory MyApartmentTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyApartmentTableData(
      onlineid: serializer.fromJson<String>(json['onlineid']),
      banner: serializer.fromJson<String>(json['banner']),
      bannertag: serializer.fromJson<String>(json['bannertag']),
      description: serializer.fromJson<String>(json['description']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      emailaddress: serializer.fromJson<String>(json['emailaddress']),
      location: serializer.fromJson<String>(json['location']),
      address: serializer.fromJson<String>(json['address']),
      phone: serializer.fromJson<String>(json['phone']),
      video: serializer.fromJson<String>(json['video']),
      price: serializer.fromJson<String>(json['price']),
      deposit: serializer.fromJson<String>(json['deposit']),
      space: serializer.fromJson<String>(json['space']),
      latitude: serializer.fromJson<String>(json['latitude']),
      longitude: serializer.fromJson<String>(json['longitude']),
      rating: serializer.fromJson<String>(json['rating']),
      likes: serializer.fromJson<String>(json['likes']),
      comments: serializer.fromJson<String>(json['comments']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlineid': serializer.toJson<String>(onlineid),
      'banner': serializer.toJson<String>(banner),
      'bannertag': serializer.toJson<String>(bannertag),
      'description': serializer.toJson<String>(description),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'emailaddress': serializer.toJson<String>(emailaddress),
      'location': serializer.toJson<String>(location),
      'address': serializer.toJson<String>(address),
      'phone': serializer.toJson<String>(phone),
      'video': serializer.toJson<String>(video),
      'price': serializer.toJson<String>(price),
      'deposit': serializer.toJson<String>(deposit),
      'space': serializer.toJson<String>(space),
      'latitude': serializer.toJson<String>(latitude),
      'longitude': serializer.toJson<String>(longitude),
      'rating': serializer.toJson<String>(rating),
      'likes': serializer.toJson<String>(likes),
      'comments': serializer.toJson<String>(comments),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  MyApartmentTableData copyWith(
          {String onlineid,
          String banner,
          String bannertag,
          String description,
          String title,
          String category,
          String emailaddress,
          String location,
          String address,
          String phone,
          String video,
          String price,
          String deposit,
          String space,
          String latitude,
          String longitude,
          String rating,
          String likes,
          String comments,
          bool enabled}) =>
      MyApartmentTableData(
        onlineid: onlineid ?? this.onlineid,
        banner: banner ?? this.banner,
        bannertag: bannertag ?? this.bannertag,
        description: description ?? this.description,
        title: title ?? this.title,
        category: category ?? this.category,
        emailaddress: emailaddress ?? this.emailaddress,
        location: location ?? this.location,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        video: video ?? this.video,
        price: price ?? this.price,
        deposit: deposit ?? this.deposit,
        space: space ?? this.space,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        rating: rating ?? this.rating,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        enabled: enabled ?? this.enabled,
      );
  @override
  String toString() {
    return (StringBuffer('MyApartmentTableData(')
          ..write('onlineid: $onlineid, ')
          ..write('banner: $banner, ')
          ..write('bannertag: $bannertag, ')
          ..write('description: $description, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('emailaddress: $emailaddress, ')
          ..write('location: $location, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('video: $video, ')
          ..write('price: $price, ')
          ..write('deposit: $deposit, ')
          ..write('space: $space, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('rating: $rating, ')
          ..write('likes: $likes, ')
          ..write('comments: $comments, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      onlineid.hashCode,
      $mrjc(
          banner.hashCode,
          $mrjc(
              bannertag.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      title.hashCode,
                      $mrjc(
                          category.hashCode,
                          $mrjc(
                              emailaddress.hashCode,
                              $mrjc(
                                  location.hashCode,
                                  $mrjc(
                                      address.hashCode,
                                      $mrjc(
                                          phone.hashCode,
                                          $mrjc(
                                              video.hashCode,
                                              $mrjc(
                                                  price.hashCode,
                                                  $mrjc(
                                                      deposit.hashCode,
                                                      $mrjc(
                                                          space.hashCode,
                                                          $mrjc(
                                                              latitude.hashCode,
                                                              $mrjc(
                                                                  longitude
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      rating
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          likes
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              comments.hashCode,
                                                                              enabled.hashCode))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyApartmentTableData &&
          other.onlineid == this.onlineid &&
          other.banner == this.banner &&
          other.bannertag == this.bannertag &&
          other.description == this.description &&
          other.title == this.title &&
          other.category == this.category &&
          other.emailaddress == this.emailaddress &&
          other.location == this.location &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.video == this.video &&
          other.price == this.price &&
          other.deposit == this.deposit &&
          other.space == this.space &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.rating == this.rating &&
          other.likes == this.likes &&
          other.comments == this.comments &&
          other.enabled == this.enabled);
}

class MyApartmentTableCompanion extends UpdateCompanion<MyApartmentTableData> {
  final Value<String> onlineid;
  final Value<String> banner;
  final Value<String> bannertag;
  final Value<String> description;
  final Value<String> title;
  final Value<String> category;
  final Value<String> emailaddress;
  final Value<String> location;
  final Value<String> address;
  final Value<String> phone;
  final Value<String> video;
  final Value<String> price;
  final Value<String> deposit;
  final Value<String> space;
  final Value<String> latitude;
  final Value<String> longitude;
  final Value<String> rating;
  final Value<String> likes;
  final Value<String> comments;
  final Value<bool> enabled;
  const MyApartmentTableCompanion({
    this.onlineid = const Value.absent(),
    this.banner = const Value.absent(),
    this.bannertag = const Value.absent(),
    this.description = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.emailaddress = const Value.absent(),
    this.location = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.video = const Value.absent(),
    this.price = const Value.absent(),
    this.deposit = const Value.absent(),
    this.space = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.rating = const Value.absent(),
    this.likes = const Value.absent(),
    this.comments = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  MyApartmentTableCompanion.insert({
    @required String onlineid,
    @required String banner,
    @required String bannertag,
    this.description = const Value.absent(),
    @required String title,
    @required String category,
    this.emailaddress = const Value.absent(),
    this.location = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.video = const Value.absent(),
    @required String price,
    @required String deposit,
    @required String space,
    @required String latitude,
    @required String longitude,
    @required String rating,
    @required String likes,
    @required String comments,
    @required bool enabled,
  })  : onlineid = Value(onlineid),
        banner = Value(banner),
        bannertag = Value(bannertag),
        title = Value(title),
        category = Value(category),
        price = Value(price),
        deposit = Value(deposit),
        space = Value(space),
        latitude = Value(latitude),
        longitude = Value(longitude),
        rating = Value(rating),
        likes = Value(likes),
        comments = Value(comments),
        enabled = Value(enabled);
  static Insertable<MyApartmentTableData> custom({
    Expression<String> onlineid,
    Expression<String> banner,
    Expression<String> bannertag,
    Expression<String> description,
    Expression<String> title,
    Expression<String> category,
    Expression<String> emailaddress,
    Expression<String> location,
    Expression<String> address,
    Expression<String> phone,
    Expression<String> video,
    Expression<String> price,
    Expression<String> deposit,
    Expression<String> space,
    Expression<String> latitude,
    Expression<String> longitude,
    Expression<String> rating,
    Expression<String> likes,
    Expression<String> comments,
    Expression<bool> enabled,
  }) {
    return RawValuesInsertable({
      if (onlineid != null) 'onlineid': onlineid,
      if (banner != null) 'banner': banner,
      if (bannertag != null) 'bannertag': bannertag,
      if (description != null) 'description': description,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (emailaddress != null) 'emailaddress': emailaddress,
      if (location != null) 'location': location,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (video != null) 'video': video,
      if (price != null) 'price': price,
      if (deposit != null) 'deposit': deposit,
      if (space != null) 'space': space,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (rating != null) 'rating': rating,
      if (likes != null) 'likes': likes,
      if (comments != null) 'comments': comments,
      if (enabled != null) 'enabled': enabled,
    });
  }

  MyApartmentTableCompanion copyWith(
      {Value<String> onlineid,
      Value<String> banner,
      Value<String> bannertag,
      Value<String> description,
      Value<String> title,
      Value<String> category,
      Value<String> emailaddress,
      Value<String> location,
      Value<String> address,
      Value<String> phone,
      Value<String> video,
      Value<String> price,
      Value<String> deposit,
      Value<String> space,
      Value<String> latitude,
      Value<String> longitude,
      Value<String> rating,
      Value<String> likes,
      Value<String> comments,
      Value<bool> enabled}) {
    return MyApartmentTableCompanion(
      onlineid: onlineid ?? this.onlineid,
      banner: banner ?? this.banner,
      bannertag: bannertag ?? this.bannertag,
      description: description ?? this.description,
      title: title ?? this.title,
      category: category ?? this.category,
      emailaddress: emailaddress ?? this.emailaddress,
      location: location ?? this.location,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      video: video ?? this.video,
      price: price ?? this.price,
      deposit: deposit ?? this.deposit,
      space: space ?? this.space,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlineid.present) {
      map['onlineid'] = Variable<String>(onlineid.value);
    }
    if (banner.present) {
      map['banner'] = Variable<String>(banner.value);
    }
    if (bannertag.present) {
      map['bannertag'] = Variable<String>(bannertag.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (emailaddress.present) {
      map['emailaddress'] = Variable<String>(emailaddress.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (video.present) {
      map['video'] = Variable<String>(video.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (deposit.present) {
      map['deposit'] = Variable<String>(deposit.value);
    }
    if (space.present) {
      map['space'] = Variable<String>(space.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String>(longitude.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(rating.value);
    }
    if (likes.present) {
      map['likes'] = Variable<String>(likes.value);
    }
    if (comments.present) {
      map['comments'] = Variable<String>(comments.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyApartmentTableCompanion(')
          ..write('onlineid: $onlineid, ')
          ..write('banner: $banner, ')
          ..write('bannertag: $bannertag, ')
          ..write('description: $description, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('emailaddress: $emailaddress, ')
          ..write('location: $location, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('video: $video, ')
          ..write('price: $price, ')
          ..write('deposit: $deposit, ')
          ..write('space: $space, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('rating: $rating, ')
          ..write('likes: $likes, ')
          ..write('comments: $comments, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

class $MyApartmentTableTable extends MyApartmentTable
    with TableInfo<$MyApartmentTableTable, MyApartmentTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyApartmentTableTable(this._db, [this._alias]);
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  GeneratedTextColumn _onlineid;
  @override
  GeneratedTextColumn get onlineid => _onlineid ??= _constructOnlineid();
  GeneratedTextColumn _constructOnlineid() {
    return GeneratedTextColumn(
      'onlineid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bannerMeta = const VerificationMeta('banner');
  GeneratedTextColumn _banner;
  @override
  GeneratedTextColumn get banner => _banner ??= _constructBanner();
  GeneratedTextColumn _constructBanner() {
    return GeneratedTextColumn(
      'banner',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bannertagMeta = const VerificationMeta('bannertag');
  GeneratedTextColumn _bannertag;
  @override
  GeneratedTextColumn get bannertag => _bannertag ??= _constructBannertag();
  GeneratedTextColumn _constructBannertag() {
    return GeneratedTextColumn(
      'bannertag',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailaddressMeta =
      const VerificationMeta('emailaddress');
  GeneratedTextColumn _emailaddress;
  @override
  GeneratedTextColumn get emailaddress =>
      _emailaddress ??= _constructEmailaddress();
  GeneratedTextColumn _constructEmailaddress() {
    return GeneratedTextColumn(
      'emailaddress',
      $tableName,
      true,
    );
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn(
      'location',
      $tableName,
      true,
    );
  }

  final VerificationMeta _addressMeta = const VerificationMeta('address');
  GeneratedTextColumn _address;
  @override
  GeneratedTextColumn get address => _address ??= _constructAddress();
  GeneratedTextColumn _constructAddress() {
    return GeneratedTextColumn(
      'address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  GeneratedTextColumn _phone;
  @override
  GeneratedTextColumn get phone => _phone ??= _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
      $tableName,
      true,
    );
  }

  final VerificationMeta _videoMeta = const VerificationMeta('video');
  GeneratedTextColumn _video;
  @override
  GeneratedTextColumn get video => _video ??= _constructVideo();
  GeneratedTextColumn _constructVideo() {
    return GeneratedTextColumn(
      'video',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedTextColumn _price;
  @override
  GeneratedTextColumn get price => _price ??= _constructPrice();
  GeneratedTextColumn _constructPrice() {
    return GeneratedTextColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _depositMeta = const VerificationMeta('deposit');
  GeneratedTextColumn _deposit;
  @override
  GeneratedTextColumn get deposit => _deposit ??= _constructDeposit();
  GeneratedTextColumn _constructDeposit() {
    return GeneratedTextColumn(
      'deposit',
      $tableName,
      false,
    );
  }

  final VerificationMeta _spaceMeta = const VerificationMeta('space');
  GeneratedTextColumn _space;
  @override
  GeneratedTextColumn get space => _space ??= _constructSpace();
  GeneratedTextColumn _constructSpace() {
    return GeneratedTextColumn(
      'space',
      $tableName,
      false,
    );
  }

  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  GeneratedTextColumn _latitude;
  @override
  GeneratedTextColumn get latitude => _latitude ??= _constructLatitude();
  GeneratedTextColumn _constructLatitude() {
    return GeneratedTextColumn(
      'latitude',
      $tableName,
      false,
    );
  }

  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  GeneratedTextColumn _longitude;
  @override
  GeneratedTextColumn get longitude => _longitude ??= _constructLongitude();
  GeneratedTextColumn _constructLongitude() {
    return GeneratedTextColumn(
      'longitude',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedTextColumn _rating;
  @override
  GeneratedTextColumn get rating => _rating ??= _constructRating();
  GeneratedTextColumn _constructRating() {
    return GeneratedTextColumn(
      'rating',
      $tableName,
      false,
    );
  }

  final VerificationMeta _likesMeta = const VerificationMeta('likes');
  GeneratedTextColumn _likes;
  @override
  GeneratedTextColumn get likes => _likes ??= _constructLikes();
  GeneratedTextColumn _constructLikes() {
    return GeneratedTextColumn(
      'likes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _commentsMeta = const VerificationMeta('comments');
  GeneratedTextColumn _comments;
  @override
  GeneratedTextColumn get comments => _comments ??= _constructComments();
  GeneratedTextColumn _constructComments() {
    return GeneratedTextColumn(
      'comments',
      $tableName,
      false,
    );
  }

  final VerificationMeta _enabledMeta = const VerificationMeta('enabled');
  GeneratedBoolColumn _enabled;
  @override
  GeneratedBoolColumn get enabled => _enabled ??= _constructEnabled();
  GeneratedBoolColumn _constructEnabled() {
    return GeneratedBoolColumn(
      'enabled',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        onlineid,
        banner,
        bannertag,
        description,
        title,
        category,
        emailaddress,
        location,
        address,
        phone,
        video,
        price,
        deposit,
        space,
        latitude,
        longitude,
        rating,
        likes,
        comments,
        enabled
      ];
  @override
  $MyApartmentTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_apartment_table';
  @override
  final String actualTableName = 'my_apartment_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MyApartmentTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid'], _onlineidMeta));
    } else if (isInserting) {
      context.missing(_onlineidMeta);
    }
    if (data.containsKey('banner')) {
      context.handle(_bannerMeta,
          banner.isAcceptableOrUnknown(data['banner'], _bannerMeta));
    } else if (isInserting) {
      context.missing(_bannerMeta);
    }
    if (data.containsKey('bannertag')) {
      context.handle(_bannertagMeta,
          bannertag.isAcceptableOrUnknown(data['bannertag'], _bannertagMeta));
    } else if (isInserting) {
      context.missing(_bannertagMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('emailaddress')) {
      context.handle(
          _emailaddressMeta,
          emailaddress.isAcceptableOrUnknown(
              data['emailaddress'], _emailaddressMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location'], _locationMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address'], _addressMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone'], _phoneMeta));
    }
    if (data.containsKey('video')) {
      context.handle(
          _videoMeta, video.isAcceptableOrUnknown(data['video'], _videoMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('deposit')) {
      context.handle(_depositMeta,
          deposit.isAcceptableOrUnknown(data['deposit'], _depositMeta));
    } else if (isInserting) {
      context.missing(_depositMeta);
    }
    if (data.containsKey('space')) {
      context.handle(
          _spaceMeta, space.isAcceptableOrUnknown(data['space'], _spaceMeta));
    } else if (isInserting) {
      context.missing(_spaceMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude'], _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude'], _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('likes')) {
      context.handle(
          _likesMeta, likes.isAcceptableOrUnknown(data['likes'], _likesMeta));
    } else if (isInserting) {
      context.missing(_likesMeta);
    }
    if (data.containsKey('comments')) {
      context.handle(_commentsMeta,
          comments.isAcceptableOrUnknown(data['comments'], _commentsMeta));
    } else if (isInserting) {
      context.missing(_commentsMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled'], _enabledMeta));
    } else if (isInserting) {
      context.missing(_enabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onlineid};
  @override
  MyApartmentTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyApartmentTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyApartmentTableTable createAlias(String alias) {
    return $MyApartmentTableTable(_db, alias);
  }
}

class MyImagesTableData extends DataClass
    implements Insertable<MyImagesTableData> {
  final String onlineid;
  final String apartment_id;
  final String tag_id;
  final String tag;
  final String image;
  MyImagesTableData(
      {@required this.onlineid,
      @required this.apartment_id,
      @required this.tag_id,
      @required this.tag,
      @required this.image});
  factory MyImagesTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MyImagesTableData(
      onlineid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      apartment_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apartment_id']),
      tag_id:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
      tag: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<String>(onlineid);
    }
    if (!nullToAbsent || apartment_id != null) {
      map['apartment_id'] = Variable<String>(apartment_id);
    }
    if (!nullToAbsent || tag_id != null) {
      map['tag_id'] = Variable<String>(tag_id);
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  MyImagesTableCompanion toCompanion(bool nullToAbsent) {
    return MyImagesTableCompanion(
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      apartment_id: apartment_id == null && nullToAbsent
          ? const Value.absent()
          : Value(apartment_id),
      tag_id:
          tag_id == null && nullToAbsent ? const Value.absent() : Value(tag_id),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory MyImagesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyImagesTableData(
      onlineid: serializer.fromJson<String>(json['onlineid']),
      apartment_id: serializer.fromJson<String>(json['apartment_id']),
      tag_id: serializer.fromJson<String>(json['tag_id']),
      tag: serializer.fromJson<String>(json['tag']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlineid': serializer.toJson<String>(onlineid),
      'apartment_id': serializer.toJson<String>(apartment_id),
      'tag_id': serializer.toJson<String>(tag_id),
      'tag': serializer.toJson<String>(tag),
      'image': serializer.toJson<String>(image),
    };
  }

  MyImagesTableData copyWith(
          {String onlineid,
          String apartment_id,
          String tag_id,
          String tag,
          String image}) =>
      MyImagesTableData(
        onlineid: onlineid ?? this.onlineid,
        apartment_id: apartment_id ?? this.apartment_id,
        tag_id: tag_id ?? this.tag_id,
        tag: tag ?? this.tag,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('MyImagesTableData(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('tag_id: $tag_id, ')
          ..write('tag: $tag, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      onlineid.hashCode,
      $mrjc(apartment_id.hashCode,
          $mrjc(tag_id.hashCode, $mrjc(tag.hashCode, image.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyImagesTableData &&
          other.onlineid == this.onlineid &&
          other.apartment_id == this.apartment_id &&
          other.tag_id == this.tag_id &&
          other.tag == this.tag &&
          other.image == this.image);
}

class MyImagesTableCompanion extends UpdateCompanion<MyImagesTableData> {
  final Value<String> onlineid;
  final Value<String> apartment_id;
  final Value<String> tag_id;
  final Value<String> tag;
  final Value<String> image;
  const MyImagesTableCompanion({
    this.onlineid = const Value.absent(),
    this.apartment_id = const Value.absent(),
    this.tag_id = const Value.absent(),
    this.tag = const Value.absent(),
    this.image = const Value.absent(),
  });
  MyImagesTableCompanion.insert({
    @required String onlineid,
    @required String apartment_id,
    @required String tag_id,
    @required String tag,
    @required String image,
  })  : onlineid = Value(onlineid),
        apartment_id = Value(apartment_id),
        tag_id = Value(tag_id),
        tag = Value(tag),
        image = Value(image);
  static Insertable<MyImagesTableData> custom({
    Expression<String> onlineid,
    Expression<String> apartment_id,
    Expression<String> tag_id,
    Expression<String> tag,
    Expression<String> image,
  }) {
    return RawValuesInsertable({
      if (onlineid != null) 'onlineid': onlineid,
      if (apartment_id != null) 'apartment_id': apartment_id,
      if (tag_id != null) 'tag_id': tag_id,
      if (tag != null) 'tag': tag,
      if (image != null) 'image': image,
    });
  }

  MyImagesTableCompanion copyWith(
      {Value<String> onlineid,
      Value<String> apartment_id,
      Value<String> tag_id,
      Value<String> tag,
      Value<String> image}) {
    return MyImagesTableCompanion(
      onlineid: onlineid ?? this.onlineid,
      apartment_id: apartment_id ?? this.apartment_id,
      tag_id: tag_id ?? this.tag_id,
      tag: tag ?? this.tag,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlineid.present) {
      map['onlineid'] = Variable<String>(onlineid.value);
    }
    if (apartment_id.present) {
      map['apartment_id'] = Variable<String>(apartment_id.value);
    }
    if (tag_id.present) {
      map['tag_id'] = Variable<String>(tag_id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyImagesTableCompanion(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('tag_id: $tag_id, ')
          ..write('tag: $tag, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $MyImagesTableTable extends MyImagesTable
    with TableInfo<$MyImagesTableTable, MyImagesTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyImagesTableTable(this._db, [this._alias]);
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  GeneratedTextColumn _onlineid;
  @override
  GeneratedTextColumn get onlineid => _onlineid ??= _constructOnlineid();
  GeneratedTextColumn _constructOnlineid() {
    return GeneratedTextColumn(
      'onlineid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apartment_idMeta =
      const VerificationMeta('apartment_id');
  GeneratedTextColumn _apartment_id;
  @override
  GeneratedTextColumn get apartment_id =>
      _apartment_id ??= _constructApartmentId();
  GeneratedTextColumn _constructApartmentId() {
    return GeneratedTextColumn(
      'apartment_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tag_idMeta = const VerificationMeta('tag_id');
  GeneratedTextColumn _tag_id;
  @override
  GeneratedTextColumn get tag_id => _tag_id ??= _constructTagId();
  GeneratedTextColumn _constructTagId() {
    return GeneratedTextColumn(
      'tag_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedTextColumn _tag;
  @override
  GeneratedTextColumn get tag => _tag ??= _constructTag();
  GeneratedTextColumn _constructTag() {
    return GeneratedTextColumn(
      'tag',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [onlineid, apartment_id, tag_id, tag, image];
  @override
  $MyImagesTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_images_table';
  @override
  final String actualTableName = 'my_images_table';
  @override
  VerificationContext validateIntegrity(Insertable<MyImagesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid'], _onlineidMeta));
    } else if (isInserting) {
      context.missing(_onlineidMeta);
    }
    if (data.containsKey('apartment_id')) {
      context.handle(
          _apartment_idMeta,
          apartment_id.isAcceptableOrUnknown(
              data['apartment_id'], _apartment_idMeta));
    } else if (isInserting) {
      context.missing(_apartment_idMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(_tag_idMeta,
          tag_id.isAcceptableOrUnknown(data['tag_id'], _tag_idMeta));
    } else if (isInserting) {
      context.missing(_tag_idMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag'], _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onlineid};
  @override
  MyImagesTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyImagesTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyImagesTableTable createAlias(String alias) {
    return $MyImagesTableTable(_db, alias);
  }
}

class MyFeaturesTableData extends DataClass
    implements Insertable<MyFeaturesTableData> {
  final String onlineid;
  final String apartment_id;
  final String feat;
  MyFeaturesTableData(
      {@required this.onlineid,
      @required this.apartment_id,
      @required this.feat});
  factory MyFeaturesTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MyFeaturesTableData(
      onlineid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      apartment_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apartment_id']),
      feat: stringType.mapFromDatabaseResponse(data['${effectivePrefix}feat']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<String>(onlineid);
    }
    if (!nullToAbsent || apartment_id != null) {
      map['apartment_id'] = Variable<String>(apartment_id);
    }
    if (!nullToAbsent || feat != null) {
      map['feat'] = Variable<String>(feat);
    }
    return map;
  }

  MyFeaturesTableCompanion toCompanion(bool nullToAbsent) {
    return MyFeaturesTableCompanion(
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      apartment_id: apartment_id == null && nullToAbsent
          ? const Value.absent()
          : Value(apartment_id),
      feat: feat == null && nullToAbsent ? const Value.absent() : Value(feat),
    );
  }

  factory MyFeaturesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyFeaturesTableData(
      onlineid: serializer.fromJson<String>(json['onlineid']),
      apartment_id: serializer.fromJson<String>(json['apartment_id']),
      feat: serializer.fromJson<String>(json['feat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlineid': serializer.toJson<String>(onlineid),
      'apartment_id': serializer.toJson<String>(apartment_id),
      'feat': serializer.toJson<String>(feat),
    };
  }

  MyFeaturesTableData copyWith(
          {String onlineid, String apartment_id, String feat}) =>
      MyFeaturesTableData(
        onlineid: onlineid ?? this.onlineid,
        apartment_id: apartment_id ?? this.apartment_id,
        feat: feat ?? this.feat,
      );
  @override
  String toString() {
    return (StringBuffer('MyFeaturesTableData(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('feat: $feat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(onlineid.hashCode, $mrjc(apartment_id.hashCode, feat.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyFeaturesTableData &&
          other.onlineid == this.onlineid &&
          other.apartment_id == this.apartment_id &&
          other.feat == this.feat);
}

class MyFeaturesTableCompanion extends UpdateCompanion<MyFeaturesTableData> {
  final Value<String> onlineid;
  final Value<String> apartment_id;
  final Value<String> feat;
  const MyFeaturesTableCompanion({
    this.onlineid = const Value.absent(),
    this.apartment_id = const Value.absent(),
    this.feat = const Value.absent(),
  });
  MyFeaturesTableCompanion.insert({
    @required String onlineid,
    @required String apartment_id,
    @required String feat,
  })  : onlineid = Value(onlineid),
        apartment_id = Value(apartment_id),
        feat = Value(feat);
  static Insertable<MyFeaturesTableData> custom({
    Expression<String> onlineid,
    Expression<String> apartment_id,
    Expression<String> feat,
  }) {
    return RawValuesInsertable({
      if (onlineid != null) 'onlineid': onlineid,
      if (apartment_id != null) 'apartment_id': apartment_id,
      if (feat != null) 'feat': feat,
    });
  }

  MyFeaturesTableCompanion copyWith(
      {Value<String> onlineid,
      Value<String> apartment_id,
      Value<String> feat}) {
    return MyFeaturesTableCompanion(
      onlineid: onlineid ?? this.onlineid,
      apartment_id: apartment_id ?? this.apartment_id,
      feat: feat ?? this.feat,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlineid.present) {
      map['onlineid'] = Variable<String>(onlineid.value);
    }
    if (apartment_id.present) {
      map['apartment_id'] = Variable<String>(apartment_id.value);
    }
    if (feat.present) {
      map['feat'] = Variable<String>(feat.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyFeaturesTableCompanion(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('feat: $feat')
          ..write(')'))
        .toString();
  }
}

class $MyFeaturesTableTable extends MyFeaturesTable
    with TableInfo<$MyFeaturesTableTable, MyFeaturesTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyFeaturesTableTable(this._db, [this._alias]);
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  GeneratedTextColumn _onlineid;
  @override
  GeneratedTextColumn get onlineid => _onlineid ??= _constructOnlineid();
  GeneratedTextColumn _constructOnlineid() {
    return GeneratedTextColumn(
      'onlineid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apartment_idMeta =
      const VerificationMeta('apartment_id');
  GeneratedTextColumn _apartment_id;
  @override
  GeneratedTextColumn get apartment_id =>
      _apartment_id ??= _constructApartmentId();
  GeneratedTextColumn _constructApartmentId() {
    return GeneratedTextColumn(
      'apartment_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _featMeta = const VerificationMeta('feat');
  GeneratedTextColumn _feat;
  @override
  GeneratedTextColumn get feat => _feat ??= _constructFeat();
  GeneratedTextColumn _constructFeat() {
    return GeneratedTextColumn(
      'feat',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [onlineid, apartment_id, feat];
  @override
  $MyFeaturesTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_features_table';
  @override
  final String actualTableName = 'my_features_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MyFeaturesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid'], _onlineidMeta));
    } else if (isInserting) {
      context.missing(_onlineidMeta);
    }
    if (data.containsKey('apartment_id')) {
      context.handle(
          _apartment_idMeta,
          apartment_id.isAcceptableOrUnknown(
              data['apartment_id'], _apartment_idMeta));
    } else if (isInserting) {
      context.missing(_apartment_idMeta);
    }
    if (data.containsKey('feat')) {
      context.handle(
          _featMeta, feat.isAcceptableOrUnknown(data['feat'], _featMeta));
    } else if (isInserting) {
      context.missing(_featMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onlineid};
  @override
  MyFeaturesTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyFeaturesTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyFeaturesTableTable createAlias(String alias) {
    return $MyFeaturesTableTable(_db, alias);
  }
}

class MyPaymentHistoryTableData extends DataClass
    implements Insertable<MyPaymentHistoryTableData> {
  final String onlineid;
  final String apartment_id;
  final String title;
  final String company_id;
  final String month;
  final String year;
  final String expected;
  final String paid;
  final String due;
  final String timestamp;
  MyPaymentHistoryTableData(
      {@required this.onlineid,
      @required this.apartment_id,
      @required this.title,
      @required this.company_id,
      @required this.month,
      @required this.year,
      @required this.expected,
      @required this.paid,
      @required this.due,
      @required this.timestamp});
  factory MyPaymentHistoryTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MyPaymentHistoryTableData(
      onlineid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      apartment_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apartment_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      company_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_id']),
      month:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}month']),
      year: stringType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      expected: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expected']),
      paid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}paid']),
      due: stringType.mapFromDatabaseResponse(data['${effectivePrefix}due']),
      timestamp: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<String>(onlineid);
    }
    if (!nullToAbsent || apartment_id != null) {
      map['apartment_id'] = Variable<String>(apartment_id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || company_id != null) {
      map['company_id'] = Variable<String>(company_id);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<String>(month);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<String>(year);
    }
    if (!nullToAbsent || expected != null) {
      map['expected'] = Variable<String>(expected);
    }
    if (!nullToAbsent || paid != null) {
      map['paid'] = Variable<String>(paid);
    }
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<String>(due);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<String>(timestamp);
    }
    return map;
  }

  MyPaymentHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return MyPaymentHistoryTableCompanion(
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      apartment_id: apartment_id == null && nullToAbsent
          ? const Value.absent()
          : Value(apartment_id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      company_id: company_id == null && nullToAbsent
          ? const Value.absent()
          : Value(company_id),
      month:
          month == null && nullToAbsent ? const Value.absent() : Value(month),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      expected: expected == null && nullToAbsent
          ? const Value.absent()
          : Value(expected),
      paid: paid == null && nullToAbsent ? const Value.absent() : Value(paid),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
    );
  }

  factory MyPaymentHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyPaymentHistoryTableData(
      onlineid: serializer.fromJson<String>(json['onlineid']),
      apartment_id: serializer.fromJson<String>(json['apartment_id']),
      title: serializer.fromJson<String>(json['title']),
      company_id: serializer.fromJson<String>(json['company_id']),
      month: serializer.fromJson<String>(json['month']),
      year: serializer.fromJson<String>(json['year']),
      expected: serializer.fromJson<String>(json['expected']),
      paid: serializer.fromJson<String>(json['paid']),
      due: serializer.fromJson<String>(json['due']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlineid': serializer.toJson<String>(onlineid),
      'apartment_id': serializer.toJson<String>(apartment_id),
      'title': serializer.toJson<String>(title),
      'company_id': serializer.toJson<String>(company_id),
      'month': serializer.toJson<String>(month),
      'year': serializer.toJson<String>(year),
      'expected': serializer.toJson<String>(expected),
      'paid': serializer.toJson<String>(paid),
      'due': serializer.toJson<String>(due),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  MyPaymentHistoryTableData copyWith(
          {String onlineid,
          String apartment_id,
          String title,
          String company_id,
          String month,
          String year,
          String expected,
          String paid,
          String due,
          String timestamp}) =>
      MyPaymentHistoryTableData(
        onlineid: onlineid ?? this.onlineid,
        apartment_id: apartment_id ?? this.apartment_id,
        title: title ?? this.title,
        company_id: company_id ?? this.company_id,
        month: month ?? this.month,
        year: year ?? this.year,
        expected: expected ?? this.expected,
        paid: paid ?? this.paid,
        due: due ?? this.due,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('MyPaymentHistoryTableData(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('title: $title, ')
          ..write('company_id: $company_id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('expected: $expected, ')
          ..write('paid: $paid, ')
          ..write('due: $due, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      onlineid.hashCode,
      $mrjc(
          apartment_id.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(
                  company_id.hashCode,
                  $mrjc(
                      month.hashCode,
                      $mrjc(
                          year.hashCode,
                          $mrjc(
                              expected.hashCode,
                              $mrjc(
                                  paid.hashCode,
                                  $mrjc(due.hashCode,
                                      timestamp.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyPaymentHistoryTableData &&
          other.onlineid == this.onlineid &&
          other.apartment_id == this.apartment_id &&
          other.title == this.title &&
          other.company_id == this.company_id &&
          other.month == this.month &&
          other.year == this.year &&
          other.expected == this.expected &&
          other.paid == this.paid &&
          other.due == this.due &&
          other.timestamp == this.timestamp);
}

class MyPaymentHistoryTableCompanion
    extends UpdateCompanion<MyPaymentHistoryTableData> {
  final Value<String> onlineid;
  final Value<String> apartment_id;
  final Value<String> title;
  final Value<String> company_id;
  final Value<String> month;
  final Value<String> year;
  final Value<String> expected;
  final Value<String> paid;
  final Value<String> due;
  final Value<String> timestamp;
  const MyPaymentHistoryTableCompanion({
    this.onlineid = const Value.absent(),
    this.apartment_id = const Value.absent(),
    this.title = const Value.absent(),
    this.company_id = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.expected = const Value.absent(),
    this.paid = const Value.absent(),
    this.due = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  MyPaymentHistoryTableCompanion.insert({
    @required String onlineid,
    @required String apartment_id,
    @required String title,
    @required String company_id,
    @required String month,
    @required String year,
    @required String expected,
    @required String paid,
    @required String due,
    @required String timestamp,
  })  : onlineid = Value(onlineid),
        apartment_id = Value(apartment_id),
        title = Value(title),
        company_id = Value(company_id),
        month = Value(month),
        year = Value(year),
        expected = Value(expected),
        paid = Value(paid),
        due = Value(due),
        timestamp = Value(timestamp);
  static Insertable<MyPaymentHistoryTableData> custom({
    Expression<String> onlineid,
    Expression<String> apartment_id,
    Expression<String> title,
    Expression<String> company_id,
    Expression<String> month,
    Expression<String> year,
    Expression<String> expected,
    Expression<String> paid,
    Expression<String> due,
    Expression<String> timestamp,
  }) {
    return RawValuesInsertable({
      if (onlineid != null) 'onlineid': onlineid,
      if (apartment_id != null) 'apartment_id': apartment_id,
      if (title != null) 'title': title,
      if (company_id != null) 'company_id': company_id,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (expected != null) 'expected': expected,
      if (paid != null) 'paid': paid,
      if (due != null) 'due': due,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  MyPaymentHistoryTableCompanion copyWith(
      {Value<String> onlineid,
      Value<String> apartment_id,
      Value<String> title,
      Value<String> company_id,
      Value<String> month,
      Value<String> year,
      Value<String> expected,
      Value<String> paid,
      Value<String> due,
      Value<String> timestamp}) {
    return MyPaymentHistoryTableCompanion(
      onlineid: onlineid ?? this.onlineid,
      apartment_id: apartment_id ?? this.apartment_id,
      title: title ?? this.title,
      company_id: company_id ?? this.company_id,
      month: month ?? this.month,
      year: year ?? this.year,
      expected: expected ?? this.expected,
      paid: paid ?? this.paid,
      due: due ?? this.due,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlineid.present) {
      map['onlineid'] = Variable<String>(onlineid.value);
    }
    if (apartment_id.present) {
      map['apartment_id'] = Variable<String>(apartment_id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (company_id.present) {
      map['company_id'] = Variable<String>(company_id.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (expected.present) {
      map['expected'] = Variable<String>(expected.value);
    }
    if (paid.present) {
      map['paid'] = Variable<String>(paid.value);
    }
    if (due.present) {
      map['due'] = Variable<String>(due.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyPaymentHistoryTableCompanion(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('title: $title, ')
          ..write('company_id: $company_id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('expected: $expected, ')
          ..write('paid: $paid, ')
          ..write('due: $due, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $MyPaymentHistoryTableTable extends MyPaymentHistoryTable
    with TableInfo<$MyPaymentHistoryTableTable, MyPaymentHistoryTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyPaymentHistoryTableTable(this._db, [this._alias]);
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  GeneratedTextColumn _onlineid;
  @override
  GeneratedTextColumn get onlineid => _onlineid ??= _constructOnlineid();
  GeneratedTextColumn _constructOnlineid() {
    return GeneratedTextColumn(
      'onlineid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apartment_idMeta =
      const VerificationMeta('apartment_id');
  GeneratedTextColumn _apartment_id;
  @override
  GeneratedTextColumn get apartment_id =>
      _apartment_id ??= _constructApartmentId();
  GeneratedTextColumn _constructApartmentId() {
    return GeneratedTextColumn(
      'apartment_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _company_idMeta = const VerificationMeta('company_id');
  GeneratedTextColumn _company_id;
  @override
  GeneratedTextColumn get company_id => _company_id ??= _constructCompanyId();
  GeneratedTextColumn _constructCompanyId() {
    return GeneratedTextColumn(
      'company_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _monthMeta = const VerificationMeta('month');
  GeneratedTextColumn _month;
  @override
  GeneratedTextColumn get month => _month ??= _constructMonth();
  GeneratedTextColumn _constructMonth() {
    return GeneratedTextColumn(
      'month',
      $tableName,
      false,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedTextColumn _year;
  @override
  GeneratedTextColumn get year => _year ??= _constructYear();
  GeneratedTextColumn _constructYear() {
    return GeneratedTextColumn(
      'year',
      $tableName,
      false,
    );
  }

  final VerificationMeta _expectedMeta = const VerificationMeta('expected');
  GeneratedTextColumn _expected;
  @override
  GeneratedTextColumn get expected => _expected ??= _constructExpected();
  GeneratedTextColumn _constructExpected() {
    return GeneratedTextColumn(
      'expected',
      $tableName,
      false,
    );
  }

  final VerificationMeta _paidMeta = const VerificationMeta('paid');
  GeneratedTextColumn _paid;
  @override
  GeneratedTextColumn get paid => _paid ??= _constructPaid();
  GeneratedTextColumn _constructPaid() {
    return GeneratedTextColumn(
      'paid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dueMeta = const VerificationMeta('due');
  GeneratedTextColumn _due;
  @override
  GeneratedTextColumn get due => _due ??= _constructDue();
  GeneratedTextColumn _constructDue() {
    return GeneratedTextColumn(
      'due',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedTextColumn _timestamp;
  @override
  GeneratedTextColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedTextColumn _constructTimestamp() {
    return GeneratedTextColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        onlineid,
        apartment_id,
        title,
        company_id,
        month,
        year,
        expected,
        paid,
        due,
        timestamp
      ];
  @override
  $MyPaymentHistoryTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_payment_history_table';
  @override
  final String actualTableName = 'my_payment_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MyPaymentHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid'], _onlineidMeta));
    } else if (isInserting) {
      context.missing(_onlineidMeta);
    }
    if (data.containsKey('apartment_id')) {
      context.handle(
          _apartment_idMeta,
          apartment_id.isAcceptableOrUnknown(
              data['apartment_id'], _apartment_idMeta));
    } else if (isInserting) {
      context.missing(_apartment_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
          _company_idMeta,
          company_id.isAcceptableOrUnknown(
              data['company_id'], _company_idMeta));
    } else if (isInserting) {
      context.missing(_company_idMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month'], _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('expected')) {
      context.handle(_expectedMeta,
          expected.isAcceptableOrUnknown(data['expected'], _expectedMeta));
    } else if (isInserting) {
      context.missing(_expectedMeta);
    }
    if (data.containsKey('paid')) {
      context.handle(
          _paidMeta, paid.isAcceptableOrUnknown(data['paid'], _paidMeta));
    } else if (isInserting) {
      context.missing(_paidMeta);
    }
    if (data.containsKey('due')) {
      context.handle(
          _dueMeta, due.isAcceptableOrUnknown(data['due'], _dueMeta));
    } else if (isInserting) {
      context.missing(_dueMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onlineid};
  @override
  MyPaymentHistoryTableData map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyPaymentHistoryTableData.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  $MyPaymentHistoryTableTable createAlias(String alias) {
    return $MyPaymentHistoryTableTable(_db, alias);
  }
}

class MyHomeSummaryTableData extends DataClass
    implements Insertable<MyHomeSummaryTableData> {
  final int id;
  final String month;
  final String year;
  final String expected;
  final String paid;
  final String due;
  MyHomeSummaryTableData(
      {@required this.id,
      @required this.month,
      @required this.year,
      @required this.expected,
      @required this.paid,
      @required this.due});
  factory MyHomeSummaryTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MyHomeSummaryTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      month:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}month']),
      year: stringType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      expected: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}expected']),
      paid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}paid']),
      due: stringType.mapFromDatabaseResponse(data['${effectivePrefix}due']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<String>(month);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<String>(year);
    }
    if (!nullToAbsent || expected != null) {
      map['expected'] = Variable<String>(expected);
    }
    if (!nullToAbsent || paid != null) {
      map['paid'] = Variable<String>(paid);
    }
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<String>(due);
    }
    return map;
  }

  MyHomeSummaryTableCompanion toCompanion(bool nullToAbsent) {
    return MyHomeSummaryTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      month:
          month == null && nullToAbsent ? const Value.absent() : Value(month),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      expected: expected == null && nullToAbsent
          ? const Value.absent()
          : Value(expected),
      paid: paid == null && nullToAbsent ? const Value.absent() : Value(paid),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
    );
  }

  factory MyHomeSummaryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyHomeSummaryTableData(
      id: serializer.fromJson<int>(json['id']),
      month: serializer.fromJson<String>(json['month']),
      year: serializer.fromJson<String>(json['year']),
      expected: serializer.fromJson<String>(json['expected']),
      paid: serializer.fromJson<String>(json['paid']),
      due: serializer.fromJson<String>(json['due']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'month': serializer.toJson<String>(month),
      'year': serializer.toJson<String>(year),
      'expected': serializer.toJson<String>(expected),
      'paid': serializer.toJson<String>(paid),
      'due': serializer.toJson<String>(due),
    };
  }

  MyHomeSummaryTableData copyWith(
          {int id,
          String month,
          String year,
          String expected,
          String paid,
          String due}) =>
      MyHomeSummaryTableData(
        id: id ?? this.id,
        month: month ?? this.month,
        year: year ?? this.year,
        expected: expected ?? this.expected,
        paid: paid ?? this.paid,
        due: due ?? this.due,
      );
  @override
  String toString() {
    return (StringBuffer('MyHomeSummaryTableData(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('expected: $expected, ')
          ..write('paid: $paid, ')
          ..write('due: $due')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          month.hashCode,
          $mrjc(year.hashCode,
              $mrjc(expected.hashCode, $mrjc(paid.hashCode, due.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyHomeSummaryTableData &&
          other.id == this.id &&
          other.month == this.month &&
          other.year == this.year &&
          other.expected == this.expected &&
          other.paid == this.paid &&
          other.due == this.due);
}

class MyHomeSummaryTableCompanion
    extends UpdateCompanion<MyHomeSummaryTableData> {
  final Value<int> id;
  final Value<String> month;
  final Value<String> year;
  final Value<String> expected;
  final Value<String> paid;
  final Value<String> due;
  const MyHomeSummaryTableCompanion({
    this.id = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.expected = const Value.absent(),
    this.paid = const Value.absent(),
    this.due = const Value.absent(),
  });
  MyHomeSummaryTableCompanion.insert({
    this.id = const Value.absent(),
    @required String month,
    @required String year,
    @required String expected,
    @required String paid,
    @required String due,
  })  : month = Value(month),
        year = Value(year),
        expected = Value(expected),
        paid = Value(paid),
        due = Value(due);
  static Insertable<MyHomeSummaryTableData> custom({
    Expression<int> id,
    Expression<String> month,
    Expression<String> year,
    Expression<String> expected,
    Expression<String> paid,
    Expression<String> due,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (expected != null) 'expected': expected,
      if (paid != null) 'paid': paid,
      if (due != null) 'due': due,
    });
  }

  MyHomeSummaryTableCompanion copyWith(
      {Value<int> id,
      Value<String> month,
      Value<String> year,
      Value<String> expected,
      Value<String> paid,
      Value<String> due}) {
    return MyHomeSummaryTableCompanion(
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      expected: expected ?? this.expected,
      paid: paid ?? this.paid,
      due: due ?? this.due,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (expected.present) {
      map['expected'] = Variable<String>(expected.value);
    }
    if (paid.present) {
      map['paid'] = Variable<String>(paid.value);
    }
    if (due.present) {
      map['due'] = Variable<String>(due.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyHomeSummaryTableCompanion(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('expected: $expected, ')
          ..write('paid: $paid, ')
          ..write('due: $due')
          ..write(')'))
        .toString();
  }
}

class $MyHomeSummaryTableTable extends MyHomeSummaryTable
    with TableInfo<$MyHomeSummaryTableTable, MyHomeSummaryTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyHomeSummaryTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _monthMeta = const VerificationMeta('month');
  GeneratedTextColumn _month;
  @override
  GeneratedTextColumn get month => _month ??= _constructMonth();
  GeneratedTextColumn _constructMonth() {
    return GeneratedTextColumn(
      'month',
      $tableName,
      false,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedTextColumn _year;
  @override
  GeneratedTextColumn get year => _year ??= _constructYear();
  GeneratedTextColumn _constructYear() {
    return GeneratedTextColumn(
      'year',
      $tableName,
      false,
    );
  }

  final VerificationMeta _expectedMeta = const VerificationMeta('expected');
  GeneratedTextColumn _expected;
  @override
  GeneratedTextColumn get expected => _expected ??= _constructExpected();
  GeneratedTextColumn _constructExpected() {
    return GeneratedTextColumn(
      'expected',
      $tableName,
      false,
    );
  }

  final VerificationMeta _paidMeta = const VerificationMeta('paid');
  GeneratedTextColumn _paid;
  @override
  GeneratedTextColumn get paid => _paid ??= _constructPaid();
  GeneratedTextColumn _constructPaid() {
    return GeneratedTextColumn(
      'paid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dueMeta = const VerificationMeta('due');
  GeneratedTextColumn _due;
  @override
  GeneratedTextColumn get due => _due ??= _constructDue();
  GeneratedTextColumn _constructDue() {
    return GeneratedTextColumn(
      'due',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, month, year, expected, paid, due];
  @override
  $MyHomeSummaryTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_home_summary_table';
  @override
  final String actualTableName = 'my_home_summary_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MyHomeSummaryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month'], _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('expected')) {
      context.handle(_expectedMeta,
          expected.isAcceptableOrUnknown(data['expected'], _expectedMeta));
    } else if (isInserting) {
      context.missing(_expectedMeta);
    }
    if (data.containsKey('paid')) {
      context.handle(
          _paidMeta, paid.isAcceptableOrUnknown(data['paid'], _paidMeta));
    } else if (isInserting) {
      context.missing(_paidMeta);
    }
    if (data.containsKey('due')) {
      context.handle(
          _dueMeta, due.isAcceptableOrUnknown(data['due'], _dueMeta));
    } else if (isInserting) {
      context.missing(_dueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyHomeSummaryTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyHomeSummaryTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyHomeSummaryTableTable createAlias(String alias) {
    return $MyHomeSummaryTableTable(_db, alias);
  }
}

class MyTransactionsTableData extends DataClass
    implements Insertable<MyTransactionsTableData> {
  final String onlineid;
  final String apartment_id;
  final String transaction_id;
  final String user_id;
  final String month;
  final String year;
  final String status;
  final String amount;
  final String time;
  final String type;
  MyTransactionsTableData(
      {@required this.onlineid,
      @required this.apartment_id,
      @required this.transaction_id,
      @required this.user_id,
      @required this.month,
      @required this.year,
      @required this.status,
      @required this.amount,
      @required this.time,
      @required this.type});
  factory MyTransactionsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MyTransactionsTableData(
      onlineid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      apartment_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apartment_id']),
      transaction_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_id']),
      user_id:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      month:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}month']),
      year: stringType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      amount:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      time: stringType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<String>(onlineid);
    }
    if (!nullToAbsent || apartment_id != null) {
      map['apartment_id'] = Variable<String>(apartment_id);
    }
    if (!nullToAbsent || transaction_id != null) {
      map['transaction_id'] = Variable<String>(transaction_id);
    }
    if (!nullToAbsent || user_id != null) {
      map['user_id'] = Variable<String>(user_id);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<String>(month);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<String>(year);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<String>(amount);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  MyTransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return MyTransactionsTableCompanion(
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      apartment_id: apartment_id == null && nullToAbsent
          ? const Value.absent()
          : Value(apartment_id),
      transaction_id: transaction_id == null && nullToAbsent
          ? const Value.absent()
          : Value(transaction_id),
      user_id: user_id == null && nullToAbsent
          ? const Value.absent()
          : Value(user_id),
      month:
          month == null && nullToAbsent ? const Value.absent() : Value(month),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory MyTransactionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyTransactionsTableData(
      onlineid: serializer.fromJson<String>(json['onlineid']),
      apartment_id: serializer.fromJson<String>(json['apartment_id']),
      transaction_id: serializer.fromJson<String>(json['transaction_id']),
      user_id: serializer.fromJson<String>(json['user_id']),
      month: serializer.fromJson<String>(json['month']),
      year: serializer.fromJson<String>(json['year']),
      status: serializer.fromJson<String>(json['status']),
      amount: serializer.fromJson<String>(json['amount']),
      time: serializer.fromJson<String>(json['time']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlineid': serializer.toJson<String>(onlineid),
      'apartment_id': serializer.toJson<String>(apartment_id),
      'transaction_id': serializer.toJson<String>(transaction_id),
      'user_id': serializer.toJson<String>(user_id),
      'month': serializer.toJson<String>(month),
      'year': serializer.toJson<String>(year),
      'status': serializer.toJson<String>(status),
      'amount': serializer.toJson<String>(amount),
      'time': serializer.toJson<String>(time),
      'type': serializer.toJson<String>(type),
    };
  }

  MyTransactionsTableData copyWith(
          {String onlineid,
          String apartment_id,
          String transaction_id,
          String user_id,
          String month,
          String year,
          String status,
          String amount,
          String time,
          String type}) =>
      MyTransactionsTableData(
        onlineid: onlineid ?? this.onlineid,
        apartment_id: apartment_id ?? this.apartment_id,
        transaction_id: transaction_id ?? this.transaction_id,
        user_id: user_id ?? this.user_id,
        month: month ?? this.month,
        year: year ?? this.year,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        time: time ?? this.time,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('MyTransactionsTableData(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('transaction_id: $transaction_id, ')
          ..write('user_id: $user_id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('time: $time, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      onlineid.hashCode,
      $mrjc(
          apartment_id.hashCode,
          $mrjc(
              transaction_id.hashCode,
              $mrjc(
                  user_id.hashCode,
                  $mrjc(
                      month.hashCode,
                      $mrjc(
                          year.hashCode,
                          $mrjc(
                              status.hashCode,
                              $mrjc(amount.hashCode,
                                  $mrjc(time.hashCode, type.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyTransactionsTableData &&
          other.onlineid == this.onlineid &&
          other.apartment_id == this.apartment_id &&
          other.transaction_id == this.transaction_id &&
          other.user_id == this.user_id &&
          other.month == this.month &&
          other.year == this.year &&
          other.status == this.status &&
          other.amount == this.amount &&
          other.time == this.time &&
          other.type == this.type);
}

class MyTransactionsTableCompanion
    extends UpdateCompanion<MyTransactionsTableData> {
  final Value<String> onlineid;
  final Value<String> apartment_id;
  final Value<String> transaction_id;
  final Value<String> user_id;
  final Value<String> month;
  final Value<String> year;
  final Value<String> status;
  final Value<String> amount;
  final Value<String> time;
  final Value<String> type;
  const MyTransactionsTableCompanion({
    this.onlineid = const Value.absent(),
    this.apartment_id = const Value.absent(),
    this.transaction_id = const Value.absent(),
    this.user_id = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.time = const Value.absent(),
    this.type = const Value.absent(),
  });
  MyTransactionsTableCompanion.insert({
    @required String onlineid,
    @required String apartment_id,
    @required String transaction_id,
    @required String user_id,
    @required String month,
    @required String year,
    @required String status,
    @required String amount,
    @required String time,
    @required String type,
  })  : onlineid = Value(onlineid),
        apartment_id = Value(apartment_id),
        transaction_id = Value(transaction_id),
        user_id = Value(user_id),
        month = Value(month),
        year = Value(year),
        status = Value(status),
        amount = Value(amount),
        time = Value(time),
        type = Value(type);
  static Insertable<MyTransactionsTableData> custom({
    Expression<String> onlineid,
    Expression<String> apartment_id,
    Expression<String> transaction_id,
    Expression<String> user_id,
    Expression<String> month,
    Expression<String> year,
    Expression<String> status,
    Expression<String> amount,
    Expression<String> time,
    Expression<String> type,
  }) {
    return RawValuesInsertable({
      if (onlineid != null) 'onlineid': onlineid,
      if (apartment_id != null) 'apartment_id': apartment_id,
      if (transaction_id != null) 'transaction_id': transaction_id,
      if (user_id != null) 'user_id': user_id,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (status != null) 'status': status,
      if (amount != null) 'amount': amount,
      if (time != null) 'time': time,
      if (type != null) 'type': type,
    });
  }

  MyTransactionsTableCompanion copyWith(
      {Value<String> onlineid,
      Value<String> apartment_id,
      Value<String> transaction_id,
      Value<String> user_id,
      Value<String> month,
      Value<String> year,
      Value<String> status,
      Value<String> amount,
      Value<String> time,
      Value<String> type}) {
    return MyTransactionsTableCompanion(
      onlineid: onlineid ?? this.onlineid,
      apartment_id: apartment_id ?? this.apartment_id,
      transaction_id: transaction_id ?? this.transaction_id,
      user_id: user_id ?? this.user_id,
      month: month ?? this.month,
      year: year ?? this.year,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlineid.present) {
      map['onlineid'] = Variable<String>(onlineid.value);
    }
    if (apartment_id.present) {
      map['apartment_id'] = Variable<String>(apartment_id.value);
    }
    if (transaction_id.present) {
      map['transaction_id'] = Variable<String>(transaction_id.value);
    }
    if (user_id.present) {
      map['user_id'] = Variable<String>(user_id.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (amount.present) {
      map['amount'] = Variable<String>(amount.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyTransactionsTableCompanion(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('transaction_id: $transaction_id, ')
          ..write('user_id: $user_id, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('time: $time, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $MyTransactionsTableTable extends MyTransactionsTable
    with TableInfo<$MyTransactionsTableTable, MyTransactionsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyTransactionsTableTable(this._db, [this._alias]);
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  GeneratedTextColumn _onlineid;
  @override
  GeneratedTextColumn get onlineid => _onlineid ??= _constructOnlineid();
  GeneratedTextColumn _constructOnlineid() {
    return GeneratedTextColumn(
      'onlineid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apartment_idMeta =
      const VerificationMeta('apartment_id');
  GeneratedTextColumn _apartment_id;
  @override
  GeneratedTextColumn get apartment_id =>
      _apartment_id ??= _constructApartmentId();
  GeneratedTextColumn _constructApartmentId() {
    return GeneratedTextColumn(
      'apartment_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _transaction_idMeta =
      const VerificationMeta('transaction_id');
  GeneratedTextColumn _transaction_id;
  @override
  GeneratedTextColumn get transaction_id =>
      _transaction_id ??= _constructTransactionId();
  GeneratedTextColumn _constructTransactionId() {
    return GeneratedTextColumn(
      'transaction_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _user_idMeta = const VerificationMeta('user_id');
  GeneratedTextColumn _user_id;
  @override
  GeneratedTextColumn get user_id => _user_id ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _monthMeta = const VerificationMeta('month');
  GeneratedTextColumn _month;
  @override
  GeneratedTextColumn get month => _month ??= _constructMonth();
  GeneratedTextColumn _constructMonth() {
    return GeneratedTextColumn(
      'month',
      $tableName,
      false,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedTextColumn _year;
  @override
  GeneratedTextColumn get year => _year ??= _constructYear();
  GeneratedTextColumn _constructYear() {
    return GeneratedTextColumn(
      'year',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedTextColumn _amount;
  @override
  GeneratedTextColumn get amount => _amount ??= _constructAmount();
  GeneratedTextColumn _constructAmount() {
    return GeneratedTextColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedTextColumn _time;
  @override
  GeneratedTextColumn get time => _time ??= _constructTime();
  GeneratedTextColumn _constructTime() {
    return GeneratedTextColumn(
      'time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        onlineid,
        apartment_id,
        transaction_id,
        user_id,
        month,
        year,
        status,
        amount,
        time,
        type
      ];
  @override
  $MyTransactionsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_transactions_table';
  @override
  final String actualTableName = 'my_transactions_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MyTransactionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid'], _onlineidMeta));
    } else if (isInserting) {
      context.missing(_onlineidMeta);
    }
    if (data.containsKey('apartment_id')) {
      context.handle(
          _apartment_idMeta,
          apartment_id.isAcceptableOrUnknown(
              data['apartment_id'], _apartment_idMeta));
    } else if (isInserting) {
      context.missing(_apartment_idMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transaction_idMeta,
          transaction_id.isAcceptableOrUnknown(
              data['transaction_id'], _transaction_idMeta));
    } else if (isInserting) {
      context.missing(_transaction_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_user_idMeta,
          user_id.isAcceptableOrUnknown(data['user_id'], _user_idMeta));
    } else if (isInserting) {
      context.missing(_user_idMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month'], _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time'], _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onlineid};
  @override
  MyTransactionsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyTransactionsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyTransactionsTableTable createAlias(String alias) {
    return $MyTransactionsTableTable(_db, alias);
  }
}

class MyTenantTableData extends DataClass
    implements Insertable<MyTenantTableData> {
  final String onlineid;
  final String apartment_id;
  final String photo;
  final String name;
  final String email;
  final String payed;
  final String unit;
  MyTenantTableData(
      {@required this.onlineid,
      @required this.apartment_id,
      @required this.photo,
      @required this.name,
      @required this.email,
      @required this.payed,
      @required this.unit});
  factory MyTenantTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MyTenantTableData(
      onlineid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      apartment_id: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}apartment_id']),
      photo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}photo']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      payed:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}payed']),
      unit: stringType.mapFromDatabaseResponse(data['${effectivePrefix}unit']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<String>(onlineid);
    }
    if (!nullToAbsent || apartment_id != null) {
      map['apartment_id'] = Variable<String>(apartment_id);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || payed != null) {
      map['payed'] = Variable<String>(payed);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    return map;
  }

  MyTenantTableCompanion toCompanion(bool nullToAbsent) {
    return MyTenantTableCompanion(
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      apartment_id: apartment_id == null && nullToAbsent
          ? const Value.absent()
          : Value(apartment_id),
      photo:
          photo == null && nullToAbsent ? const Value.absent() : Value(photo),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      payed:
          payed == null && nullToAbsent ? const Value.absent() : Value(payed),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  factory MyTenantTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyTenantTableData(
      onlineid: serializer.fromJson<String>(json['onlineid']),
      apartment_id: serializer.fromJson<String>(json['apartment_id']),
      photo: serializer.fromJson<String>(json['photo']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      payed: serializer.fromJson<String>(json['payed']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlineid': serializer.toJson<String>(onlineid),
      'apartment_id': serializer.toJson<String>(apartment_id),
      'photo': serializer.toJson<String>(photo),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'payed': serializer.toJson<String>(payed),
      'unit': serializer.toJson<String>(unit),
    };
  }

  MyTenantTableData copyWith(
          {String onlineid,
          String apartment_id,
          String photo,
          String name,
          String email,
          String payed,
          String unit}) =>
      MyTenantTableData(
        onlineid: onlineid ?? this.onlineid,
        apartment_id: apartment_id ?? this.apartment_id,
        photo: photo ?? this.photo,
        name: name ?? this.name,
        email: email ?? this.email,
        payed: payed ?? this.payed,
        unit: unit ?? this.unit,
      );
  @override
  String toString() {
    return (StringBuffer('MyTenantTableData(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('photo: $photo, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('payed: $payed, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      onlineid.hashCode,
      $mrjc(
          apartment_id.hashCode,
          $mrjc(
              photo.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(email.hashCode,
                      $mrjc(payed.hashCode, unit.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyTenantTableData &&
          other.onlineid == this.onlineid &&
          other.apartment_id == this.apartment_id &&
          other.photo == this.photo &&
          other.name == this.name &&
          other.email == this.email &&
          other.payed == this.payed &&
          other.unit == this.unit);
}

class MyTenantTableCompanion extends UpdateCompanion<MyTenantTableData> {
  final Value<String> onlineid;
  final Value<String> apartment_id;
  final Value<String> photo;
  final Value<String> name;
  final Value<String> email;
  final Value<String> payed;
  final Value<String> unit;
  const MyTenantTableCompanion({
    this.onlineid = const Value.absent(),
    this.apartment_id = const Value.absent(),
    this.photo = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.payed = const Value.absent(),
    this.unit = const Value.absent(),
  });
  MyTenantTableCompanion.insert({
    @required String onlineid,
    @required String apartment_id,
    @required String photo,
    @required String name,
    @required String email,
    @required String payed,
    @required String unit,
  })  : onlineid = Value(onlineid),
        apartment_id = Value(apartment_id),
        photo = Value(photo),
        name = Value(name),
        email = Value(email),
        payed = Value(payed),
        unit = Value(unit);
  static Insertable<MyTenantTableData> custom({
    Expression<String> onlineid,
    Expression<String> apartment_id,
    Expression<String> photo,
    Expression<String> name,
    Expression<String> email,
    Expression<String> payed,
    Expression<String> unit,
  }) {
    return RawValuesInsertable({
      if (onlineid != null) 'onlineid': onlineid,
      if (apartment_id != null) 'apartment_id': apartment_id,
      if (photo != null) 'photo': photo,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (payed != null) 'payed': payed,
      if (unit != null) 'unit': unit,
    });
  }

  MyTenantTableCompanion copyWith(
      {Value<String> onlineid,
      Value<String> apartment_id,
      Value<String> photo,
      Value<String> name,
      Value<String> email,
      Value<String> payed,
      Value<String> unit}) {
    return MyTenantTableCompanion(
      onlineid: onlineid ?? this.onlineid,
      apartment_id: apartment_id ?? this.apartment_id,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      email: email ?? this.email,
      payed: payed ?? this.payed,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlineid.present) {
      map['onlineid'] = Variable<String>(onlineid.value);
    }
    if (apartment_id.present) {
      map['apartment_id'] = Variable<String>(apartment_id.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (payed.present) {
      map['payed'] = Variable<String>(payed.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyTenantTableCompanion(')
          ..write('onlineid: $onlineid, ')
          ..write('apartment_id: $apartment_id, ')
          ..write('photo: $photo, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('payed: $payed, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $MyTenantTableTable extends MyTenantTable
    with TableInfo<$MyTenantTableTable, MyTenantTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyTenantTableTable(this._db, [this._alias]);
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  GeneratedTextColumn _onlineid;
  @override
  GeneratedTextColumn get onlineid => _onlineid ??= _constructOnlineid();
  GeneratedTextColumn _constructOnlineid() {
    return GeneratedTextColumn(
      'onlineid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _apartment_idMeta =
      const VerificationMeta('apartment_id');
  GeneratedTextColumn _apartment_id;
  @override
  GeneratedTextColumn get apartment_id =>
      _apartment_id ??= _constructApartmentId();
  GeneratedTextColumn _constructApartmentId() {
    return GeneratedTextColumn(
      'apartment_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _photoMeta = const VerificationMeta('photo');
  GeneratedTextColumn _photo;
  @override
  GeneratedTextColumn get photo => _photo ??= _constructPhoto();
  GeneratedTextColumn _constructPhoto() {
    return GeneratedTextColumn(
      'photo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _payedMeta = const VerificationMeta('payed');
  GeneratedTextColumn _payed;
  @override
  GeneratedTextColumn get payed => _payed ??= _constructPayed();
  GeneratedTextColumn _constructPayed() {
    return GeneratedTextColumn(
      'payed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unitMeta = const VerificationMeta('unit');
  GeneratedTextColumn _unit;
  @override
  GeneratedTextColumn get unit => _unit ??= _constructUnit();
  GeneratedTextColumn _constructUnit() {
    return GeneratedTextColumn(
      'unit',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [onlineid, apartment_id, photo, name, email, payed, unit];
  @override
  $MyTenantTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_tenant_table';
  @override
  final String actualTableName = 'my_tenant_table';
  @override
  VerificationContext validateIntegrity(Insertable<MyTenantTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid'], _onlineidMeta));
    } else if (isInserting) {
      context.missing(_onlineidMeta);
    }
    if (data.containsKey('apartment_id')) {
      context.handle(
          _apartment_idMeta,
          apartment_id.isAcceptableOrUnknown(
              data['apartment_id'], _apartment_idMeta));
    } else if (isInserting) {
      context.missing(_apartment_idMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
          _photoMeta, photo.isAcceptableOrUnknown(data['photo'], _photoMeta));
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('payed')) {
      context.handle(
          _payedMeta, payed.isAcceptableOrUnknown(data['payed'], _payedMeta));
    } else if (isInserting) {
      context.missing(_payedMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit'], _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onlineid};
  @override
  MyTenantTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyTenantTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyTenantTableTable createAlias(String alias) {
    return $MyTenantTableTable(_db, alias);
  }
}

abstract class _$DatabaseHelper extends GeneratedDatabase {
  _$DatabaseHelper(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MyApartmentTableTable _myApartmentTable;
  $MyApartmentTableTable get myApartmentTable =>
      _myApartmentTable ??= $MyApartmentTableTable(this);
  $MyImagesTableTable _myImagesTable;
  $MyImagesTableTable get myImagesTable =>
      _myImagesTable ??= $MyImagesTableTable(this);
  $MyFeaturesTableTable _myFeaturesTable;
  $MyFeaturesTableTable get myFeaturesTable =>
      _myFeaturesTable ??= $MyFeaturesTableTable(this);
  $MyPaymentHistoryTableTable _myPaymentHistoryTable;
  $MyPaymentHistoryTableTable get myPaymentHistoryTable =>
      _myPaymentHistoryTable ??= $MyPaymentHistoryTableTable(this);
  $MyHomeSummaryTableTable _myHomeSummaryTable;
  $MyHomeSummaryTableTable get myHomeSummaryTable =>
      _myHomeSummaryTable ??= $MyHomeSummaryTableTable(this);
  $MyTransactionsTableTable _myTransactionsTable;
  $MyTransactionsTableTable get myTransactionsTable =>
      _myTransactionsTable ??= $MyTransactionsTableTable(this);
  $MyTenantTableTable _myTenantTable;
  $MyTenantTableTable get myTenantTable =>
      _myTenantTable ??= $MyTenantTableTable(this);
  DatabaseDao _databaseDao;
  DatabaseDao get databaseDao =>
      _databaseDao ??= DatabaseDao(this as DatabaseHelper);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        myApartmentTable,
        myImagesTable,
        myFeaturesTable,
        myPaymentHistoryTable,
        myHomeSummaryTable,
        myTransactionsTable,
        myTenantTable
      ];
}
