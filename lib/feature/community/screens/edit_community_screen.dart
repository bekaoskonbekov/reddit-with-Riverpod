import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/common/loader.dart';
import 'package:reddit/core/const/const.dart';
import 'package:reddit/core/theme/palette.dart';
import 'package:reddit/feature/community/controller/community_controller.dart';
import 'package:reddit/feature/models/community_model.dart';
import '../../../core/util.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({required this.name, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.single.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profileFile = File(res.files.single.path!);
      });
    }
  }

  void save(CommunityModel community) {
    ref.read(communityControllerProvider.notifier).editCommunity(
          profileFile: profileFile,
          bannerFile: bannerFile,
          community: community,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
              appBar: AppBar(
                backgroundColor: currentTheme.backgroundColor,
                title: Text("Edit Community"),
                centerTitle: true,
                actions: [
                  TextButton(
                      onPressed: () => save(community), child: Text('Save')),
                ],
              ),
              body: isLoading
                  ? Loader()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () => selectBannerImage(),
                                  child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      dashPattern: [10, 4],
                                      strokeCap: StrokeCap.round,
                                      color: Pallete.darkModeAppTheme.textTheme
                                          .bodyText2!.color!,
                                      child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: bannerFile != null
                                              ? Image.file(bannerFile!)
                                              : community.banner.isEmpty ||
                                                      community.banner ==
                                                          Constants
                                                              .bannerDefault
                                                  ? Center(
                                                      child: Icon(Icons
                                                          .add_a_photo_outlined),
                                                    )
                                                  : Image.network(
                                                      community.banner,
                                                      fit: BoxFit.cover,
                                                    ))),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: GestureDetector(
                                      onTap: () => selectProfileImage(),
                                      child: profileFile != null
                                          ? CircleAvatar(
                                              radius: 32,
                                              backgroundImage:
                                                  FileImage(profileFile!),
                                            )
                                          : CircleAvatar(
                                              radius: 32,
                                              backgroundImage: NetworkImage(
                                                  community.avatar),
                                            )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Loader(),
        );
  }
}
