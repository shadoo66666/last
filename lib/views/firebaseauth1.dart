import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign up a user with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create a new user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); 
      return credential.user; // Return the created user
    } catch (e) {
      // If an error occurs during registration, print the error and return null
      print("Error occurred during registration: $e");
      return null;
    }
  }

  // Method to log in a user with email and password
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in user with email and password
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user; // Return the logged-in user
    } catch (e) {
      // If an error occurs during login, print the error and return null
      print("Error occurred during login: $e");
      return null;
    }
  }

  // Method to update user profile with username
  Future<void> updateUserProfile(String username) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Update display name of the current user with the provided username
        await currentUser.updateDisplayName(username);
      } else {
        // If no user is signed in, print a message
        print('No user is currently signed in');
      }
    } catch (e) {
      // If an error occurs during profile update, print the error
      print('Error updating user profile: $e');
    }
  }
}
