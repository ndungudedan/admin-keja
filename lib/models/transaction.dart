import 'package:admin_keja/models/status.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction.g.dart';

@JsonSerializable()
class MyTransaction {
  String id;
  String user_id;
  String apartment_id;
  String transaction_id;
  String status;
  String amount;
  String time;
  String month;
  String type;
  String year;

  MyTransaction({
    this.id,
    this.user_id,
    this.transaction_id,
    this.apartment_id,
    this.status,
    this.amount,
    this.time,
    this.month,
    this.year,
    this.type,
  });

  factory MyTransaction.fromJson(Map<String, dynamic> json) =>
      _$MyTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$MyTransactionToJson(this);

  static final columns = [
    "id",
    "online_id",
    "user_id",
    "apartment_id",
    "transaction_id",
    "status"
    "amount",
    "time",
    "month",
    "year",
    "type",
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "online_id": id,
      "user_id": user_id,
      "apartment_id": apartment_id,
      "transaction_id": transaction_id,
      "status": status,
      "amount": amount,
      "time": time,
      "month": month,
      "year": year,
      "type": type,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    MyTransaction transaction = MyTransaction();
    //transaction.id = map["id"].toString();
    transaction.id = map["online_id"];
    transaction.user_id = map["user_id"];
    transaction.transaction_id = map["transaction_id"];
    transaction.apartment_id = map["apartment_id"];
    transaction.year = map["status"];
    transaction.amount = map["amount"];
    transaction.time = map["time"];
    transaction.month = map["month"];
    transaction.year = map["year"];
    transaction.type = map["type"];
    return transaction;
  }
}

@JsonSerializable()
class TransactionList {
  List<MyTransaction> transactions;

  TransactionList({
    this.transactions,
  });

  factory TransactionList.fromJson(List<dynamic> json) {
    return TransactionList(
        transactions: json
            .map((e) => MyTransaction.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

@JsonSerializable()
class TransactionResponse {
  TransactionList data;
  Status status;

  TransactionResponse({
    this.data,
    this.status,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
