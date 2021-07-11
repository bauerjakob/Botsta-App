class ChatPracticant {
  const ChatPracticant(this.id, this.name, this.isBot);
  final String id;
  final String name;
  final bool isBot;

  ChatPracticant clone() {
    return new ChatPracticant(id, name, isBot);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isBot': isBot ? 1 : 0
    };
  }
}