class FirebaseUser {
  String? email;
  String? uid;
  String? password;
  String? displayName;
  bool? emailVerified;

  FirebaseUser(this.email, this.uid, this.emailVerified, this.displayName);
}
