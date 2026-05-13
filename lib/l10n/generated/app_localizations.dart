import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Kheti-Kisaani'**
  String get appTitle;

  /// Title for the home page
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get homePageTitle;

  /// Text showing the number of button presses
  ///
  /// In en, this message translates to:
  /// **'You have pushed the button this many times:'**
  String get counterText;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @signInToViewTrips.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your trades and listings'**
  String get signInToViewTrips;

  /// No description provided for @signInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Connect with fellow farmers and start your agricultural journey.'**
  String get signInPrompt;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// No description provided for @featuredTrips.
  ///
  /// In en, this message translates to:
  /// **'Featured Trips'**
  String get featuredTrips;

  /// No description provided for @ongoingTrips.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Trips'**
  String get ongoingTrips;

  /// No description provided for @upcomingTrips.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Trips'**
  String get upcomingTrips;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your trade journey'**
  String get signInSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @onboarding1Tagline.
  ///
  /// In en, this message translates to:
  /// **'WELCOME'**
  String get onboarding1Tagline;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Kheti-Kisaani'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In en, this message translates to:
  /// **'A better way for farmers to buy and sell produce.'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Tagline.
  ///
  /// In en, this message translates to:
  /// **'SAFETY FIRST'**
  String get onboarding2Tagline;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Your safety comes first'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In en, this message translates to:
  /// **'We encourage you to:\n• Meet matches in public first\n• Share plans with someone you trust\n• Trust your instincts'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Tagline.
  ///
  /// In en, this message translates to:
  /// **'BE REAL'**
  String get onboarding3Tagline;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Be yourself, honestly'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In en, this message translates to:
  /// **'Authentic profiles build trust and better matches.'**
  String get onboarding3Desc;

  /// No description provided for @onboarding4Tagline.
  ///
  /// In en, this message translates to:
  /// **'STAY IN CONTROL'**
  String get onboarding4Tagline;

  /// No description provided for @onboarding4Title.
  ///
  /// In en, this message translates to:
  /// **'You\'re always in control'**
  String get onboarding4Title;

  /// No description provided for @onboarding4Desc.
  ///
  /// In en, this message translates to:
  /// **'• Block or report anytime\n• Choose who you connect with\n• Share only what you\'re comfortable with'**
  String get onboarding4Desc;

  /// No description provided for @onboarding5Tagline.
  ///
  /// In en, this message translates to:
  /// **'COMMUNITY PROMISE'**
  String get onboarding5Tagline;

  /// No description provided for @onboarding5Title.
  ///
  /// In en, this message translates to:
  /// **'We\'re in this together.'**
  String get onboarding5Title;

  /// No description provided for @onboarding5Desc.
  ///
  /// In en, this message translates to:
  /// **'Kheti-Kisaani works because users look out for each other.'**
  String get onboarding5Desc;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createAccount;

  /// No description provided for @startYourCurated.
  ///
  /// In en, this message translates to:
  /// **'Start your curated marketplace experience.'**
  String get startYourCurated;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get nameHint;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @mobileNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get mobileNumberHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @whatInspiresYou.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for?'**
  String get whatInspiresYou;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'SEARCH'**
  String get navSearch;

  /// No description provided for @navMyTrip.
  ///
  /// In en, this message translates to:
  /// **'MY TRADES'**
  String get navMyTrip;

  /// No description provided for @activeTrips.
  ///
  /// In en, this message translates to:
  /// **'Active Trades'**
  String get activeTrips;

  /// No description provided for @pastTrips.
  ///
  /// In en, this message translates to:
  /// **'Past Trades'**
  String get pastTrips;

  /// No description provided for @navChat.
  ///
  /// In en, this message translates to:
  /// **'CHAT'**
  String get navChat;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get navProfile;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'SETTING'**
  String get setting;

  /// No description provided for @chatAction.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatAction;

  /// No description provided for @noInternetTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetTitle;

  /// No description provided for @noInternetDesc.
  ///
  /// In en, this message translates to:
  /// **'Please check your network settings and try again.'**
  String get noInternetDesc;

  /// No description provided for @noInternetButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get noInternetButton;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @myTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get myTripsTitle;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @versionText.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get versionText;

  /// No description provided for @aboutTrip.
  ///
  /// In en, this message translates to:
  /// **'About this trip'**
  String get aboutTrip;

  /// No description provided for @hostSection.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get hostSection;

  /// No description provided for @joinTripAction.
  ///
  /// In en, this message translates to:
  /// **'Join Trip'**
  String get joinTripAction;

  /// No description provided for @perPerson.
  ///
  /// In en, this message translates to:
  /// **'per person'**
  String get perPerson;

  /// No description provided for @chatInbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get chatInbox;

  /// No description provided for @noChatsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get noChatsYet;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeAMessage;

  /// No description provided for @onlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get onlineStatus;

  /// No description provided for @typing.
  ///
  /// In en, this message translates to:
  /// **'typing...'**
  String get typing;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @noTripsFound.
  ///
  /// In en, this message translates to:
  /// **'No trips found'**
  String get noTripsFound;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search crops, grains, tractors...'**
  String get searchPlaceholder;

  /// No description provided for @exploreDestinations.
  ///
  /// In en, this message translates to:
  /// **'Explore Marketplace'**
  String get exploreDestinations;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No matches found for your search'**
  String get noResultsFound;

  /// No description provided for @reviewBooking.
  ///
  /// In en, this message translates to:
  /// **'Review Booking'**
  String get reviewBooking;

  /// No description provided for @priceDetails.
  ///
  /// In en, this message translates to:
  /// **'Price Details'**
  String get priceDetails;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFee;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @bookingSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Booking Successful!'**
  String get bookingSuccessful;

  /// No description provided for @viewMyTrips.
  ///
  /// In en, this message translates to:
  /// **'View My Trips'**
  String get viewMyTrips;

  /// No description provided for @yourJourneyToSafe.
  ///
  /// In en, this message translates to:
  /// **'Your gateway to fair, '**
  String get yourJourneyToSafe;

  /// No description provided for @inspiredTravel.
  ///
  /// In en, this message translates to:
  /// **'profitable farming '**
  String get inspiredTravel;

  /// No description provided for @startsHere.
  ///
  /// In en, this message translates to:
  /// **'starts here.'**
  String get startsHere;

  /// No description provided for @pleaseEnterYourDetailsToContinueYourAdventure.
  ///
  /// In en, this message translates to:
  /// **'Please enter your details to continue your agricultural journey.'**
  String get pleaseEnterYourDetailsToContinueYourAdventure;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @forgotYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotYourPassword;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, it happens. Tell us your email and we\'ll send you a recovery link to get you back to your trades.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @continueToVerification.
  ///
  /// In en, this message translates to:
  /// **'Continue to Verification'**
  String get continueToVerification;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAnAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get logIn;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Grains'**
  String get nature;

  /// No description provided for @culture.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get culture;

  /// No description provided for @wellness.
  ///
  /// In en, this message translates to:
  /// **'Tractors'**
  String get wellness;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @weHaveSentDigitCodeTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to'**
  String get weHaveSentDigitCodeTo;

  /// No description provided for @toVerifyYourExplorerIdentity.
  ///
  /// In en, this message translates to:
  /// **'to verify your identity.'**
  String get toVerifyYourExplorerIdentity;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'RESEND CODE'**
  String get resendCode;

  /// No description provided for @soloEXPEDITION.
  ///
  /// In en, this message translates to:
  /// **'SOLO EXPEDITION'**
  String get soloEXPEDITION;

  /// No description provided for @theVenetianCuratedAlgarve.
  ///
  /// In en, this message translates to:
  /// **'The Venetian Curated Algarve'**
  String get theVenetianCuratedAlgarve;

  /// No description provided for @vaniceItaly.
  ///
  /// In en, this message translates to:
  /// **'Vanice, Italy'**
  String get vaniceItaly;

  /// No description provided for @septDate.
  ///
  /// In en, this message translates to:
  /// **'Sept 15 - Sep 20, 2024'**
  String get septDate;

  /// No description provided for @theJourney.
  ///
  /// In en, this message translates to:
  /// **'The Journey'**
  String get theJourney;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @theExperience.
  ///
  /// In en, this message translates to:
  /// **'The Experience'**
  String get theExperience;

  /// No description provided for @exploringTheHiddenGrottos.
  ///
  /// In en, this message translates to:
  /// **'Kheti-Kisaani is a platform dedicated to empowering farmers and traders by providing a direct marketplace for crops, grains, and agricultural equipment. Our mission is to ensure fair pricing and transparent transactions for the farming community.'**
  String get exploringTheHiddenGrottos;

  /// No description provided for @contactDetailsArePrivate.
  ///
  /// In en, this message translates to:
  /// **'CONTACT DETAILS ARE PRIVATE'**
  String get contactDetailsArePrivate;

  /// No description provided for @loginToMessage.
  ///
  /// In en, this message translates to:
  /// **'Login to Message'**
  String get loginToMessage;

  /// No description provided for @viewAllTrip.
  ///
  /// In en, this message translates to:
  /// **'VIEW ALL TRIP'**
  String get viewAllTrip;

  /// No description provided for @elenaR.
  ///
  /// In en, this message translates to:
  /// **'Elena R.'**
  String get elenaR;

  /// No description provided for @contactDetailsAreHiddenToProtectOurCommunityMembers.
  ///
  /// In en, this message translates to:
  /// **'Contact details are hidden to protect our community members.'**
  String get contactDetailsAreHiddenToProtectOurCommunityMembers;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @interestedUsers.
  ///
  /// In en, this message translates to:
  /// **'Interested Users'**
  String get interestedUsers;

  /// No description provided for @callHost.
  ///
  /// In en, this message translates to:
  /// **'Call Host'**
  String get callHost;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @loginToConnect.
  ///
  /// In en, this message translates to:
  /// **'Login to Connect'**
  String get loginToConnect;

  /// No description provided for @manageTrip.
  ///
  /// In en, this message translates to:
  /// **'Manage Trip'**
  String get manageTrip;

  /// No description provided for @thisIsYourTrip.
  ///
  /// In en, this message translates to:
  /// **'THIS IS YOUR TRIP'**
  String get thisIsYourTrip;

  /// No description provided for @yourTripBannerDesc.
  ///
  /// In en, this message translates to:
  /// **'You are viewing your own product listing. All inquiries from buyers will appear in your inbox.'**
  String get yourTripBannerDesc;

  /// No description provided for @hostContactInfo.
  ///
  /// In en, this message translates to:
  /// **'HOST CONTACT INFORMATION'**
  String get hostContactInfo;

  /// No description provided for @messageHost.
  ///
  /// In en, this message translates to:
  /// **'Message Host'**
  String get messageHost;

  /// No description provided for @organizerDesc.
  ///
  /// In en, this message translates to:
  /// **'You are the organizer of this journey.'**
  String get organizerDesc;

  /// No description provided for @hostVerifiedDesc.
  ///
  /// In en, this message translates to:
  /// **'Host verified by Kheti-Kisaani community for safe travel.'**
  String get hostVerifiedDesc;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqTitle;

  /// No description provided for @faq1Question.
  ///
  /// In en, this message translates to:
  /// **'Can a trip have more than two people?'**
  String get faq1Question;

  /// No description provided for @faq1Answer.
  ///
  /// In en, this message translates to:
  /// **'Yes. You can decide how may people can join the trip and find accommodations that match your needs.'**
  String get faq1Answer;

  /// No description provided for @faq2Question.
  ///
  /// In en, this message translates to:
  /// **'Who pays for the hotel/lodging?'**
  String get faq2Question;

  /// No description provided for @faq2Answer.
  ///
  /// In en, this message translates to:
  /// **'That is to be decided amongst yourselves. Currently, Kheti-Kisaani does not receive or manage any money from its users. It is highly recommended that you draw up a written agreement before making any payments. As stated in the terms and conditions Kheti-Kisaani is not liable for any payments or agreements and is only intended to connect users with similar travel lodging preferences.'**
  String get faq2Answer;

  /// No description provided for @faq3Question.
  ///
  /// In en, this message translates to:
  /// **'Can I bring my pet?'**
  String get faq3Question;

  /// No description provided for @faq3Answer.
  ///
  /// In en, this message translates to:
  /// **'That is completely up to you and your matches and your selected lodging. Please be sure to ask your trip matches if you intend to bring a pet and move accordingly.'**
  String get faq3Answer;

  /// No description provided for @faq4Question.
  ///
  /// In en, this message translates to:
  /// **'Will Kheti-Kisaani reimburse me if my match cancels or is a no-show?'**
  String get faq4Question;

  /// No description provided for @faq4Answer.
  ///
  /// In en, this message translates to:
  /// **'No. Kheti-Kisaani is not liable for any agreements made in or out of the app. We recommended using written agreements. You may use the app to connect with other users who may be interested in replacing your match/es.'**
  String get faq4Answer;

  /// No description provided for @faq5Question.
  ///
  /// In en, this message translates to:
  /// **'What if I cannot meet up with a match in person before agreeing to share a trip?'**
  String get faq5Question;

  /// No description provided for @faq5Answer.
  ///
  /// In en, this message translates to:
  /// **'That is a common scenario since many of you will live in different cities and states. We encourage you to meet via video call/meeting prior to proceeding with your trip. This will be done off the app.'**
  String get faq5Answer;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @liveChatResponse.
  ///
  /// In en, this message translates to:
  /// **'Average response time: 5 mins'**
  String get liveChatResponse;

  /// No description provided for @emailSupport.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get emailSupport;

  /// No description provided for @safetyHotline.
  ///
  /// In en, this message translates to:
  /// **'Call Safety Hotline'**
  String get safetyHotline;

  /// No description provided for @safetyHotlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Available 24/7 for urgent issues'**
  String get safetyHotlineDesc;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @yourCollection.
  ///
  /// In en, this message translates to:
  /// **'YOUR COLLECTION'**
  String get yourCollection;

  /// No description provided for @tripMatches.
  ///
  /// In en, this message translates to:
  /// **'Trip Matches'**
  String get tripMatches;

  /// No description provided for @noTripsAdded.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any trips yet.'**
  String get noTripsAdded;

  /// No description provided for @noMatchingTrips.
  ///
  /// In en, this message translates to:
  /// **'No matching trips found.'**
  String get noMatchingTrips;

  /// No description provided for @deleteJourney.
  ///
  /// In en, this message translates to:
  /// **'Delete Journey'**
  String get deleteJourney;

  /// No description provided for @deleteJourneyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this journey from your trips?'**
  String get deleteJourneyConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQ\'s'**
  String get faqs;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @browseAll.
  ///
  /// In en, this message translates to:
  /// **'Browse all'**
  String get browseAll;

  /// No description provided for @percentMatch.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Match'**
  String percentMatch(String percent);

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by {name}'**
  String createdBy(String name);

  /// No description provided for @tripNameOptional.
  ///
  /// In en, this message translates to:
  /// **'TRIP NAME (Optional)'**
  String get tripNameOptional;

  /// No description provided for @tripNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. European Summer Dreams'**
  String get tripNameHint;

  /// No description provided for @whenToTravel.
  ///
  /// In en, this message translates to:
  /// **'WHEN ARE YOU LOOKING TO TRAVEL?'**
  String get whenToTravel;

  /// No description provided for @specificDates.
  ///
  /// In en, this message translates to:
  /// **'Specific dates'**
  String get specificDates;

  /// No description provided for @flexibleBySeason.
  ///
  /// In en, this message translates to:
  /// **'Flexible (by season)'**
  String get flexibleBySeason;

  /// No description provided for @tripStartDate.
  ///
  /// In en, this message translates to:
  /// **'TRIP START DATE'**
  String get tripStartDate;

  /// No description provided for @tripEndDate.
  ///
  /// In en, this message translates to:
  /// **'TRIP END DATE'**
  String get tripEndDate;

  /// No description provided for @selectSeason.
  ///
  /// In en, this message translates to:
  /// **'SELECT SEASON'**
  String get selectSeason;

  /// No description provided for @springSeason.
  ///
  /// In en, this message translates to:
  /// **'Spring (Mar - May)'**
  String get springSeason;

  /// No description provided for @summerSeason.
  ///
  /// In en, this message translates to:
  /// **'Summer (Jun - Aug)'**
  String get summerSeason;

  /// No description provided for @fallSeason.
  ///
  /// In en, this message translates to:
  /// **'Fall (Sep - Nov)'**
  String get fallSeason;

  /// No description provided for @winterSeason.
  ///
  /// In en, this message translates to:
  /// **'Winter (Dec - Feb)'**
  String get winterSeason;

  /// No description provided for @wherePlanningToTravel.
  ///
  /// In en, this message translates to:
  /// **'WHERE ARE YOU PLANNING TO TRAVEL?'**
  String get wherePlanningToTravel;

  /// No description provided for @selectContinent.
  ///
  /// In en, this message translates to:
  /// **'Select a continent'**
  String get selectContinent;

  /// No description provided for @budgetPerNight.
  ///
  /// In en, this message translates to:
  /// **'BUDGET PER NIGHT'**
  String get budgetPerNight;

  /// No description provided for @estimatedBudget.
  ///
  /// In en, this message translates to:
  /// **'ESTIMATED BUDGET'**
  String get estimatedBudget;

  /// No description provided for @tripIdentity.
  ///
  /// In en, this message translates to:
  /// **'Trip Identity'**
  String get tripIdentity;

  /// No description provided for @tripBasics.
  ///
  /// In en, this message translates to:
  /// **'Trip Basics'**
  String get tripBasics;

  /// No description provided for @lodgingPreferences.
  ///
  /// In en, this message translates to:
  /// **'Lodging Preferences'**
  String get lodgingPreferences;

  /// No description provided for @travelStyle.
  ///
  /// In en, this message translates to:
  /// **'Travel Style'**
  String get travelStyle;

  /// No description provided for @socialPreferences.
  ///
  /// In en, this message translates to:
  /// **'Social Preferences'**
  String get socialPreferences;

  /// No description provided for @tellUsMoreAboutYou.
  ///
  /// In en, this message translates to:
  /// **'Tell Us More About You'**
  String get tellUsMoreAboutYou;

  /// No description provided for @activityInterests.
  ///
  /// In en, this message translates to:
  /// **'Activity Interests'**
  String get activityInterests;

  /// No description provided for @idealGroupDynamics.
  ///
  /// In en, this message translates to:
  /// **'Ideal Group Dynamics'**
  String get idealGroupDynamics;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @addTrip.
  ///
  /// In en, this message translates to:
  /// **'Add Trip'**
  String get addTrip;

  /// No description provided for @updateTrip.
  ///
  /// In en, this message translates to:
  /// **'Update Trip'**
  String get updateTrip;

  /// No description provided for @tripCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip created successfully!'**
  String get tripCreatedSuccessfully;

  /// No description provided for @tripUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip updated successfully!'**
  String get tripUpdatedSuccessfully;

  /// No description provided for @pleaseSelectAContinent.
  ///
  /// In en, this message translates to:
  /// **'Please select a continent'**
  String get pleaseSelectAContinent;

  /// No description provided for @pleaseSelectACountry.
  ///
  /// In en, this message translates to:
  /// **'Please select a country'**
  String get pleaseSelectACountry;

  /// No description provided for @pleaseSelectAState.
  ///
  /// In en, this message translates to:
  /// **'Please select a state'**
  String get pleaseSelectAState;

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'COUNTRY'**
  String get countryLabel;

  /// No description provided for @stateLabel.
  ///
  /// In en, this message translates to:
  /// **'STATE'**
  String get stateLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'CITY'**
  String get cityLabel;

  /// No description provided for @pleaseSelectACity.
  ///
  /// In en, this message translates to:
  /// **'Select a city'**
  String get pleaseSelectACity;

  /// No description provided for @budgetQuestion.
  ///
  /// In en, this message translates to:
  /// **'WHAT\'S YOUR BUDGET FOR LODGING PER NIGHT?'**
  String get budgetQuestion;

  /// No description provided for @perNight.
  ///
  /// In en, this message translates to:
  /// **' / night'**
  String get perNight;

  /// No description provided for @cleanlinessQuestion.
  ///
  /// In en, this message translates to:
  /// **'I NEED SHARED SPACES TO BE SPOTLESSLY CLEAN'**
  String get cleanlinessQuestion;

  /// No description provided for @disagree.
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get disagree;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @noiseQuestion.
  ///
  /// In en, this message translates to:
  /// **'I\'M COMFORTABLE WITH NOISE AND ACTIVITY IN SHARED SPACES'**
  String get noiseQuestion;

  /// No description provided for @itineraryQuestion.
  ///
  /// In en, this message translates to:
  /// **'MY TRIPS ARE ALWAYS PLANNED WITH A FULL ITINERARY'**
  String get itineraryQuestion;

  /// No description provided for @earlyRiserQuestion.
  ///
  /// In en, this message translates to:
  /// **'I AM AN EARLY RISER AND LIKE TO START THE DAY EARLY'**
  String get earlyRiserQuestion;

  /// No description provided for @aloneTimeQuestion.
  ///
  /// In en, this message translates to:
  /// **'I PREFER TO HAVE SOME ALONE TIME DURING THE TRIP'**
  String get aloneTimeQuestion;

  /// No description provided for @activityTogetherQuestion.
  ///
  /// In en, this message translates to:
  /// **'I PREFER TO DO ACTIVITIES TOGETHER RATHER THAN ALONE'**
  String get activityTogetherQuestion;

  /// No description provided for @sharingItemsQuestion.
  ///
  /// In en, this message translates to:
  /// **'I AM COMFORTABLE WITH SHARING ITEMS (E.G. TOILETRIES)'**
  String get sharingItemsQuestion;

  /// No description provided for @pronounsLabel.
  ///
  /// In en, this message translates to:
  /// **'PRONOUNS'**
  String get pronounsLabel;

  /// No description provided for @pronounsHint.
  ///
  /// In en, this message translates to:
  /// **'Select your pronouns'**
  String get pronounsHint;

  /// No description provided for @orientationLabel.
  ///
  /// In en, this message translates to:
  /// **'SEXUAL ORIENTATION'**
  String get orientationLabel;

  /// No description provided for @orientationHint.
  ///
  /// In en, this message translates to:
  /// **'Select your orientation'**
  String get orientationHint;

  /// No description provided for @astrologicalSignLabel.
  ///
  /// In en, this message translates to:
  /// **'ASTROLOGICAL SIGN'**
  String get astrologicalSignLabel;

  /// No description provided for @astrologicalSignHint.
  ///
  /// In en, this message translates to:
  /// **'Select your sign'**
  String get astrologicalSignHint;

  /// No description provided for @interestHiking.
  ///
  /// In en, this message translates to:
  /// **'Hiking'**
  String get interestHiking;

  /// No description provided for @interestMuseums.
  ///
  /// In en, this message translates to:
  /// **'Museums'**
  String get interestMuseums;

  /// No description provided for @interestNightlife.
  ///
  /// In en, this message translates to:
  /// **'Nightlife'**
  String get interestNightlife;

  /// No description provided for @interestPhotography.
  ///
  /// In en, this message translates to:
  /// **'Photography'**
  String get interestPhotography;

  /// No description provided for @interestWorkshops.
  ///
  /// In en, this message translates to:
  /// **'Workshops'**
  String get interestWorkshops;

  /// No description provided for @dynamicSmallGroups.
  ///
  /// In en, this message translates to:
  /// **'Small Groups (3-5 people)'**
  String get dynamicSmallGroups;

  /// No description provided for @dynamicSoloMeetups.
  ///
  /// In en, this message translates to:
  /// **'Solo with optional Meetups'**
  String get dynamicSoloMeetups;

  /// No description provided for @dynamicLargeGroups.
  ///
  /// In en, this message translates to:
  /// **'Large Groups (10+ people)'**
  String get dynamicLargeGroups;

  /// No description provided for @closeTrip.
  ///
  /// In en, this message translates to:
  /// **'Close Trip'**
  String get closeTrip;

  /// No description provided for @closeTripConfirm.
  ///
  /// In en, this message translates to:
  /// **'Closing this trip will hide it from other travelers, but you\'ll still keep it in your records.'**
  String get closeTripConfirm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
