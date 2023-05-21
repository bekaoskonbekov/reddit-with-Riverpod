import 'package:flutter/material.dart';
import 'package:reddit/feature/community/screens/add_mods_screen.dart';
import 'package:reddit/feature/community/screens/community_screen.dart';
import 'package:reddit/feature/community/screens/edit_community_screen.dart';
import 'package:reddit/feature/community/screens/mod_tools_screen.dart';
import 'package:reddit/feature/post/screens/comment_screen.dart';
import 'package:reddit/feature/user_profile/screens/eidt_profile_screen.dart';
import 'package:reddit/feature/user_profile/screens/user_profile_screen.dart';
import 'package:routemaster/routemaster.dart';

import '../../feature/auth/screens/login_screen.dart';
import '../../feature/community/screens/create_community_screen.dart';
import '../../feature/home/home_screen.dart';
import '../../feature/post/screens/add_post_type_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen()),
    '/create-community': (_) =>
        const MaterialPage(child: CreateCommunityScreen()),
    '/r/:name': (route) => MaterialPage(
            child: CommunityScreen(
          name: route.pathParameters['name']!,
        )),
    '/mod-tools/:name': (routeData) => MaterialPage(
          child: ModToolsScreen(
            name: routeData.pathParameters['name']!,
          ),
        ),
    '/edit-community/:name': (routeData) => MaterialPage(
          child: EditCommunityScreen(
            name: routeData.pathParameters['name']!,
          ),
        ),
    '/add-mods/:name': (routeData) => MaterialPage(
          child: AddModsScreen(
            name: routeData.pathParameters['name']!,
          ),
        ),
    '/u/:uid': (routeData) => MaterialPage(
          child: UserProfileScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
    '/edit-profile/:uid': (routeData) => MaterialPage(
          child: EditProfileScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
    '/add-post/:type': (routeData) => MaterialPage(
          child: AddPostTypeScreen(
            type: routeData.pathParameters['type']!,
          ),
        ),
    '/post/:postId/comments': (route) => MaterialPage(
          child: CommentScreen(
            postId: route.pathParameters['postId']!,
          ),
        ),
  },
);
