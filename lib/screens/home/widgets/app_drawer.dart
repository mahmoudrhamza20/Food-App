import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/providers.dart';

import '../../screens.dart';

class AppDrawer extends StatelessWidget {
  final UserProvider userProvider;
  const AppDrawer({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userData = userProvider.getCurrentUserData;

    String userName, userImage;

    try {
      userName = userData.userName;
      // userImage = userData.userImage;
      userImage =
          'https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg?w=768';
    } catch (e) {
      userName = 'Guest';
      userImage =
          'https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg?w=768';
      debugPrint('Error: $e');
    }
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 43,
                  backgroundColor: AppColors.backgroundColor,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        FirebaseAuth.instance.currentUser == null
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 7),
                      FirebaseAuth.instance.currentUser == null
                          ? InkWell(
                              onTap: () {
                                debugPrint('Login Clicked');
                              },
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white54,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              userData.userEmail,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black45,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ListTile(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   leading: const Icon(
          //     Icons.home_outlined,
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Home',
          //     style: TextStyle(
          //       color: Colors.black45,
          //       fontFamily: 'Roboto',
          //     ),
          //   ),
          // ),
          DrawerListTile(
            title: 'My Profile',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userProvider: userProvider,
                  ),
                ),
              );
            },
            icon: Icons.person_outlined,
          ),
          DrawerListTile(
            icon: Icons.shop_outlined,
            title: 'Review Cart',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(
                    isAppDrawer: true,
                  ),
                ),
              );
            },
          ),
          DrawerListTile(
            icon: Icons.favorite_outline,
            title: 'WishList',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WishListScreen(),
                ),
              );
            },
          ),

          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(
          //     Icons.notifications_outlined,
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Notification',
          //     style: TextStyle(
          //       color: Colors.black45,
          //       fontFamily: 'Roboto',
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(
          //     Icons.star_outline,
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Rating & Review',
          //     style: TextStyle(
          //       color: Colors.black45,
          //       fontFamily: 'Roboto',
          //     ),
          //   ),
          // ),

          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(
          //     Icons.report_outlined,
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Raise a Complain',
          //     style: TextStyle(
          //       color: Colors.black45,
          //       fontFamily: 'Roboto',
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(
          //     Icons.format_quote_outlined,
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'FAQs',
          //     style: TextStyle(
          //       color: Colors.black45,
          //       fontFamily: 'Roboto',
          //     ),
          //   ),
          // ),
          // const Divider(),
          // const Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(
          //         left: 15,
          //       ),
          //       child: Text(
          //         'Contact Support',
          //         style: TextStyle(
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w500,
          //           fontSize: 18,
          //         ),
          //       ),
          //     ),
          //     SizedBox(height: 10),
          //     Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 15,
          //         vertical: 10,
          //       ),
          //       child: Row(
          //         children: [
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               SizedBox(
          //                 width: 40,
          //                 child: Text(
          //                   'Call:',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                     fontFamily: 'Roboto',
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(height: 10),
          //               SizedBox(
          //                 width: 40,
          //                 child: Text(
          //                   'Mail:',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                     fontFamily: 'Roboto',
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 '+201017397522',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontFamily: 'Roboto',
          //                   color: Colors.black45,
          //                 ),
          //               ),
          //               SizedBox(height: 10),
          //               Text(
          //                 'mahmoudrhamza20@gmail.com',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontFamily: 'Roboto',
          //                   color: Colors.black45,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          // const SizedBox(height: 5),
          // const Divider(),
          // const SizedBox(height: 5),
          // const Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Text('Version: 1.0.0'),
          // ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });
  final String title;
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      // ()
      // {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => const CartScreen(
      //         isAppDrawer: true,
      //       ),
      //     ),
      //   );
      // },
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black45,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
