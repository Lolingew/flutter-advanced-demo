import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'UserSample.g.dart';

//这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserSample{
  UserSample(this.name, this.email);

  String name;
  String email;

  //当返回字段是下划线模式时，想要使用驼峰命名，可以加JsonKey注解
  @JsonKey(name: 'registration_date_millis')
  final int registrationDateMillis = 0;

  factory UserSample.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}