import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String title, var time) async {
    String res = "some error occurred";
    print(Timestamp.now().toDate());
    try {
      String postId = const Uuid().v1();

      Post post = Post(
        postId: postId,
        datePublished: FieldValue.serverTimestamp(),
        title: title,
        time: time,
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
