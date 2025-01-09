class ChatModel {
  String? id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime time;
  bool selected;

  ChatModel({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.time,
    this.selected = false,
  });

  ChatModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? message,
    DateTime? time,
    bool? selected,
  }) {
    return ChatModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      time: time ?? this.time,
      selected: selected ?? this.selected,
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json, String id) {
    return ChatModel(
      id: id,
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time.toString(),
    };
  }
}
