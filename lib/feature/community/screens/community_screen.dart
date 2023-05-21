// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/feature/community/controller/community_controller.dart';
import 'package:reddit/feature/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../auth/controller/auth_controller.dart';
import '../../post/screens/post_card.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({
    Key? key,
    required this.name,
  }) : super(key: key);
  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/mod-tools/$name');
  }

  void joinCommunity(
      WidgetRef ref, CommunityModel community, BuildContext context) {
    ref
        .read(communityControllerProvider.notifier)
        .joinCommunity(community, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
          data: (community) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 150,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                            child: Image.network(community.banner,
                                fit: BoxFit.cover))
                      ],
                    ),
                    title: Text(community.name),
                    centerTitle: true,
                    floating: true,
                    snap: true,
                  ),
                  SliverPadding(
                      padding: EdgeInsets.all(10),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(community.avatar),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'r/${community.name}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              community.mods.contains(user.uid)
                                  ? OutlinedButton(
                                      onPressed: () {
                                        navigateToModTools(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25)),
                                      child: Text("Mod tools"),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        joinCommunity(ref, community, context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25)),
                                      child: Text(
                                          community.members.contains(user.uid)
                                              ? "Joined"
                                              : "Join"),
                                    )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child:
                                  Text("${community.members.length} members")),
                        ]),
                      ))
                ];
              },
              body: ref.watch(getCommunityPostProvider(name)).when(
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
