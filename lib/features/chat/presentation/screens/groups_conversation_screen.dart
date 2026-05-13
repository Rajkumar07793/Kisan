import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';
import 'package:kisan_app/features/chat/presentation/bloc/groups_chat_bloc/groups_chat_bloc.dart';

import '../bloc/groups_chat_bloc/groups_chat_event.dart';
import '../bloc/groups_chat_bloc/groups_chat_state.dart';

class GroupsConversationScreen extends StatefulWidget {
  const GroupsConversationScreen({super.key});

  @override
  State<GroupsConversationScreen> createState() =>
      _GroupsConversationScreenState();
}

class _GroupsConversationScreenState extends State<GroupsConversationScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> suggestedMessagesList = [
    "Yes, that works!",
    "I'll be there",
    "Could you do 4 PM?",
  ];

  List<String> imagesList = [
    AppAssets.userProfile,
    AppAssets.elenaProfile,
    AppAssets.userProfile,
    AppAssets.userProfile,
    AppAssets.elenaProfile,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showCircleAvtar: false,
        actions: [
          Image.asset(
            AppAssets.groupsIcon,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          ),
          10.width,
        ],
        titleWidget: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (
                  int i = 0;
                  i < (imagesList.length > 3 ? 3 : imagesList.length);
                  i++
                )
                  Align(
                    widthFactor: 0.5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(imagesList[i]),
                        ),

                        if (i == 2 && imagesList.length > 3)
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "+${imagesList.length - 2}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            20.width,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bali Solo Seekers",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  3.height,
                  Text(
                    "14 ACTIVE MEMBERS",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.color5A5C5C99,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        title: "",
        showBackButton: false,
      ),

      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            reverse: true,
            slivers: [
              BlocBuilder<GroupsChatBloc, GroupsChatState>(
                builder: (context, state) {
                  return SliverPadding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 160),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final message =
                            state.messages[state.messages.length - 1 - index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: message.isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (!message.isMe)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundImage: AssetImage(
                                      AppAssets.userProfile,
                                    ),
                                  ),
                                ),

                              Flexible(
                                child: Column(
                                  crossAxisAlignment: message.isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: message.isMe
                                            ? AppColors.primary
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(
                                            message.isMe ? 20 : 0,
                                          ),
                                          bottomRight: Radius.circular(
                                            message.isMe ? 0 : 20,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        message.text,
                                        style: TextStyle(
                                          color: message.isMe
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _formatTime(message.time),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          if (message.isMe) ...[
                                            SizedBox(width: 4),
                                            Icon(
                                              Icons.done_all,
                                              size: 14,
                                              color: AppColors.primary,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: state.messages.length),
                    ),
                  );
                },
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.color351685.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              height: 38,
                              width: 38,
                              fit: BoxFit.contain,
                              AppAssets.emailIcon,
                            ),
                            15.width,
                            Expanded(
                              child: Text(
                                """Check your spam folder! Email notifications for new matches and messages sometimes end up there. Mark them as "not spam" so you don't miss anything.""",
                                style: context.textTheme.displayMedium
                                    ?.copyWith(
                                      color: AppColors.color351685.withValues(
                                        alpha: 0.50,
                                      ),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      4.height,
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.colorF0F1F1,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Text(
                            "TODAY",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.color5A5C5C,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Image.asset(
                        AppAssets.addButto,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    10.width,

                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          hintText: "Write a message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    10.width,

                    GestureDetector(
                      onTap: () {
                        if (_messageController.text.trim().isEmpty) return;

                        context.read<GroupsChatBloc>().add(
                          SendGroupsMessageEvent(
                            _messageController.text.trim(),
                          ),
                        );

                        _messageController.clear();

                        Future.delayed(Duration(milliseconds: 100), () {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          AppAssets.shareButto,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTime(DateTime time) {
  final hour = time.hour == 0
      ? 12
      : time.hour > 12
      ? time.hour - 12
      : time.hour;

  final minute = time.minute.toString().padLeft(2, '0');
  final ampm = time.hour >= 12 ? 'PM' : 'AM';

  return "$hour:$minute $ampm";
}

class Message {
  final String text;
  final DateTime time;
  final bool isMe;

  Message({required this.text, required this.time, required this.isMe});
}
