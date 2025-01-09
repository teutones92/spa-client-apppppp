import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spa_client_app/models/server/chat_model/chat_model.dart';

class DbChatService {
  static Future<void> sendMessage(ChatModel message) async {
    final ref = FirebaseFirestore.instance.collection('chats');
    await ref.add(message.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    final ref = FirebaseFirestore.instance.collection('chats').snapshots();
    return ref;
  }

  static Future<void> deleteMessage(String id) async {
    final ref = FirebaseFirestore.instance.collection('chats').doc(id);
    await ref.delete();
  }

  static Future<void> deleteAllMessageByUserId(String userId) async {
    final ref = FirebaseFirestore.instance.collection('chats');
    final snapshot = await ref.get();
    for (final doc in snapshot.docs) {
      final message = ChatModel.fromJson(doc.data(), doc.id);
      if (message.senderId == userId || message.receiverId == userId) {
        await ref.doc(doc.id).delete();
      }
    }
  }
}
