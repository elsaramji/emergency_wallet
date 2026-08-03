import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Emergency Cash'**
  String get appName;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Track Your Money'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDescription1.
  ///
  /// In en, this message translates to:
  /// **'View all your Cash, Visa, and Smart Wallet balances in one place.'**
  String get onboardingDescription1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Emergency Auto-Save'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDescription2.
  ///
  /// In en, this message translates to:
  /// **'Automatically save 20% of your salary to an Emergency Wallet when you get paid.'**
  String get onboardingDescription2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Financial Resilience'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDescription3.
  ///
  /// In en, this message translates to:
  /// **'Build a strong financial safety net for unexpected life events.'**
  String get onboardingDescription3;

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

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcome;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to access your financial overview.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a password reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get resetPasswordButton;

  /// No description provided for @checkEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your email to change password'**
  String get checkEmailMessage;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginButton;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @donTHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get donTHaveAnAccount;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join the smarter way to manage your money.'**
  String get registerSubtitle;

  /// No description provided for @registerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get registerNameLabel;

  /// No description provided for @registerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get registerNameHint;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a secure password'**
  String get registerPasswordHint;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerButton;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Cash'**
  String get homeTitle;

  /// No description provided for @homeTotalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get homeTotalBalance;

  /// No description provided for @homeCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get homeCash;

  /// No description provided for @homeVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get homeVisa;

  /// No description provided for @homeSmartWallet.
  ///
  /// In en, this message translates to:
  /// **'Smart Wallet'**
  String get homeSmartWallet;

  /// No description provided for @homeEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency Wallet'**
  String get homeEmergency;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get errorInvalidEmail;

  /// No description provided for @errorInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorInvalidPassword;

  /// No description provided for @errorInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get errorInvalidName;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorSomethingWentWrong;

  /// No description provided for @successLogin.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get successLogin;

  /// No description provided for @successRegister.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get successRegister;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @isSalary.
  ///
  /// In en, this message translates to:
  /// **'This is my salary'**
  String get isSalary;

  /// No description provided for @autoSaveNote.
  ///
  /// In en, this message translates to:
  /// **'20% will be saved automatically'**
  String get autoSaveNote;

  /// No description provided for @welcomeTitleEmployment.
  ///
  /// In en, this message translates to:
  /// **'What is your primary employment status?'**
  String get welcomeTitleEmployment;

  /// No description provided for @welcomeSubTitleEmployment.
  ///
  /// In en, this message translates to:
  /// **'This helps us personalize your wallet experience.'**
  String get welcomeSubTitleEmployment;

  /// No description provided for @employmentEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employmentEmployee;

  /// No description provided for @employmentEmployeeDesc.
  ///
  /// In en, this message translates to:
  /// **'I receive a stable monthly salary'**
  String get employmentEmployeeDesc;

  /// No description provided for @employmentFreelancer.
  ///
  /// In en, this message translates to:
  /// **'Freelancer'**
  String get employmentFreelancer;

  /// No description provided for @employmentFreelancerDesc.
  ///
  /// In en, this message translates to:
  /// **'My income varies each month'**
  String get employmentFreelancerDesc;

  /// No description provided for @employmentStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get employmentStudent;

  /// No description provided for @employmentStudentDesc.
  ///
  /// In en, this message translates to:
  /// **'I rely on allowance or part-time work'**
  String get employmentStudentDesc;

  /// No description provided for @welcomeTitleSalary.
  ///
  /// In en, this message translates to:
  /// **'Do you have a stable monthly salary?'**
  String get welcomeTitleSalary;

  /// No description provided for @welcomeSubTitleSalary.
  ///
  /// In en, this message translates to:
  /// **'This allows us to set up automated saving rules tailored for you.'**
  String get welcomeSubTitleSalary;

  /// No description provided for @salaryYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, I do'**
  String get salaryYes;

  /// No description provided for @salaryNo.
  ///
  /// In en, this message translates to:
  /// **'No, my income varies'**
  String get salaryNo;

  /// No description provided for @welcomeTitleActivation.
  ///
  /// In en, this message translates to:
  /// **'Activate Emergency Wallet'**
  String get welcomeTitleActivation;

  /// No description provided for @welcomeSubTitleActivation.
  ///
  /// In en, this message translates to:
  /// **'Since you have a stable salary, we can automatically save 20% of your income to a locked Emergency Wallet.'**
  String get welcomeSubTitleActivation;

  /// No description provided for @emergencyWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Wallet'**
  String get emergencyWalletLabel;

  /// No description provided for @emergencyWalletAutoSaveDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto-saves 20% of your salary'**
  String get emergencyWalletAutoSaveDesc;

  /// No description provided for @btnActivateNow.
  ///
  /// In en, this message translates to:
  /// **'Activate Now'**
  String get btnActivateNow;

  /// No description provided for @btnMaybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get btnMaybeLater;

  /// No description provided for @welcomeTitleNoSalary.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Track Your Cash Flow'**
  String get welcomeTitleNoSalary;

  /// No description provided for @welcomeSubTitleNoSalary.
  ///
  /// In en, this message translates to:
  /// **'Emergency Cash is here to help you manage your daily inflows and outflows efficiently.'**
  String get welcomeSubTitleNoSalary;

  /// No description provided for @noSalaryInfo.
  ///
  /// In en, this message translates to:
  /// **'Since your income varies, the automated Emergency Wallet is disabled. You can activate it later from Profile Settings when you have a stable salary.'**
  String get noSalaryInfo;

  /// No description provided for @btnGoToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Go to Dashboard'**
  String get btnGoToDashboard;

  /// No description provided for @btnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// No description provided for @btnBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get btnBack;

  /// No description provided for @welcomeTitleSalaryAmount.
  ///
  /// In en, this message translates to:
  /// **'What is your monthly salary?'**
  String get welcomeTitleSalaryAmount;

  /// No description provided for @welcomeSubTitleSalaryAmount.
  ///
  /// In en, this message translates to:
  /// **'We\'ll use this to calculate your savings target.'**
  String get welcomeSubTitleSalaryAmount;

  /// No description provided for @salaryAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Salary Amount'**
  String get salaryAmountLabel;

  /// No description provided for @salaryAmountHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 5000'**
  String get salaryAmountHint;

  /// No description provided for @currencyEGP.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currencyEGP;

  /// No description provided for @welcomeTitleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Emergency Wallet Ready 🔒'**
  String get welcomeTitleSuccess;

  /// No description provided for @welcomeSubTitleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your safety net is now active and protected.'**
  String get welcomeSubTitleSuccess;

  /// No description provided for @welcomeTitleBalances.
  ///
  /// In en, this message translates to:
  /// **'Set up your starting balances'**
  String get welcomeTitleBalances;

  /// No description provided for @welcomeSubTitleBalances.
  ///
  /// In en, this message translates to:
  /// **'This helps us calculate your total available liquidity.'**
  String get welcomeSubTitleBalances;

  /// No description provided for @cashBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Cash Balance'**
  String get cashBalanceLabel;

  /// No description provided for @visaBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Visa Balance'**
  String get visaBalanceLabel;

  /// No description provided for @smartWalletBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Smart Wallet Balance'**
  String get smartWalletBalanceLabel;

  /// No description provided for @startTracking.
  ///
  /// In en, this message translates to:
  /// **'Start Tracking'**
  String get startTracking;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get dashboardWelcome;

  /// No description provided for @dashboardUserNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Mr. Mahmoud'**
  String get dashboardUserNamePlaceholder;

  /// No description provided for @cashIn.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get cashIn;

  /// No description provided for @cashOut.
  ///
  /// In en, this message translates to:
  /// **'Cash Out'**
  String get cashOut;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @mockTransTitle1.
  ///
  /// In en, this message translates to:
  /// **'McDonald\'s'**
  String get mockTransTitle1;

  /// No description provided for @mockTransMeta1.
  ///
  /// In en, this message translates to:
  /// **'Food & Dining • Today, 2:45 PM'**
  String get mockTransMeta1;

  /// No description provided for @mockTransTitle2.
  ///
  /// In en, this message translates to:
  /// **'Monthly Salary'**
  String get mockTransTitle2;

  /// No description provided for @mockTransMeta2.
  ///
  /// In en, this message translates to:
  /// **'Income • Yesterday'**
  String get mockTransMeta2;

  /// No description provided for @mockTransTitle3.
  ///
  /// In en, this message translates to:
  /// **'Uber Trip'**
  String get mockTransTitle3;

  /// No description provided for @mockTransMeta3.
  ///
  /// In en, this message translates to:
  /// **'Transport • 2 days ago'**
  String get mockTransMeta3;

  /// No description provided for @newTransaction.
  ///
  /// In en, this message translates to:
  /// **'New Transaction'**
  String get newTransaction;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @addTransaction.
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTransaction;

  /// No description provided for @catSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get catSalary;

  /// No description provided for @catFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get catFood;

  /// No description provided for @catTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get catTransport;

  /// No description provided for @catShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get catShopping;

  /// No description provided for @catHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get catHealth;

  /// No description provided for @catEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get catEntertainment;

  /// No description provided for @catOthers.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get catOthers;

  /// No description provided for @catCredits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get catCredits;

  /// No description provided for @catDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get catDeposit;

  /// No description provided for @catKPIs.
  ///
  /// In en, this message translates to:
  /// **'KPIs'**
  String get catKPIs;

  /// No description provided for @catFees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get catFees;

  /// No description provided for @catDebts.
  ///
  /// In en, this message translates to:
  /// **'Debts'**
  String get catDebts;

  /// No description provided for @walletLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletLabel;

  /// No description provided for @emergencyWalletLockedWarning.
  ///
  /// In en, this message translates to:
  /// **'Emergency Wallet cash out is only available when other balances are below 50 EGP.'**
  String get emergencyWalletLockedWarning;

  /// No description provided for @simulateLowBalance.
  ///
  /// In en, this message translates to:
  /// **'Simulate Low Balance (< 50 EGP)'**
  String get simulateLowBalance;

  /// No description provided for @mockScreenPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'This screen is currently under construction'**
  String get mockScreenPlaceholder;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get historyTitle;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage your cash flow'**
  String get historySubtitle;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial Insights'**
  String get insightsTitle;

  /// No description provided for @insightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze your spending habits'**
  String get insightsSubtitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your settings and preferences'**
  String get profileSubtitle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// No description provided for @historyNoActivity.
  ///
  /// In en, this message translates to:
  /// **'No activity'**
  String get historyNoActivity;

  /// No description provided for @historyUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get historyUpcoming;

  /// No description provided for @historyOperations.
  ///
  /// In en, this message translates to:
  /// **'operations'**
  String get historyOperations;

  /// No description provided for @languageSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get languageSelectionTitle;

  /// No description provided for @languageSelectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language to customize your experience.'**
  String get languageSelectionSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglishDesc.
  ///
  /// In en, this message translates to:
  /// **'Use English throughout the application'**
  String get languageEnglishDesc;

  /// No description provided for @languageArabicDesc.
  ///
  /// In en, this message translates to:
  /// **'Arabic language is supported'**
  String get languageArabicDesc;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
