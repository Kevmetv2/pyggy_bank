import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pyggybank/models/card_model.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/message_model.dart';
import 'package:pyggybank/models/request_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';

class FirebaseProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  User user;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<bool> authenticateQR(gid, uid) async {
    final QuerySnapshot result = await _firestore
        .collection("group_members")
        .where("members", isEqualTo: uid)
        .getDocuments();
    final QuerySnapshot gresult = await _firestore
        .collection("groups")
        .where("groupId", isEqualTo: gid)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    final List<DocumentSnapshot> docs2 = gresult.documents;
    if (docs.length == 1 && docs2.length == 1) {
      return true;
    } else {
      return false;
    }
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
    user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      displayName: currentUser.displayName,
      photoUrl: currentUser.photoUrl,
    );

    return _firestore
        .collection("users")
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> addtoGroup(gid, uid) {
    return _firestore
        .collection("group_members")
        .document(gid)
        .collection("members")
        .document(uid)
        .setData({});
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
      if (s.exists) {
        friendsList.add(User.fromMap(s.data));
      }
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
      if (s.exists) groupsList.add(Group.fromMap(s.data));
    }

    return groupsList;
  }

  Future<List<TransactionM>> fetchAllTransactionsGroup(String groupID) async {
    List<TransactionM> transactionsList = List<TransactionM>();
    final transactionRef = Firestore.instance.collection('transactions');
    QuerySnapshot querySnapshot = await _firestore
        .collection("group_transactions")
        .document(groupID)
        .collection("trans")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s = await transactionRef
          .document(querySnapshot.documents[i].documentID)
          .get();
      if (s.exists) transactionsList.add(TransactionM.fromMap(s.data));
    }
    return transactionsList;
  }

  Future<List<User>> fetchAllMembersGroup(String groupID) async {
    List<User> usersList = List<User>();
    final usersRef = Firestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _firestore
        .collection("group_members")
        .document(groupID)
        .collection("members")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s =
          await usersRef.document(querySnapshot.documents[i].documentID).get();
      if (s.exists) {
        usersList.add(User.fromMap(s.data));
      }
    }
    return usersList;
  }

  Future<List<Request>> fetchAllUserRequests(String uid) async {
    List<Request> requestsList = List<Request>();
    final usersRef = Firestore.instance.collection('requests');
    QuerySnapshot querySnapshot = await _firestore
        .collection("user_money_requests")
        .document(uid)
        .collection("requests")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s =
          await usersRef.document(querySnapshot.documents[i].documentID).get();
      requestsList.add(Request.fromMap(s.data));
    }

    return requestsList;
  }

  Future<void> addMoneyToGroup(String groupId, var amount) async {
    final groupsRef = Firestore.instance.collection('groups');
    DocumentSnapshot s = await groupsRef.document(groupId).get();
    Group n = new Group.fromMap(s.data);
    n.balance += amount;
    groupsRef.document(groupId).setData(n.toMap(n));
  }

  Future<void> createTransaction(
      TransactionM transaction, String groupId) async {
    final groupsRef = Firestore.instance.collection('transactions');
    final group_transactions_ref = Firestore.instance
        .collection('group_transactions')
        .document(groupId)
        .collection('trans');

    var documentId = await groupsRef.add(transaction.toMap(transaction));
    var s = documentId.documentID;
    print(documentId.documentID);
    await group_transactions_ref.document(s).setData({});
  }

//  Future<void> addCardtodb(cardNo, holder, ccv_, expiry,uid) async{
//    final cardsRef = _firestore.collection("cards");
//    final user_cards_ref =  _firestore.collection("user_cards").document(uid).collection("cards");
//    try {
//      card_bank card = new card_bank(
//          cardnumber: cardNo,
//          ccv: ccv,
//          expiration: expiry,
//          cardholder: holder
//      );
//
//
//      var documentId = await cardsRef.add(card.toMap(card));
//      var s = documentId.documentID;
//      await user_cards_ref.document(s).setData({});
//    }catch(e){
//      print(e);
//    }
//  }
  Future<List<Cards>> getGroupCard(String groupId) async {
    List<Cards> messagesList = List<Cards>();
    final messagesRef = Firestore.instance.collection('cards');
    QuerySnapshot querySnapshot = await _firestore
        .collection("group_cards")
        .document(groupId)
        .collection("card")
        .getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s = await messagesRef
          .document(querySnapshot.documents[i].documentID)
          .get();
      if (s.exists) messagesList.add(Cards.fromMap(s.data));
    }
    return messagesList;
  }

  Future<List<Message>> fetchAllMessagesGroup(String groupID) async {
    List<Message> messagesList = List<Message>();
    final messagesRef = Firestore.instance.collection('messages');
    QuerySnapshot querySnapshot = await _firestore
        .collection("group_messages")
        .document(groupID)
        .collection("messages")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s = await messagesRef
          .document(querySnapshot.documents[i].documentID)
          .get();
      if (s.exists) messagesList.add(Message.fromMap(s.data));
    }
    return messagesList;
  }

  Future<List<Message>> fetchAllFriendMessages(String crossID) async {
    List<Message> messagesList = List<Message>();
    print(crossID);
    final messagesRef = Firestore.instance.collection('messages');
    QuerySnapshot querySnapshot = await _firestore
        .collection("user_friends_messages")
        .document(crossID)
        .collection("messages")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      DocumentSnapshot s = await messagesRef
          .document(querySnapshot.documents[i].documentID)
          .get();
      if (s.exists) {
        messagesList.add(Message.fromMap(s.data));
      }
    }
    return messagesList;
  }

  Future<String> groupNameById(String groupID) async {
    final groupsRef = Firestore.instance.collection('groups');
    DocumentSnapshot s = await groupsRef.document(groupID).get();
    Group sp = Group.fromMap(s.data);
    return sp.name;
  }

  Future<Group> groupById(String groupID) async {
    final groupsRef = Firestore.instance.collection('groups');
    DocumentSnapshot s = await groupsRef.document(groupID).get();
    Group sp = Group.fromMap(s.data);
    return sp;
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
      if (s.exists) groupsList.add(Group.fromMap(s.data));
    }

    return groupsList;
  }
}
