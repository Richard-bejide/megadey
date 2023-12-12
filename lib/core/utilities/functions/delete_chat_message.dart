import 'package:firebase_database/firebase_database.dart';

void deleteMessage({required String messageId, required String? conversationId,bool? deleteConversation, Map<String,dynamic>? previousMessageMap}) async {
  try {
    DatabaseReference? _messageRef = FirebaseDatabase.instance.ref("chats/messages/${conversationId}/${messageId}");
    final messageSnapshot = await _messageRef.get();
    if (messageSnapshot.exists) {
      await _messageRef.remove(); //remove message
      print('message deleted');
    }
    //update conversation only if message is the last one sent
    if(deleteConversation != null && deleteConversation) {
      DatabaseReference? _conversationRef = FirebaseDatabase.instance.ref("chats/conversations/${conversationId}");
      final conversationSnapshot = await _conversationRef.get();
      if (conversationSnapshot.exists) {
        await _conversationRef.update(previousMessageMap!);
        print('conversation deleted');
      }
   }

  } catch (e) {
    print('error deleting message');
   rethrow;
  }
}
