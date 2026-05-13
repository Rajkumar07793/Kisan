import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';

import '../bloc/chat_bloc/chat_bloc.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> suggestedMessagesList = [
    "Yes, that works!",
    "I'll be there",
    "Could you do 4 PM?",
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(AppAssets.userProfile),
                ),
                Positioned(
                  right: -4,
                  bottom: 4,
                  child: Image.asset(
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                    AppAssets.verifiedIcon,
                  ),
                ),
              ],
            ),
            10.width,

            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Amara Singh",
            //         style: context.textTheme.titleLarge?.copyWith(
            //           color: AppColors.primary,
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       2.height,
            //       Row(
            //         children: [
            //           CircleAvatar(radius: 4, backgroundColor: Colors.green),
            //           8.width,
            //           Text(
            //             "VERIFIED TRAVELER",
            //             style: context.textTheme.titleLarge?.copyWith(
            //               color: AppColors.color5A5C5C,
            //               fontSize: 10,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Text(
              "Amara Singh",
              style: context.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
              BlocBuilder<ChatBloc, ChatState>(
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
                      // Container(
                      //   padding: EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.color351685.withValues(alpha: 0.05),
                      //     borderRadius: BorderRadius.circular(15),
                      //   ),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Image.asset(
                      //         height: 38,
                      //         width: 38,
                      //         fit: BoxFit.contain,
                      //         AppAssets.privacyIcon,
                      //       ),
                      //       15.width,
                      //       Expanded(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               "Keep it Safe",
                      //               style: context.textTheme.headlineLarge
                      //                   ?.copyWith(
                      //                     color: AppColors.color351685,
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w600,
                      //                   ),
                      //             ),
                      //             5.height,
                      //             Text(
                      //               """Check your spam folder! Email notifications for new matches and messages sometimes end up there. Mark them as "not spam" so you don't miss anything.""",
                      //               style: context.textTheme.displayMedium
                      //                   ?.copyWith(
                      //                     color: AppColors.color351685
                      //                         .withValues(alpha: 0.50),
                      //                     fontSize: 13,
                      //                     fontWeight: FontWeight.w400,
                      //                   ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                // SizedBox(
                //   height: 35,
                //   child: ListView.separated(
                //     separatorBuilder: (context, index) => SizedBox(width: 5,),
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemCount: suggestedMessagesList.length,
                //     itemBuilder: (context, index) {
                //     return GestureDetector(
                //       onTap: (){
                //         context.read<ChatBloc>().add(
                //           SendMessageEvent(suggestedMessagesList[index]),
                //         );
                //       },
                //       child: Container(
                //         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                //         decoration: BoxDecoration(
                //             color: AppColors.primary.withValues(alpha: 0.05),
                //             borderRadius: BorderRadius.all(Radius.circular(30))
                //         ),
                //         child: Text(
                //             suggestedMessagesList[index],
                //           style: TextStyle(
                //               fontSize: 12,
                //               fontWeight: FontWeight.w500,
                //               color: AppColors.primary
                //           ),
                //         ),
                //       ),
                //     );
                //   },),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15),
                      //   child: Image.asset(AppAssets.addButto, height: 50, width: 50),
                      // ),
                      // 10.width,
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.color5A5C5C.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              borderSide: BorderSide(
                                width: 0.2,
                                color: AppColors.color5A5C5C.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                            ),
                            fillColor: AppColors.colorF0F1F1,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            hintText: "Write a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          if (_messageController.text.trim().isEmpty) return;

                          context.read<ChatBloc>().add(
                            SendMessageEvent(_messageController.text.trim()),
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
