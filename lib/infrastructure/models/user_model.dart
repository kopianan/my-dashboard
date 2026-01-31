import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';
 
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
      );
}

extension UserModelX on UserModel {
  User toEntity() => User(
        id: id,
        email: email,
        name: name,
      );
}