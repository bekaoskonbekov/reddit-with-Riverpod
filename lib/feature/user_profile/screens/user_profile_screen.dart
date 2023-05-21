import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/common/error_text.dart';
import 'package:reddit/core/common/loader.dart';
import 'package:reddit/feature/auth/controller/auth_controller.dart';
import 'package:reddit/feature/post/screens/post_card.dart';
import 'package:reddit/feature/user_profile/controller/user_profile_controller.dart';
import 'package:routemaster/routemaster.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({required this.uid, Key? key}) : super(key: key);

  void navigateToEditProfile(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
          data: (user) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                            child:
                                Image.network(user.banner, fit: BoxFit.cover)),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(user.profilePic),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(20).copyWith(bottom: 20),
                          child: OutlinedButton(
                            onPressed: () => navigateToEditProfile(context),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 25)),
                            child: Text("Edit Profile"),
                          ),
                        )
                      ],
                    ),
                    title: Text(user.name),
                    centerTitle: true,
                    floating: true,
                    snap: true,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'u/${user.name}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text("${user.karma} karma")),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                          )
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: ref.watch(getUserPostProvider(uid)).when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final post = data[index];
                        return PostCard(post: post);
                      },
                    );
                  },
                  error: (error, stackTrace) => Center(
                        child: ErrorText(
                          error: error.toString(),
                        ),
                      ),
                  loading: () => const Loader())),
          error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
