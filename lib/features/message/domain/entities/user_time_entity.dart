import 'package:equatable/equatable.dart';

class UserTimeEntity extends Equatable {
  final String? uid;
  final String? time;

  const UserTimeEntity({this.uid, this.time});

  @override
  List<Object?> get props => [uid, time];
}