const String kIConDir = 'assets/icons/';
const String kImageDir = 'assets/images/';
const String kFlagDir = 'assets/flags/';
const String kBase64Extend = 'data:image/jpeg;base64,';
const String kBase64ExtendVideo = 'data:video/mp4;base64,';
const String kBase64ExtendAudio = 'data:audio/mp3;base64,';
// String kIsBangla = LocalizationService().getCurrentLang();

///Combined User Id to create single chatroom id
String combinedUserId(String id1, String id2) {
  return id1.compareTo(id2) > 0 ? '$id1-$id2' : '$id2-$id1';
}

//product price currency
const String kCurrency = 'Dhs';
//server request timeout (http)
const int timeoutRequest = 60;

///Support info
const String supportPhoneNumber = '+8801700000000';
const String supportWhatsappNumber = '+8801700000000';
const String supportFacebook = 'https://www.facebook.com/page_name';
const String supportMessenger = 'https://m.me/page_name';
const String supportWebsite = 'https://www.akaarit.com/';

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp htmlValidatorRegExp = RegExp(r"(<[^>]*>|&\w+;)");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Your email address is not valid";
const String kPassNullError = "Please enter your password";
const String kPassNewNullError = "Please enter your New password";
const String kPassConfirmNullError = "Please enter your Confirm password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please enter your full name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";
const String kInvalidNumberError = "Invalid phone number";
const String kMinWithdrawLimit = "Minimum withdraw limit 1 USD";

///====================your setup option======================
// woocommerce consumer and secret key
const String consumerKey = 'ck_76b6bb3ff2430cf2a9a97ed83d36acb99e608112';
const String consumerSecret = 'cs_84b59d12f9b95dddea32c989521be22f3dea2f42';
//tawk msg key
const String tawkMsgKey =
    'https://tawk.to/chat/625e2df57b967b11798b5730/1g0vu724g';
//Onesignal app id and rest api key
const String onesignalAppId = '';
const String onesignalRestKey = '';
//Stripe key
String kPublishableKey = '';
String kSecretKey = '';
//Paypal credential
String kPaypalClientId = "";
String kPaypalSecretKey = "";
//PayStack credential
String kPayStackPublicKey = '';
//Braintree credential
String kKokenizationKey = '';
//Pay payment credential
String kPayPublishableKey = '';
String kPaySecretKey = '';
//Razorpay credential
String kRazorpayKeyId = '';
//Paytm credential
String kPaytmMerchantId = 'mid_id';
//SSL Commerz credential
String kStoreId = '';
String kStorePassword = '@ssl';
//Flutter wave credential
String kWavePublicKey = '';
String kWaveSecretKey = '';
String kWaveEncryptionKey = '';

///****Don't change***
String authCCToken =
    'consumer_key=$consumerKey&consumer_secret=$consumerSecret';
//notification topic name
const String topicName = 'web_app';
// Shared Key
const String theme = 'theme';
const String token = 'token';
const String userId = 'user_id';
const String userAvatar = 'user_avatar';
const String userName = 'user_name';
const String userPassword = 'user_pass';
const String userDisplayName = 'display_name';
const String userEmail = 'user_email';
const String firstName = 'first_name';
const String lastName = 'last_name';

///****Don't change end***
//Image show and hide--just test time use
const bool isImageShow = true;

const String kPrivacyPolices = ""
    "Akaar IT Ltd.Built the Woogoods app as a Free app. This SERVICE is provided by Akaar IT Ltd. "
    "at no cost and is intended for use as is. This page is used to inform visitors regarding our"
    " policies with the collection, use, and disclosure of Personal Information if anyone decided to "
    "use our Service. If you choose to use our Service, then you agree to the collection and use of"
    " information in relation to this policy. The Personal Information that we collect is used for "
    "providing and improving the Service. We will not use or share your information with anyone except"
    " as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings "
    "as in our Terms and Conditions, which is accessible at Woogoods unless otherwise defined in this "
    "Privacy Policy. Information Collection and Use For a better experience, while using our Service,"
    " we may require you to provide us with certain personally identifiable information, including but "
    "not limited to name, email, phone, address, user image. The information that we request will be retained "
    "by us and used as described in this privacy policy. Log Data We want to inform you that whenever"
    " you use our Service, in a case of an error in the app we collect data and information (through "
    "third party products) on your phone called Log Data. This Log Data may include information such "
    "as your device Internet Protocol (“IP”) address,"
    " device name, operating system version, the configuration of the app when utilizing our Service, "
    "the time and date of your use of the Service, and other statistics. Cookies Cookies are files with a"
    " small amount of data that are commonly used as anonymous unique identifiers. These are sent to your "
    "browser from the websites that you visit and are stored on your device's internal memory. This Service "
    "does not use these “cookies” explicitly. However, the app may use third party code and libraries that "
    "use “cookies” to collect information and improve their services. You have the "
    "option to either accept or refuse these cookies and know when a cookie is being sent "
    "to your device. If you choose to refuse our cookies, you may not be able to use some portions of"
    " this Service. Service Providers We may employ third-party companies and individuals due to the"
    " following reasons: To facilitate our Service; To provide the Service on our behalf; To perform "
    "Service-related services; or To assist us in analyzing how our Service is used. We want to inform "
    "users of this Service that these third parties have access to your Personal Information. The reason "
    "is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose "
    "or use the information for any other purpose. Security We value your trust in providing us your Personal"
    " Information, thus we are striving to use commercially acceptable means of protecting it. But remember "
    "that no method of transmission over the internet, or method of electronic storage is 100% secure and "
    "reliable, and we cannot guarantee its absolute security. Links to Other Sites This Service may contain "
    "links to other sites. If you click on a third-party link, you will be directed to that site. Note that "
    "these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy "
    "Policy of these websites. We have no control over and assume no responsibility for the content, privacy"
    " policies, or practices of any third-party sites or services. Children’s Privacy These Services do not "
    "address anyone under the age of 13. We do not knowingly collect"
    " personally identifiable information from children under 13 years of age. In the case we discover that"
    " a child under 13 has provided us with personal information, we immediately delete this from our servers. "
    "If you are a parent or guardian and you are aware that your child has provided us with personal i"
    "nformation, please contact us so that we will be able to do necessary actions. Changes to"
    " This Privacy Policy We may update our Privacy Policy from time to time."
    " Thus, you are advised to review this page periodically for any changes. We will notify"
    " you of any changes by posting the new Privacy Policy on this page. This policy is effective as "
    "of 2021-11-17 Contact Us If you have any questions or suggestions about our Privacy Policy, do not"
    " hesitate to contact us at woogoods.support@gmail.com.";

const String kTermsConditions =
    "Akaar IT Ltd.Built the Woogoods app as a Free app. This SERVICE is provided by Akaar IT Ltd. "
    "at no cost and is intended for use as is. This page is used to inform visitors regarding our"
    " policies with the collection, use, and disclosure of Personal Information if anyone decided to "
    "use our Service. If you choose to use our Service, then you agree to the collection and use of"
    " information in relation to this policy. The Personal Information that we collect is used for "
    "providing and improving the Service. We will not use or share your information with anyone except"
    " as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings "
    "as in our Terms and Conditions, which is accessible at Woogoods unless otherwise defined in this "
    "Privacy Policy. Information Collection and Use For a better experience, while using our Service,"
    " we may require you to provide us with certain personally identifiable information, including but "
    "not limited to name, email, phone, address, user image. The information that we request will be retained "
    "by us and used as described in this privacy policy. Log Data We want to inform you that whenever"
    " you use our Service, in a case of an error in the app we collect data and information (through "
    "third party products) on your phone called Log Data. This Log Data may include information such "
    "as your device Internet Protocol (“IP”) address,"
    " device name, operating system version, the configuration of the app when utilizing our Service, "
    "the time and date of your use of the Service, and other statistics. Cookies Cookies are files with a"
    " small amount of data that are commonly used as anonymous unique identifiers. These are sent to your "
    "browser from the websites that you visit and are stored on your device's internal memory. This Service "
    "does not use these “cookies” explicitly. However, the app may use third party code and libraries that "
    "use “cookies” to collect information and improve their services. You have the "
    "option to either accept or refuse these cookies and know when a cookie is being sent "
    "to your device. If you choose to refuse our cookies, you may not be able to use some portions of"
    " this Service. Service Providers We may employ third-party companies and individuals due to the"
    " following reasons: To facilitate our Service; To provide the Service on our behalf; To perform "
    "Service-related services; or To assist us in analyzing how our Service is used. We want to inform "
    "users of this Service that these third parties have access to your Personal Information. The reason "
    "is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose "
    "or use the information for any other purpose. Security We value your trust in providing us your Personal"
    " Information, thus we are striving to use commercially acceptable means of protecting it. But remember "
    "that no method of transmission over the internet, or method of electronic storage is 100% secure and "
    "reliable, and we cannot guarantee its absolute security. Links to Other Sites This Service may contain "
    "links to other sites. If you click on a third-party link, you will be directed to that site. Note that "
    "these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy "
    "Policy of these websites. We have no control over and assume no responsibility for the content, privacy"
    " policies, or practices of any third-party sites or services. Children’s Privacy These Services do not "
    "address anyone under the age of 13. We do not knowingly collect"
    " personally identifiable information from children under 13 years of age. In the case we discover that"
    " a child under 13 has provided us with personal information, we immediately delete this from our servers. "
    "If you are a parent or guardian and you are aware that your child has provided us with personal i"
    "nformation, please contact us so that we will be able to do necessary actions. Changes to"
    " This Privacy Policy We may update our Privacy Policy from time to time."
    " Thus, you are advised to review this page periodically for any changes. We will notify"
    " you of any changes by posting the new Privacy Policy on this page. This policy is effective as "
    "of 2021-11-17 Contact Us If you have any questions or suggestions about our Privacy Policy, do not"
    " hesitate to contact us at woogoods.support@gmail.com.";
