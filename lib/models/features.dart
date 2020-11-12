import 'package:json_annotation/json_annotation.dart';
part 'features.g.dart';

@JsonSerializable()
class Features {
  String id;
  String apartment_id;
  String feat0;
  String feat1;
  String feat2;
  String feat3;
  String feat4;
  String feat5;
  String feat6;
  String feat7;
  String feat8;
  String feat9;
  String feat10;

  Features({
    this.id,
    this.apartment_id,
    this.feat0,
    this.feat1,
    this.feat2,
    this.feat3,
    this.feat4,
    this.feat5,
    this.feat6,
    this.feat7,
    this.feat8,
    this.feat9,
    this.feat10,
  });

  factory Features.fromJson(Map<String, dynamic> json) =>
      _$FeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturesToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "feat0",
    "feat1",
    "feat2",
    "feat3",
    "feat4",
    "feat5",
    "feat6",
    "feat7",
    "feat8",
    "feat9",
    "feat10"
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "feat0": feat0,
      "feat1": feat1,
      "feat2": feat2,
      "feat3": feat3,
      "feat4": feat4,
      "feat5": feat5,
      "feat6": feat6,
      "feat7": feat7,
      "feat8": feat8,
      "feat9": feat9,
      "feat10": feat10,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Features features = Features();
    //images.id = map["id"].toString();
    features.id = map["online_id"];
    features.apartment_id = map["apartment_id"];
    features.feat0 = map["feat0"];
    features.feat1 = map["feat1"];
    features.feat2 = map["feat2"];
    features.feat3 = map["feat3"];
    features.feat4 = map["feat4"];
    features.feat5 = map["feat5"];
    features.feat6 = map["feat6"];
    features.feat7 = map["feat7"];
    features.feat8 = map["feat8"];
    features.feat9 = map["feat9"];
    features.feat10 = map["feat10"];

    return features;
  }
}
