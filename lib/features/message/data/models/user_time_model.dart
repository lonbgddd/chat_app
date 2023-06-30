import '../../domain/entities/user_time_entity.dart';

class UserTimeModel extends UserTimeEntity {
  const UserTimeModel({String? uid, String? time}) : super(uid: uid, time: time);
  factory UserTimeModel.fromJson(Map<String, dynamic> json) => UserTimeModel(
    uid: json["uid"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "time": time,
  };
}
