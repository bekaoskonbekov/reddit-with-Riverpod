import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/feature/auth/controller/auth_controller.dart';
import 'package:reddit/feature/user_profile/controller/user_profile_controller.dart';

import '../../../core/common/loader.dart';
import '../../../core/const/const.dart';
import '../../../core/theme/palette.dart';
import '../../../core/util.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const EditProfileScreen({required this.uid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

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

  void save() {
    ref.read(userProfileControllerProvider.notifier).editCommunity(
        profileFile: profileFile,
        bannerFile: bannerFile,
        context: context,
        name: nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    final isLoading = ref.watch(userProfileControllerProvider);
    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
              appBar: AppBar(
                backgroundColor: currentTheme.backgroundColor,
                title: Text("Edit Profile"),
                centerTitle: true,
                actions: [
                  TextButton(onPressed: save, child: Text('Save')),
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
                                      color: currentTheme
                                          .textTheme.bodyText2!.color!,
                                      child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: bannerFile != null
                                              ? Image.file(bannerFile!)
                                              : user.banner.isEmpty ||
                                                      user.banner ==
                                                          Constants
                                                              .bannerDefault
                                                  ? Center(
                                                      child: Icon(Icons
                                                          .add_a_photo_outlined),
                                                    )
                                                  : Image.network(
                                                      user.banner,
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
                                              backgroundImage:
                                                  NetworkImage(user.profilePic),
                                            )),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: "Community Name",
                              hintText: " Name",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Pallete.darkModeAppTheme.textTheme
                                        .bodyText2!.color!),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
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
