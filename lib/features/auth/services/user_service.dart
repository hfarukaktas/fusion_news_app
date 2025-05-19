import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference userColletion =
      FirebaseFirestore.instance.collection('/users');

  Future<void> createUser({
    required String id,
    required String email,
    required String name,
  }) async {
    await userColletion.doc(id).set({'id': id, 'email': email, 'name': name});
  }
}
