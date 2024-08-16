import 'package:ecommerce_int2/app/admin/view/auth/admin_login.dart';
import 'package:ecommerce_int2/app/admin/view/others/contacts.dart';
import 'package:ecommerce_int2/app/admin/view/profile_page/showMessageDriver.dart';
import 'package:ecommerce_int2/app/admin/view/profile_page/showMessagesAdmin.dart';
import 'package:ecommerce_int2/app/delivery/view/auth/welcome_back_driver.dart';
import 'package:ecommerce_int2/app/delivery/view/profile_page/third_party_delivery_service.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/address/add_address_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/register_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/registration-page-owner.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/welcome_back-page-owner.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/welcome_back_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/checkout/select_payment_method.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/payment/payment_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/edit_profile_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/forgot_password_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/liked_product.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/reset_password.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page_content/edit_item.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page_content/repair_orders.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/service_men/add_service_men.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/service_men/service_men_list.dart';
import 'package:ecommerce_int2/shared/view/error.dart';
import 'package:ecommerce_int2/shared/view/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'app/admin/view/profile_page/profile_page_admin.dart';
import 'app/delivery/view/profile_page/profile_page_driver.dart';
import 'app/user_and_seller/view/main/components/shop_item_list.dart';
import 'app/user_and_seller/view/main/main_page.dart';
import 'app/user_and_seller/view/marketplace/ProductsMarketPlace.dart';
import 'app/user_and_seller/view/marketplace/SellProductUser.dart';
import 'app/user_and_seller/view/marketplace/marketPlacePage.dart';
import 'app/user_and_seller/view/profile_page/edit_profile_page_seller.dart';
import 'app/user_and_seller/view/profile_page/profile_page.dart';
import 'app/user_and_seller/view/profile_page/profile_page_seller.dart';
import 'app/user_and_seller/view/profile_page_content/accept_repair.dart';
import 'app/user_and_seller/view/profile_page_content/appointments_user.dart';
import 'app/user_and_seller/view/profile_page_content/orderHistoryUser.dart';
import 'app/user_and_seller/view/profile_page_content/order_request.dart';
import 'app/user_and_seller/view/profile_page_content/pending_requests.dart';
import 'app/user_and_seller/view/profile_page_content/repair_request.dart';
import 'app/user_and_seller/view/profile_page_content/repair_shopwork.dart';
import 'app/user_and_seller/view/profile_page_content/restrict_seller.dart';
import 'app/user_and_seller/view/profile_page_content/restrict_user.dart';
import 'app/user_and_seller/view/profile_page_content/restricted_seller.dart';
import 'app/user_and_seller/view/profile_page_content/restricted_user.dart';
import 'app/user_and_seller/view/profile_page_content/sell_item.dart';
import 'app/user_and_seller/view/profile_page_content/showMessageSeller.dart';
import 'app/user_and_seller/view/profile_page_content/showMessageUser.dart';
import 'app/user_and_seller/view/seller_dashboard/seller_dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        /*primaryColor: Colors.yellow,
        canvasColor: Colors.transparent,*/
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        fontFamily: "Montserrat",
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      builder: EasyLoading.init(),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      route('/', IntroPage()),
      route(ProfilePage.routeName, ProfilePage()),
      route(RegisterPageOwner.routeName, RegisterPageOwner()),
      route(MainPage.routeName, MainPage()),
      route(IntroPage.routeName, IntroPage()),
      route(SellItem.routeName, SellItem()),
      route(EditItem.routeName, EditItem()),
      route(ProfilePageSeller.routeName, ProfilePageSeller()),
      route(SellerDashboard.routeName, SellerDashboard()),
      route(ProfilePageDriver.routeName, ProfilePageDriver()),
      route(ShopList.routeName, ShopList()),
      route(ProfilePageAdmin.routeName, ProfilePageAdmin()),
      route(RepairShopwork.routeName, RepairShopwork()),
      route(RestrictUser.routeName, RestrictUser()),
      route(RestrictedUser.routeName, RestrictedUser()),
      route(RestrictSeller.routeName, RestrictSeller()),
      route(RestrictedSeller.routeName, RestrictedSeller()),
      route(RepairRequest.routeName, RepairRequest()),
      route(RepairOrders.routeName, RepairOrders()),
      route(PendingRequest.routeName, PendingRequest()),
      route(RepairRequestAccept.routeName, RepairRequestAccept()),
      route(AppointmentUser.routeName, AppointmentUser()),
      route(OrderRequest.routeName, OrderRequest()),

      route(MarketPlaceProducts.routeName, MarketPlaceProducts()),
      route(SellProductUser.routeName, SellProductUser()),
      route(ProductMarketPlace.routeName, ProductMarketPlace()),
      route(OrderHistroyUser.routeName, OrderHistroyUser()),
      route(ShowMessagesUser.routeName, ShowMessagesUser()),
      route(ShowMessagesSeller.routeName, ShowMessagesSeller()),
      route(ShowMessagesAdmin.routeName, ShowMessagesAdmin()),
      route(ShowMessagesDriver.routeName, ShowMessagesDriver()),
      route(RegisterPage.routeName, RegisterPage()),
      route(WelcomeBackPage.routeName, WelcomeBackPage()),
      route(RegisterPageOwner.routeName, RegisterPageOwner()),
      route(WelcomeBackPageOwner.routeName, WelcomeBackPageOwner()),
      route(WelcomeBackPageDriver.routeName, const WelcomeBackPageDriver()),
      route(AdminLoginPage.routeName, const AdminLoginPage()),
      route(ErrorPage.routeName, const ErrorPage()),
      route(ContactsList.routeName, const ContactsList()),
      route(ThirdPartyDeliveryService.routeName, ThirdPartyDeliveryService()),
      route(PaymentPage.routeName, PaymentPage()),
      //  new routes
      route(AddServiceMen.routeName, AddServiceMen()),
      route(ServiceMenList.routeName, ServiceMenList()),
      route(SelectPaymentMethod.routeName, SelectPaymentMethod()),
      route(AddAddressPage.routeName, AddAddressPage()),
      route(ForgotPasswordPage.routeName, ForgotPasswordPage()),
      route(ResetPasswordPage.routeName, ResetPasswordPage()),
      route(LikedProduct.routeName, LikedProduct()),
      route(EditProfileSeller.routeName, EditProfileSeller()),
      route(EditProfilePage.routeName, EditProfilePage()),

    ],
    errorBuilder: (context, state) => ErrorPage(),
  );
}

GoRoute route(String path, Widget route) {
  return GoRoute(
    path: path,
    builder: (BuildContext context, GoRouterState state) => route,
  );
}

launch(BuildContext context, String route, [Object? extra]) {
  GoRouter.of(context).push(route, extra: extra);
}

// Next Page without toolbar leading arrow
replace(BuildContext context, String route, [Object? extra]) {
  GoRouter.of(context).replace(route, extra: extra);
}

// Next Page with toolbar leading arrow
launchReplace(BuildContext context, String route, [Object? extra]) {
  GoRouter.of(context).pushReplacement(route, extra: extra);
}

finish(BuildContext context) => GoRouter.of(context).pop();
