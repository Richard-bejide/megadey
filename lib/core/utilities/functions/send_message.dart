import 'package:firebase_database/firebase_database.dart';

void createNewMessage(
    {required String type,
    required String data,
    String? contactType,
    String? videoThumbnail,
    required String currentUserId,
    required String? conversationId,
    required String matchId}) async {
  try {
    DatabaseReference? _databaseReference = FirebaseDatabase.instance.ref("chats/messages/${conversationId}");
    final snapshot = await _databaseReference.get();
    //create new message. (user has previous messages)
    if (snapshot.exists) {
        DatabaseReference newMessageRef = _databaseReference.push();
        //create message
        await _databaseReference.update({
          newMessageRef.key!: messageData(type, data, currentUserId,
              contactType: contactType, videoThumbnail: videoThumbnail)
        });
        }
    //create new message. (user has no previous messages since snapshot does not exist)
    else {
      DatabaseReference? _newRef = FirebaseDatabase.instance.ref("chats/messages");
      DatabaseReference newMessageRef = _databaseReference.push();
      await _newRef.update({
        conversationId! : {
          newMessageRef.key: messageData(type, data, currentUserId,
              contactType: contactType, videoThumbnail: videoThumbnail)
        }
      });
    }

    //update in conversations list
    updateConversation(
        lastMessage: data,
        lastMessageTime: DateTime.now().toString(),
        lastMessageType: type,
        conversationID: conversationId);

  } catch (e) {
    rethrow;
  }
}


void updateConversation(
    {required String lastMessage,
    required String lastMessageTime,
    required String lastMessageType,
     String? conversationID,
    }) async {
  try {
    DatabaseReference? _databaseReference = FirebaseDatabase.instance.ref("chats/conversations/$conversationID");
      await _databaseReference.update({
        'last_message': lastMessage,
        'last_message_timestamp': lastMessageTime,
        'last_message_type': lastMessageType,
      });
  } catch (e) {
    rethrow;
  }
}

Map<String, dynamic> messageData(String type, String data, String? userId, {String? contactType, String? videoThumbnail}) {
  if (type == 'text') {
    return {'sender_user_id': userId, 'message_type': type, 'text': data, 'time_stamp': DateTime.now().toString(), 'is_received': false};
  }
  else if (type == 'voice_note') {
    return {'sender_user_id': userId, 'message_type': type, 'voice_note': data, 'time_stamp': DateTime.now().toString(), 'is_received': false,
    };
  }
  else if (type == 'photo') {
    return {'sender_user_id': userId, 'message_type': type, 'media_url': data, 'time_stamp': DateTime.now().toString(), 'is_received': false,
    };
  }
  else if (type == 'video') {
    return {'sender_user_id': userId, 'message_type': type, 'media_url': data, 'video_thumbnail': videoThumbnail, 'time_stamp': DateTime.now().toString(), 'is_received': false,
    };
  }
  else {
    return {'sender_user_id': userId, 'message_type': type, 'contact_type': contactType, 'contact': data, 'time_stamp': DateTime.now().toString(), 'is_received': false,
    };
  }
}
