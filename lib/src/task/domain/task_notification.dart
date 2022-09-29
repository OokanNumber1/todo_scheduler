import 'dart:convert';
import 'package:equatable/equatable.dart';

//enum RepeatType { daysRepeat, minutesRepeat, none }

class TaskNotification extends Equatable {
  final bool isRepeat;
  ///TODO: Implement repeating days
//  final List<RepeatDay>? repeatDays;
  final int? repeatInterval;
  const TaskNotification({
    required this.isRepeat,
    //   this.repeatDays,
    this.repeatInterval,
  });

  TaskNotification copyWith({
    bool? isRepeat,
    // List<RepeatDay>? repeatDays,
    int? repeatInterval,
  }) {
    return TaskNotification(
      isRepeat: isRepeat ?? this.isRepeat,
      //   repeatDays: repeatDays ?? this.repeatDays,
      repeatInterval: repeatInterval ?? this.repeatInterval,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isRepeat': isRepeat,
      // 'repeatDays':  repeatDays, //?? TZDateTime.fromMillisecondsSinceEpoch(local, 1),
      'repeatInterval': repeatInterval ??
          0 //?? TZDateTime.fromMillisecondsSinceEpoch(local, 1),
    };
  }

  factory TaskNotification.empty() {
    return const TaskNotification(
      isRepeat: false,
      //  repeatDays: [],
      repeatInterval: 0,
    );
  }

  factory TaskNotification.fromMap(Map<String, dynamic> map) {
    return TaskNotification(
      isRepeat: map['isRepeat'] ?? false,
      //repeatDays: map['repeatDays'] ?? 1,
      repeatInterval: map['repeatInterval'] ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskNotification.fromJson(String source) =>
      TaskNotification.fromMap(json.decode(source));

  // @override
  // String toString() =>
  //     'TaskNotification(isRepeat: $isRepeat, repeatInterval: $repeatInterval,)';

  @override
  List<Object?> get props => [
        isRepeat,
        //repeatDays,
        repeatInterval,
      ];
}
