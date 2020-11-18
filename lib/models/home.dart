import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home.g.dart';

@JsonSerializable()
class MyHome {
  String id;
  String apartment_id;
  String company_id;
  String expected;
  String paid;
  String timestamp;
  String title;
  String due;
  String month;
  String year;
  String banner;

  MyHome(
      {this.id,
      this.apartment_id,
      this.company_id,
      this.expected,
      this.banner,
      this.paid,
      this.timestamp,
      this.title,
      this.due,
      this.month,
      this.year});

  factory MyHome.fromJson(Map<String, dynamic> json) => _$MyHomeFromJson(json);

  Map<String, dynamic> toJson() => _$MyHomeToJson(this);

  static final columns = [
    "id",
    "online_id",
    "apartment_id",
    "company_id",
    "title",
    "year",
    "month",
    "expected",
    "paid",
    "due",
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "apartment_id": apartment_id,
      "company_id": company_id,
      "month": month,
      "title": title,
      "year": year,
      "expected": expected,
      "paid": paid,
      "due": due,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    MyHome myHome = MyHome();
    //myHome.id = map["id"].toString();
    myHome.id = map["online_id"];
    myHome.apartment_id = map["apartment_id"];
    myHome.company_id = map["company_id"];
    myHome.year = map["year"];
    myHome.title = map["title"];
    myHome.month = map["month"];
    myHome.due = map["due"];
    myHome.expected = map["expected"];
    myHome.paid = map["paid"];
    return myHome;
  }
}

@JsonSerializable()
class MyHomeSummary {
  String id;
  String expected;
  String paid;
  String due;
  String month;
  String year;
  MyHomeSummary({this.id,this.expected, this.paid, this.due, this.month, this.year});

  factory MyHomeSummary.fromJson(Map<String, dynamic> json) =>
      _$MyHomeSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MyHomeSummaryToJson(this);

  static final columns = [
    "year",
    "month",
    "expected",
    "paid",
    "due",
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "month": month,
      "year": year,
      "expected": expected,
      "paid": paid,
      "due": due,
      
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static fromMap(Map map) {
    MyHomeSummary myHomeSummary = MyHomeSummary();
    myHomeSummary.id = map["id"].toString();
    myHomeSummary.year = map["year"];
    myHomeSummary.month = map["month"];
    myHomeSummary.due = map["due"];
    myHomeSummary.expected = map["expected"];
    myHomeSummary.paid = map["paid"];
    return myHomeSummary;
  }
}

@JsonSerializable()
class MyHomeSummaryList {
  List<MyHomeSummary> values;
  MyHomeSummaryList({this.values});

  factory MyHomeSummaryList.fromJson(List<dynamic> json) {
    return MyHomeSummaryList(
        values: json
            .map((e) => MyHomeSummary.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

@JsonSerializable()
class MyHomeList {
  List<MyHome> myhomes;
  MyHomeList({this.myhomes});

  factory MyHomeList.fromJson(List<dynamic> json) {
    return MyHomeList(
        myhomes: json
            .map((e) => MyHome.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

@JsonSerializable()
class MyHomeResponse {
  MyHomeSummaryList summary;
  MyHomeList data;
  Status status;

  MyHomeResponse({
    this.data,
    this.status,
    this.summary,
  });

  factory MyHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$MyHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyHomeResponseToJson(this);
}
