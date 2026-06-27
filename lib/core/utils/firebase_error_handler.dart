import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String getReadableError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password. Please try again.';
        case 'email-already-in-use':
          return 'This email is already registered. Try logging in.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This account has been disabled. Contact support.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'network-request-failed':
          return 'No internet connection. Please check your network.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled.';
        default:
          return e.message ?? 'An unexpected error occurred.';
      }
    }

    String message = e.toString();

    if (message.startsWith('Exception: ')) {
      message = message.substring(11);
    }

    final firebaseRegex =
        RegExp(r'\[(?:firebase_auth|cloud_firestore)/([^\]]+)\]\s*(.*)');
    final match = firebaseRegex.firstMatch(message);

    if (match != null) {
      final code = match.group(1)!;
      switch (code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password. Please try again.';
        case 'email-already-in-use':
          return 'This email is already registered. Try logging in.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This account has been disabled. Contact support.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'network-request-failed':
          return 'No internet connection. Please check your network.';
        case 'permission-denied':
          return 'You do not have permission to access this data.';
        default:
          return match.group(2)?.isNotEmpty == true
              ? match.group(2)!
              : 'An unexpected error occurred.';
      }
    }

    return message.isNotEmpty ? message : 'An unexpected error occurred.';
  }
}
