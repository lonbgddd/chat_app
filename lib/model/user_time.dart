class UserTime{
  String uid;
  String time;

  UserTime({required this.uid, required this.time});

  factory UserTime.fromJson(Map<String, dynamic> json) => UserTime(
    uid: json["uid"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "time": time,
  };
}