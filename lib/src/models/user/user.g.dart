// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      locale: json['locale'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'locale': instance.locale,
      if (instance.password case final value?) 'password': value,
    };
