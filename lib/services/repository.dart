import 'package:firebase_auth/firebase_auth.dart';
import 'package:pyggybank/models/card_bank_model.dart';
import 'package:pyggybank/models/card_model.dart';
import 'package:pyggybank/models/group_model.dart';
import 'package:pyggybank/models/message_model.dart';
import 'package:pyggybank/models/request_model.dart';
import 'package:pyggybank/models/transaction_model.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/firebase_provider.dart';

class Repository {
  final _firebaseProvider = FirebaseProvider();

  Future<FirebaseUser> getCurrentUser() => _firebaseProvider.getCurrentUser();

  Future<void> signOut() => _firebaseProvider.signOut();

  Future<FirebaseUser> signIn() => _firebaseProvider.signIn();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseProvider.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser user) =>
      _firebaseProvider.addDataToDb(user);
  Future<void> addtoGroup(String gid, String uid) =>
      _firebaseProvider.addtoGroup(gid, uid);

  Future<void> addCardtoDb(cardNo, holder, ccv_, expiry, uid) =>
      _firebaseProvider.addCardtodb(cardNo, holder, ccv_, expiry, uid);

  Future<void> signUpUser(context, name, email, password) =>
      _firebaseProvider.signUpUser(context, name, email, password);

  Future<FirebaseUser> signInEmail(email, password) =>
      _firebaseProvider.signInEmail(email, password);

  Future<User> fetchUserDetailsById(String uid) =>
      _firebaseProvider.fetchUserDetailsById(uid);

  Future<Group> getGroupInfo(String gid) => _firebaseProvider.getGroupInfo(gid);

  Future<List<User>> fetchAllUserFriends(String uid) =>
      _firebaseProvider.fetchAllUserFriends(uid);

  Future<List<Group>> fetchAllUserFavGroups(String uid) =>
      _firebaseProvider.fetchAllUserFavGroups(uid);

  Future<String> groupNameById(String groupId) =>
      _firebaseProvider.groupNameById(groupId);

  Future<Group> groupById(String groupId) =>
      _firebaseProvider.groupById(groupId);

  Future<void> createTransaction(TransactionM transaction, String groupID) =>
      _firebaseProvider.createTransaction(transaction, groupID);

  Future<List<Cards>> getGroupCard(String groupId) =>
      _firebaseProvider.getGroupCard(groupId);

  Future<List<TransactionM>> fetchAllTransactionsGroup(String groupID) =>
      _firebaseProvider.fetchAllTransactionsGroup(groupID);

  Future<List<User>> fetchAllMembersGroup(String groupID) =>
      _firebaseProvider.fetchAllMembersGroup(groupID);

  Future<List<Message>> fetchAllMessagesGroup(String groupID) =>
      _firebaseProvider.fetchAllMessagesGroup(groupID);

  Future<List<Message>> fetchAllFriendMessages(String crossID) =>
      _firebaseProvider.fetchAllFriendMessages(crossID);

  Future<List<Request>> fetchAllUserRequests(String uid) =>
      _firebaseProvider.fetchAllUserRequests(uid);

  Future<void> addMoneyToGroup(String groupId, var amount) =>
      _firebaseProvider.addMoneyToGroup(groupId, amount);

  Future<List<Group>> fetchAllUserGroups(String uid) =>
      _firebaseProvider.fetchAllUserGroups(uid);
  Future<bool> authenticateGroup(String gid, String uid) =>
      _firebaseProvider.authenticateQR(gid, uid);

  Future<List<card_bank>> fetchCard(String uid) =>
      _firebaseProvider.fetchCard(uid);
}
