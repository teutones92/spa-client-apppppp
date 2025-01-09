import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/db_chat_service/db_chat_service.dart';
import 'package:spa_client_app/domain/service/db_services/user_related_services/db_user_service/db_user_service.dart';
import 'package:spa_client_app/models/server/chat_model/chat_model.dart';
import 'package:spa_client_app/models/server/user_models/user_data_model/user_data.dart';


class ChatState {
  final bool isLoading;
  final ChatModel? chatModel;
  final List<ServerUserData> onLineUsers;
  final List<ServerUserData> offLineUsers;
  final ServerUserData? currentUser;
  final List<ChatModel> chatList;

  ChatState({
    this.isLoading = false,
    this.chatModel,
    required this.onLineUsers,
    required this.offLineUsers,
    this.currentUser,
    this.chatList = const [],
  });

  ChatState copyWith({
    bool? isLoading,
    ChatModel? chatModel,
    List<ServerUserData>? onLineUsers,
    List<ServerUserData>? offLineUsers,
    ServerUserData? currentUser,
    List<ChatModel>? chatList,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      chatModel: chatModel ?? this.chatModel,
      onLineUsers: onLineUsers ?? this.onLineUsers,
      offLineUsers: offLineUsers ?? this.offLineUsers,
      currentUser: currentUser ?? this.currentUser,
      chatList: chatList ?? this.chatList,
    );
  }
}

class ChatBloc extends Cubit<ChatState> {
  ChatBloc() : super(ChatState(onLineUsers: [], offLineUsers: []));

  /// A controller for an editable text field, used to handle the input and
  /// manage the state of the message being typed by the user in the chat.
  TextEditingController messageController = TextEditingController();

  /// Fetches all users from the database and categorizes them into online and offline users,
  /// excluding the current user. The results are then emitted to update the state.
  ///
  /// This method performs the following steps:
  /// 1. Initializes empty lists for online and offline users.
  /// 2. Retrieves the current user's UID.
  /// 3. Fetches all user data from the database.
  /// 4. Iterates through the fetched user data and categorizes users based on their online status,
  ///    excluding the current user.
  /// 5. Emits the updated state with the categorized online and offline users.
  ///
  /// Note: This method assumes that the user data contains an `isOnline` property to determine
  /// the user's online status and a `uid` property to identify the user.
  void getUsers() async {
    final List<ServerUserData> onLineUsers = [];
    final List<ServerUserData> offLineUsers = [];
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    final resp = await DbUserService.readAllUserData();
    for (var element in resp) {
      if (element.isOnline && element.uid != currentUser) {
        onLineUsers.add(element);
      } else if (!element.isOnline && element.uid != currentUser) {
        offLineUsers.add(element);
      }
    }
    emit(state.copyWith(
        isLoading: false,
        onLineUsers: onLineUsers,
        offLineUsers: offLineUsers));
  }

  /// A Timer object used to debounce user input or actions.
  /// This helps to limit the rate at which a function is executed,
  /// ensuring that it only runs after a specified duration has passed
  /// since the last time it was invoked.
  Timer? _debounce;

  /// Searches for users based on the provided search value.
  ///
  /// This function filters the list of online and offline users based on the
  /// provided search value. It uses a debounce mechanism to limit the number
  /// of search operations performed, improving performance and user experience.
  ///
  /// If the search value is empty, it calls `getUsers` to reset the user lists.
  /// Otherwise, it filters the users whose names contain the search value,
  /// excluding the current user.
  ///
  /// The function updates the state with the filtered lists of online and
  /// offline users.
  ///
  /// Parameters:
  /// - `value`: The search value used to filter the users.
  void searchUser(String value) {
    emit(state.copyWith(isLoading: true));
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    if (value.isEmpty) {
      getUsers();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final List<ServerUserData> onLineUsers = [];
      final List<ServerUserData> offLineUsers = [];
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      final resp = state.onLineUsers + state.offLineUsers;
      for (var element in resp) {
        if (element.name.toLowerCase().contains(value.toLowerCase()) &&
            element.uid != currentUser) {
          if (element.isOnline) {
            onLineUsers.add(element);
          } else {
            offLineUsers.add(element);
          }
        }
      }
      emit(state.copyWith(
          isLoading: false,
          onLineUsers: onLineUsers,
          offLineUsers: offLineUsers));
    });
  }

  /// Opens a chat with the selected user.
  ///
  /// This method sets the current user in the state to the selected user and navigates
  /// to the chat view screen.
  ///
  /// Parameters:
  /// - [user]: The [ServerUserData] of the selected user to open a chat with.
  /// - [context]: The [BuildContext] used to navigate to the chat view screen.
  ///
  /// Note: Ensure that the [user] is not null before calling this method.
  void openChat(ServerUserData user, BuildContext context) {
    // Open chat with the user
    emit(state.copyWith(currentUser: user));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ChatView(),
    //   ),
    // );
  }

  /// Loads messages from the database and filters them based on the current user and the other user.
  ///
  /// This method listens to the stream of messages from the database and processes the messages
  /// to filter out only those that are between the current user and the other user. The filtered
  /// messages are then sorted by time in descending order and emitted to update the state.
  ///
  /// Returns a [Stream] of [QuerySnapshot] containing the messages.
  ///
  /// The messages are filtered based on the following conditions:
  /// - The sender ID is the current user's ID and the receiver ID is the other user's ID.
  /// - The sender ID is the other user's ID and the receiver ID is the current user's ID.
  ///
  /// The filtered messages are then sorted by the message time in descending order.
  Stream<QuerySnapshot<Map<String, dynamic>>> loadMessages() {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final otherUserId = state.currentUser!.uid;
    final snap = DbChatService.getMessages();
    snap.listen(
      (snapshot) {
        final messages = snapshot.docs.map((doc) {
          return ChatModel.fromJson(doc.data(), doc.id);
        }).toList();
        final chatList = messages
            .where((element) =>
                (element.senderId == currentUserId &&
                    element.receiverId == otherUserId) ||
                (element.senderId == otherUserId &&
                    element.receiverId == currentUserId))
            .toList();
        chatList.sort((a, b) => b.time.compareTo(a.time));
        emit(state.copyWith(chatList: chatList));
      },
    );
    return snap;
  }

  /// Sends a message to the chat.
  ///
  /// This method checks if the message input field is empty. If it is not empty,
  /// it retrieves the current user's ID and the other user's ID from the state.
  /// It then creates a `ChatModel` object with the sender's ID, receiver's ID,
  /// message content, and the current time. The message is then sent using the
  /// `DbChatService.sendMessage` method. Finally, the message input field is cleared.
  ///
  /// Note: This method is asynchronous.
  void sendMessage() async {
    if (messageController.text.isEmpty) return;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final otherUserId = state.currentUser!.uid;
    final message = messageController.text;
    final time = DateTime.now();
    final chatModel = ChatModel(
      senderId: userId,
      receiverId: otherUserId!,
      message: message,
      time: time,
    );
    await DbChatService.sendMessage(chatModel);
    messageController.clear();
  }

  /// Deletes a message from the chat list.
  ///
  /// This method calls the `DbChatService.deleteMessage` function, passing the
  /// message's unique identifier (`id`) to delete the message from the database.
  ///
  /// Parameters:
  /// - [message]: The [ChatModel] message to be deleted.
  ///  If the message's `id` is null, the method will return without performing any action.
  ///  Otherwise, the message will be deleted from the database.
  ///  Note: Ensure that the message's `id` is not null before calling this method.
  void deleteMessage(ChatModel message) {
    if (message.id == null) return;
    DbChatService.deleteMessage(message.id!);
  }

  /// Deletes all messages by the current user's ID.
  ///
  /// This method calls the `DbChatService.deleteAllMessageByUserId` function,
  /// passing the current user's unique identifier (`uid`) to delete all messages
  /// associated with that user.
  ///
  /// Note: Ensure that `state.currentUser` is not null and has a valid `uid`
  /// before calling this method.
  void deleteAllMessageByUserId() =>
      DbChatService.deleteAllMessageByUserId(state.currentUser!.uid!);

  /// Selects or deselects a message in the chat list based on the provided message and the type of press.
  ///
  /// If [isLongPress] is true, the message's selection state will be toggled (selected if it was not, and deselected if it was).
  /// If [isLongPress] is false, the message will be deselected.
  ///
  /// The method updates the state with the modified chat list.
  ///
  /// Parameters:
  /// - [message]: The [ChatModel] message to be selected or deselected.
  /// - [isLongPress]: A boolean indicating whether the selection is triggered by a long press (default is true).
  void selectMessage(ChatModel message, {bool isLongPress = true}) {
    if (isLongPress) {
      final chatList = state.chatList.map((e) {
        if (e.id == message.id) {
          return e.copyWith(selected: !e.selected);
        }
        return e;
      }).toList();
      emit(state.copyWith(chatList: chatList));
      return;
    } else {
      final chatList = state.chatList.map((e) {
        if (e.id == message.id) {
          return e.copyWith(selected: false);
        }
        return e;
      }).toList();
      emit(state.copyWith(chatList: chatList));
    }
  }
}
