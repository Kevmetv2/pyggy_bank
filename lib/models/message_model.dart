import 'package:pyggybank/models/user.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

//// YOU - current user
//final User currentUser = User(
//  uid: "user id",
//  displayName: 'Current User',
//  photoUrl: 'https://i.pravatar.cc/150?img=3',
//);
//
//// USERS
//final User greg = User(
//  uid: "user id2",
//  displayName: 'Dancing Lessons',
//  photoUrl: 'https://i.pravatar.cc/150?img=4',
//);
//final User james = User(
//  uid: "user id3",
//  displayName: 'Gym equipment',
//  photoUrl: 'https://i.pravatar.cc/150?img=5',
//);
//final User john = User(
//  uid: "user id4",
//  displayName: 'Sunnyvale Tennis Club',
//  photoUrl: 'https://i.pravatar.cc/150?img=6',
//);
//final User olivia = User(
//  uid: "user id5",
//  displayName: 'Vacation- Italy',
//  photoUrl: 'https://i.pravatar.cc/150?img=7',
//);
//final User sam = User(
//  uid: "user id6",
//  displayName: 'Savings',
//  photoUrl: 'https://i.pravatar.cc/150?img=8',
//);
//final User sophia = User(
//  uid: "user id7",
//  displayName: 'UCB Film club',
//  photoUrl: 'https://i.pravatar.cc/150?img=9',
//);
//final User steven = User(
//  uid: "user id8",
//  displayName: 'San Jose - Soup Kitchen',
//  photoUrl: 'https://i.pravatar.cc/150?img=10',
//);

// FAVORITE CONTACTS
//List<User> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
//List<Message> chats = [
//  Message(
//    sender: james,
//    time: '5:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: true,
//  ),
//  Message(
//    sender: olivia,
//    time: '4:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: true,
//  ),
//  Message(
//    sender: john,
//    time: '3:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: false,
//  ),
//  Message(
//    sender: sophia,
//    time: '2:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: true,
//  ),
//  Message(
//    sender: steven,
//    time: '1:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: false,
//  ),
//  Message(
//    sender: sam,
//    time: '12:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: false,
//  ),
//  Message(
//    sender: greg,
//    time: '11:30 AM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: false,
//    unread: false,
//  ),
//];

// EXAMPLE MESSAGES IN CHAT SCREEN
//List<Message> messages = [
//  Message(
//    sender: james,
//    time: '5:30 PM',
//    text: 'Hey, how\'s it going? What did you do today?',
//    isLiked: true,
//    unread: true,
//  ),
//  Message(
//    sender: currentUser,
//    time: '4:30 PM',
//    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
//    isLiked: false,
//    unread: true,
//  ),
//  Message(
//    sender: james,
//    time: '3:45 PM',
//    text: 'How\'s the doggo?',
//    isLiked: false,
//    unread: true,
//  ),
//  Message(
//    sender: james,
//    time: '3:15 PM',
//    text: 'All the food',
//    isLiked: true,
//    unread: true,
//  ),
//  Message(
//    sender: currentUser,
//    time: '2:30 PM',
//    text: 'Nice! What kind of food did you eat?',
//    isLiked: false,
//    unread: true,
//  ),
//  Message(
//    sender: james,
//    time: '2:00 PM',
//    text: 'I ate so much food today.',
//    isLiked: false,
//    unread: true,
//  ),
//];
