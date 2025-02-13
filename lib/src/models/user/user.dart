import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String locale;

  @JsonKey(includeIfNull: false)
  String? password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.locale,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> userJson) => _$UserFromJson(userJson);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? locale,
    String? password,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        locale: locale ?? this.locale,
        password: password ?? this.password,
      );

  @override
  String toString() => 'User(${toJson()})';
}
