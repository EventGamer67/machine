import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine/presentation/logic/home_provider.dart';

class MyAppBar extends ConsumerStatefulWidget {
  const MyAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppBarState();
}

class _MyAppBarState extends ConsumerState<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      title: MediaQuery.sizeOf(context).width > 1100
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onLongPress: () async {
                    await ref.read(homeScreenProvider).showLogin(context, ref);
                  },
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 7, left: 15, right: 15, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: SvgPicture.asset(
                        'vdetalax.svg',
                        width: 100,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(homeScreenProvider).scrollController.animateTo(
                          1200,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("Каталог"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(homeScreenProvider).scrollController.animateTo(
                          2200,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("Оставьте заявку"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(homeScreenProvider).scrollController.animateTo(
                          4000,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("Контакты"),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: 7, left: 15, right: 15, bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: SvgPicture.asset(
                      'vdetalax.svg',
                      width: 100,
                    )),
                GestureDetector(
                  onTap: () {
                    ref.read(homeScreenProvider).scrollController.animateTo(
                          1200,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(homeScreenProvider).scrollController.animateTo(
                          2200,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.send_to_mobile,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(homeScreenProvider).scrollController.animateTo(
                          4000,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.call,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
      floating: true,
    );
  }
}
