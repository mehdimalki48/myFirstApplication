var thisYear = DateTime.now().year.toString();

const String appName = "FMTmimi"; //this shows in the splash screen
String copyrightText =
    "@ $appName " + thisYear; //this shows in the splash screen

//full url = https://dev-grif.1129-1891.cyou/api/v1/logout
//configure this
const bool https = true;

//configure this
const domainPath = "fmtmimi.com"; // directly inside the public folder

//do not configure these below
const String apiEndPath = "index.php";
const String publicFolder = "public";
const String protocol = https ? "https://" : "http://";
const String rawBaseUrl = "$protocol$domainPath";
const String baseUrl = "$rawBaseUrl/";

//configure this if you are using amazon s3 like services
//give direct link to file like https://[[bucketname]].s3.ap-southeast-1.amazonaws.com/
//otherwise do not change anythink

//End point
const String wordpressEndPath = "wp-json/wp/v2";
const String woocommerceEndPath = "wp-json/wc/v3";
const String jWTEndPath = "wp-json/jwt-auth/v1";
const String resetPassWordEndPath = "wp-json/bdpwr/v1";

//woocommerce api end point
const String productList = '/$woocommerceEndPath/products';
const String categoryList = '/$woocommerceEndPath/products/categories';
const String reviewList = '/$woocommerceEndPath/products/reviews';
const String orderUri = '/$woocommerceEndPath/orders';
const String shippingZoneUri = '/$woocommerceEndPath/shipping/zones';
const String couponUri = '/$woocommerceEndPath/coupons';
//Profile api end point
const String singleUserUri = "/$wordpressEndPath/users";
const String emailRegisterUri = "/$wordpressEndPath/users/register";
const String emailLoginUri = "/$jWTEndPath/token";
const String resetPasswordUri = "/$resetPassWordEndPath/reset-password";
const String resetNewPasswordUri = "/$resetPassWordEndPath/set-password";
const String currentUserProfileUri = "/$wordpressEndPath/users/me";
const String updateProfileUri = '/$wordpressEndPath/users';
//Slider
const String sliderListUri = '/$wordpressEndPath/mlslide';
//wordpress image
const String kWordpressImageUri = '/$wordpressEndPath/media';
const String brandListUri = '/$wordpressEndPath/brands';
//Onesignal
const String kOnesignalListUri = 'https://onesignal.com/api/v1/notifications';
