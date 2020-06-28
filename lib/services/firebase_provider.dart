import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/user.dart';

class FirebaseProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  User user;
//  Post post;
//  Like like;
//  Message _message;
//  Comment comment;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
//  StorageReference _storageReference;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    print("Inside authenticateUser");
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    if (docs.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
//    print("Inside addDataToDb Method");
//
//    _firestore
//        .collection("display_names")
//        .document(currentUser.displayName)
//        .setData({'displayName': currentUser.displayName});

    user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      displayName: currentUser.displayName,
      photoUrl: currentUser.photoUrl,
    );

    //  Map<String, String> mapdata = Map<String, dynamic>();

    //  mapdata = user.toMap(user);

    return _firestore
        .collection("users")
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> signUpUser(context, name, email, password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser currentUser = authResult.user;
      if (currentUser != null) {
        user = User(
          uid: currentUser.uid,
          email: currentUser.email,
          displayName: name,
          photoUrl: currentUser.photoUrl,
        );
        return _firestore
            .collection("users")
            .document(currentUser.uid)
            .setData(user.toMap(user));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<FirebaseUser> signInEmail(email, password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult != null) {
        FirebaseUser user = authResult.user;
        addDataToDb(user);
        return user;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  Future<User> fetchUserDetailsById(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").document(uid).get();
    return User.fromMap(documentSnapshot.data);
  }

  Future<List<User>> fetchAllUserFriends(String uid) async {
    List<User> friendsList = List<User>();
    final userRef = Firestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _firestore
        .collection("user_friends")
        .document(uid)
        .collection("friends")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s =
          await userRef.document(querySnapshot.documents[i].documentID).get();
      friendsList.add(User.fromMap(s.data));
    }

    return friendsList;
  }

  Future<List<Group>> fetchAllUserFavGroups(String uid) async {
    List<Group> groupsList = List<Group>();
    final groupsRef = Firestore.instance.collection('groups');
    QuerySnapshot querySnapshot = await _firestore
        .collection("user_groups_fav")
        .document(uid)
        .collection("favorites")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s =
          await groupsRef.document(querySnapshot.documents[i].documentID).get();

      groupsList.add(Group.fromMap(s.data));
    }

    return groupsList;
  }

  Future<List<Group>> fetchAllUserGroups(String uid) async {
    List<Group> groupsList = List<Group>();
    final groupsRef = Firestore.instance.collection('groups');
    QuerySnapshot querySnapshot = await _firestore
        .collection("user_groups")
        .document(uid)
        .collection("user_group_relation")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s =
          await groupsRef.document(querySnapshot.documents[i].documentID).get();
      groupsList.add(Group.fromMap(s.data));
    }

    return groupsList;
  }
}
