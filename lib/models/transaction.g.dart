// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTransaction _$MyTransactionFromJson(Map<String, dynamic> json) {
  return MyTransaction(
    id: json['id'] as String,
    user_id: json['user_id'] as String,
    transaction_id: json['transaction_id'] as String,
    apartment_id: json['apartment_id'] as String,
    status: json['status'] as String,
    amount: json['amount'] as String,
    time: json['time'] as String,
    month: json['month'] as String,
    year: json['year'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$MyTransactionToJson(MyTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'apartment_id': instance.apartment_id,
      'transaction_id': instance.transaction_id,
      'status': instance.status,
      'amount': instance.amount,
      'time': instance.time,
      'month': instance.month,
      'type': instance.type,
      'year': instance.year,
    };

TransactionList _$TransactionListFromJson(Map<String, dynamic> json) {
  return TransactionList(
    transactions: (json['transactions'] as List)
        ?.map((e) => e == null
            ? null
            : MyTransaction.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransactionListToJson(TransactionList instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
    };

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) {
  return TransactionResponse(
    data: json['data'] == null
        ? null
        : TransactionList.fromJson(json['data'] as List),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
