class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final String userId;

  ChatModel({
    required this.userId,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      userId: json['uId'],
      name: json['name'],
      message: json['message'],
      time: json['time'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uId': userId,
    'name': name,
    'message': message,
    'time': time,
    'avatarUrl': avatarUrl,
  };

}
