import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/categories_screen.dart';
import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/dashboard_screen.dart';
import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/order_screen.dart';
import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/product_screen.dart';
import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/upload_banner_screen.dart';
import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/vensdors_screen.dart';
import 'package:farmer_connect_web_admin/views/screens/side_bar_screens.dart/withdrawl_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });

        break;
      case VensdorsScreen.routeName:
        setState(() {
          _selectedItem = VensdorsScreen();
        });
        break;
      case WithdrawlScreen.routeName:
        setState(() {
          _selectedItem = WithdrawlScreen();
        });
        break;

      case OrderScreen.routeName:
        setState(() {
          _selectedItem = OrderScreen();
        });
        break;

      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;

      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          title: Text(
            'Management',
          ),
          backgroundColor: Colors.amber,
        ),
        sideBar: SideBar(
          items: [
            AdminMenuItem(
              title: 'Dashoard',
              icon: Icons.dashboard,
              route: DashboardScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Vendors',
              icon: CupertinoIcons.person_3,
              route: VensdorsScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Withdrawl',
              icon: CupertinoIcons.money_dollar,
              route: WithdrawlScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Orders',
              icon: CupertinoIcons.shopping_cart,
              route: OrderScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Categories',
              icon: Icons.category,
              route: CategoriesScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Product',
              icon: Icons.shop,
              route: ProductScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Upload Banner',
              icon: CupertinoIcons.add,
              route: UploadBannerScreen.routeName,
            ),
          ],
          selectedRoute: '/',
          onSelected: (item) {
            screenSelector(item);
          },
          header: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'Farmer-Connect AdminPanel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'footer',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: _selectedItem
        );
  }
}
