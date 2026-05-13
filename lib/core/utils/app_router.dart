import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:kisan_app/features/auth/presentation/screens/login_screen.dart';
import 'package:kisan_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:kisan_app/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:kisan_app/features/chat/presentation/screens/conversation_screen.dart';
import 'package:kisan_app/features/chat/presentation/screens/groups_conversation_screen.dart';
import 'package:kisan_app/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:kisan_app/features/profile/presentation/screens/change_password_screen.dart';
import 'package:kisan_app/features/profile/presentation/screens/contact_us_screen.dart';
import 'package:kisan_app/features/profile/presentation/screens/faqs_screen.dart';
import 'package:kisan_app/features/profile/presentation/screens/legal_text_screen.dart';
import 'package:kisan_app/features/profile/presentation/screens/settings_screen.dart';

class AppRouter {
  static const String root = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String search = '/search';
  static const String trips = '/trips';
  static const String chat = '/chat';
  static const String profile = '/profile';
  // static const String tripDetails = '/trip-details';
  static const String settings = '/settings';
  static const String reviewBooking = '/review-booking';
  static const String bookingSuccess = '/booking-success';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String verifyEmailScreen = '/verify-email';
  static const String tripDetails = '/new-trip-details';
  static const String editProfile = '/edit-profile';
  static const String filterMatches = '/filter-matches';
  static const String myMatches = '/my-matches';
  static const String travelerProfile = '/traveler-profile';
  static const String helpAndSupport = '/help-support';
  static const String faqs = '/faqs';
  static const String contactUs = '/contact-us';
  static const String changePassword = '/change-password';
  static const String filter = '/filter';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsOfService = '/terms-of-service';
  static const String conversation = '/conversations';
  static const String groupsConversation = '/groups-conversations';
  static const String communityGuidelines = '/community-guidelines';
  static const String allTrips = '/all-trips';

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: root,
    routes: [
      GoRoute(path: root, builder: (context, state) => const SplashScreen()),
      // GoRoute(
      //   path: onboarding,
      //   builder: (context, state) => const OnboardingScreen(),
      // ),
      GoRoute(
        path: login,
        name: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        name: signup,
        builder: (context, state) => const SignUpScreen(),
      ),

      // GoRoute(
      //   path: tripDetails,
      //   builder: (context, state) {
      //     final trip = state.extra is TripEntity
      //         ? state.extra as TripEntity
      //         : null;
      //     if (trip == null) {
      //       return const Scaffold(
      //         body: Center(child: Text("Invalid Trip Data")),
      //       );
      //     }
      //     return TripDetailsScreen(trip: trip);
      //   },
      // ),
      // GoRoute(path: filter, builder: (context, state) => const FilterScreen()),
      GoRoute(
        path: privacyPolicy,
        builder: (context, state) {
          return const LegalTextScreen(
            title: 'Privacy Policy',
            slug: 'privacyPolicy',
          );
        },
      ),
      GoRoute(
        path: termsOfService,
        builder: (context, state) {
          return const LegalTextScreen(
            title: 'Terms of Service',
            slug: 'termsAndConditions',
          );
        },
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
        path: forgotPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: verifyEmailScreen,
        name: verifyEmailScreen,
        builder: (context, state) {
          final email =
              (state.extra as String?) ??
              state.uri.queryParameters['email'] ??
              '';
          return VerifyEmailScreen(email: email);
        },
      ),

      GoRoute(
        path: conversation,
        builder: (context, state) => const ConversationScreen(),
      ),

      GoRoute(
        path: groupsConversation,
        builder: (context, state) => const GroupsConversationScreen(),
      ),

      GoRoute(path: faqs, builder: (context, state) => const FAQsScreen()),
      GoRoute(path: contactUs, builder: (context, state) => ContactUsScreen()),
      GoRoute(
        path: changePassword,
        builder: (context, state) {
          final isRecovery = state.extra as bool? ?? false;
          return ChangePasswordScreen(isRecovery: isRecovery);
        },
      ),
      GoRoute(
        path: communityGuidelines,
        builder: (context, state) {
          return const LegalTextScreen(
            title: 'Community Guidelines',
            slug: 'communityGuidelines',
          );
        },
      ),

      /*
      /// --- PERSISTENT BOTTOM NAV SHELL ---
      StatefulShellRoute.indexedStack(
        // builder: (context, state, navigationShell) {
        //   return MainScreen(navigationShell: navigationShell);
        // },
        branches: [
          // Branch 0: Home
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: home,
          //       builder: (context, state) => const HomeScreen(),
          //     ),
          //   ],
          // ),
          // // Branch 1: Search
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: search,
          //       builder: (context, state) => const SearchScreen(),
          //     ),
          //   ],
          // ),
          // // Branch 2: My Trip
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: trips,
          //       builder: (context, state) => const UserTripsScreen(),
          //     ),
          //   ],
          // ),
          // Branch 3: Chat
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: chat,
                builder: (context, state) => const ChatListScreen(),
              ),
            ],
          ),
          // Branch 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      */
    ],
  );
}
