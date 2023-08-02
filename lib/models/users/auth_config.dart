class AuthConfig {
  int? id;
  int? hasRole;
  int? failedLoginAttempt;
  int? blockedLoginAttempt;
  int? passwordLength;
  int? hasUppercase;
  int? hasLowercase;
  int? hasNumber;
  int? hasSymbol;
  int? activationCodeValidity;
  int? registrationActivationValidity;
  int? restrictionCount;
  int? passwordValidityPeriod;
  int? accountInactiveReminderPeriod;
  int? sessionInactivePeriod;
  int? sessionReminderPeriod;
  int? passwordReminderPeriod;
  int? ageRule;
  int? accountInactivePeriod;

  AuthConfig({
    this.id,
    this.hasRole,
    this.failedLoginAttempt,
    this.blockedLoginAttempt,
    this.passwordLength,
    this.hasUppercase,
    this.hasLowercase,
    this.hasNumber,
    this.hasSymbol,
    this.activationCodeValidity,
    this.registrationActivationValidity,
    this.restrictionCount,
    this.passwordValidityPeriod,
    this.accountInactiveReminderPeriod,
    this.sessionInactivePeriod,
    this.sessionReminderPeriod,
    this.passwordReminderPeriod,
    this.ageRule,
    this.accountInactivePeriod,
  });

  AuthConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasRole = json['has_role'];
    failedLoginAttempt = json['failed_login_attempt'];
    blockedLoginAttempt = json['blocked_login_attempt'];
    passwordLength = json['password_length'];
    hasUppercase = json['has_uppercase'];
    hasLowercase = json['has_lowercase'];
    hasNumber = json['has_number'];
    hasSymbol = json['has_symbol'];
    activationCodeValidity = json['activation_code_validity'];
    registrationActivationValidity = json['registration_activation_validity'];
    restrictionCount = json['restriction_count'];
    passwordValidityPeriod = json['password_validity_period'];
    accountInactiveReminderPeriod = json['account_inactive_reminder_period'];
    sessionInactivePeriod = json['session_inactive_period'];
    sessionReminderPeriod = json['session_reminder_period'];
    passwordReminderPeriod = json['password_reminder_period'];
    ageRule = json['age_rule'];
    accountInactivePeriod = json['account_inactive_period'];
  }
}


 // "id": 2,
 // "has_role": 1,
 // "failed_login_attempt": 3,
 // "blocked_login_attempt": 120,
 // "password_length": 12,
 // "has_uppercase": 1,
 // "has_lowercase": 0,
 // "has_number": 0,
 // "has_symbol": 0,
 // "activation_code_validity": 24,
 // "registration_activation_validity": 3,
 // "restriction_count": 5,
 // "password_validity_period": 90,
 // "account_inactive_reminder_period": 30,
 // "session_inactive_period": 5,
 // "session_reminder_period": 60,
 // "password_reminder_period": 3,
 // "age_rule": 100,
 // "account_inactive_period": 30,