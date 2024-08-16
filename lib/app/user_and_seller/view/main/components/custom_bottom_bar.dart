import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatefulWidget {
  final TabController controller;

  const CustomBottomBar({
    super.key,
    required this.controller,
  });

  @override
  State<CustomBottomBar> createState() =>
      _CustomBottomBarState(controller: controller);
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final TabController controller;
  _CustomBottomBarState({
    required this.controller,
  });
  int _selectedIndex = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildTabItem('assets/icons/home_icon.svg', 0),
          _buildTabItem('assets/icons/shop.png', 1),
          _buildTabItem('assets/icons/category_icon.png', 2),
          _buildTabItem('assets/icons/cart_icon.svg', 3),
          _buildTabItem('assets/icons/profile_icon.png', 4),
        ],
      ),
    );
  }

  Widget _buildTabItem(String iconPath, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        controller.animateTo(index);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.yellow : null,
          borderRadius:
              BorderRadius.circular(50.0), // Adjust the value as needed
        ),
        padding: EdgeInsets.all(8.0),
        child: index == 0 || index == 3
            ? SvgPicture.asset(
                iconPath,
                fit: BoxFit.fitWidth,
                height: 22,
              )
            : Image.asset(
                iconPath,
                fit: BoxFit.fitWidth,
                height: 21,
                width: 21,
              ),
      ),
    );
  }
}
