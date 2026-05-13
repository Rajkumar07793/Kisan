import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<Map<String, dynamic>> userList = [
    {
      "imageUrl": "assets/images/elenaProfile.png",
      "title": "Kelsey",
      "date": "Today",
      "subtitle": "Does anyone know i am Going",
    },
    {
      "imageUrl": "assets/images/elenaProfile.png",
      "title": "Amara Singh",
      "date": "Today",
      "subtitle": "Does anyone know i am Going",
    },
    {
      "imageUrl": "assets/images/elenaProfile.png",
      "title": "Kelsey",
      "date": "Today",
      "subtitle": "Does anyone know i am Going",
    },
    {
      "imageUrl": "assets/images/elenaProfile.png",
      "title": "Amara Singh",
      "date": "Today",
      "subtitle": "Does anyone know i am Going",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // title: context.l10n.navMyTrip,
        showBackButton: false,
        showCircleAvtar: true,
        avatarOnRight: true,
        onAvatarTap: () => StatefulNavigationShell.of(context).goBranch(4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(userList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      context.push(AppRouter.conversation);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            offset: Offset(0, 4),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                  AppAssets.userProfile,
                                ),
                              ),
                              Positioned(
                                right: -6,
                                bottom: 5,
                                child: Image.asset(
                                  height: 22,
                                  width: 22,
                                  fit: BoxFit.contain,
                                  AppAssets.groupIcon,
                                ),
                              ),
                            ],
                          ),
                          15.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        userList[index]['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.textTheme.titleMedium,
                                        // ?.copyWith(
                                        //   color: AppColors.color2D2F2F,
                                        //   fontWeight: FontWeight.w500,
                                        //   fontSize: 18,
                                        // )
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    Text(
                                      userList[index]['date'],
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: AppColors.color64748B
                                                .withValues(alpha: 0.6),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                                4.heightBox,
                                Text(
                                  maxLines: 1,
                                  userList[index]['subtitle'],
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.color64748B.withValues(
                                      alpha: 0.6,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headingText(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.headlineLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.color2D2F2F,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
