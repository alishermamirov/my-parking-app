import 'package:firebase_database/firebase_database.dart';
import 'package:my_parking_app/models/user_model.dart';

class UserService {
  final database = FirebaseDatabase.instance;

  Future<void> saveUserData(UserModel user) async {
    DatabaseReference userRef = database.ref('users/${user.userId}');
    await userRef.set(user.toJson());
  }

  Future<UserModel?> getUserData(String uid) async {
    DatabaseReference userRef = database.ref('users/$uid');
    final snapshot = await userRef.get();
    if (snapshot.exists && snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return UserModel.fromJson(data);
    }
    return null;
  }

  Future<void> updateUserData(UserModel user) async {
    DatabaseReference userRef = database.ref('users/${user.userId}');
    await userRef.update(user.toJson());
  }

  Future<void> deleteUserData(String uid) async {
    DatabaseReference userRef = database.ref('users/$uid');
    await userRef.remove();
  }
}
