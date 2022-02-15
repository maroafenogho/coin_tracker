class User {
  String? email;
  String? uid;
  String? password;
  String? displayName;
  bool? emailVerified;

  User.signUp(this.email, this.password, this.displayName);

  User(this.email, this.uid, this.emailVerified, this.displayName);

  String getUid() {
    return this.uid!;
  }
}
