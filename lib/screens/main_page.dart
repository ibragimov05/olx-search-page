import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olx_app/screens/views/cars_info/cars_info.dart';
import 'package:olx_app/screens/views/gallery_view.dart';
import 'package:olx_app/screens/views/list_view.dart';
import 'package:olx_app/screens/views/mosaic_view.dart';
import 'package:olx_app/utils/extension/sized_box_extension.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> iconData = [
    {
      'icon': Icons.storefront_rounded,
      'iconText': 'E\'lonlar',
    },
    {
      'icon': Icons.favorite_border_rounded,
      'iconText': 'Saralangan',
    },
    {
      'icon': Icons.add_circle_outline_rounded,
      'iconText': 'E\'lon bering',
    },
    {
      'icon': Icons.chat_bubble_outline,
      'iconText': 'Suhbatlar',
    },
    {
      'icon': Icons.person_2_outlined,
      'iconText': 'Profilim',
    }
  ];

  List iconsOfPopUpMenuButton = [
    const Icon(Icons.view_stream_outlined),
    'assets/icons/list.png',
    'assets/icons/application.png',
  ];

  int pageNumber = 0;
  bool isCompared = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CarsInfoLs.listOfProductsSale.sort(
      (a, b) => a['carName'].compareTo(
        b['carName'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F5),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 50.h),
        child: ListView(
          children: [
            /// text field for search
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: const TextField(
                cursorHeight: 20,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 40),
                  suffixIcon: Icon(Icons.favorite_border_rounded),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Nimani qidiryapsiz?',
                ),
              ),
            ),
            20.height(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Biz 1000 dan ortiq e\'lon topdik',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF002F34),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        /// sorting cars according to car name
                        setState(() {
                          if (!isCompared) {
                            CarsInfoLs.listOfProductsSale.sort(
                              (a, b) => a['carName'].compareTo(
                                b['carName'],
                              ),
                            );
                          } else {
                            CarsInfoLs.listOfProductsSale.sort(
                              (a, b) => b['carName'].compareTo(
                                a['carName'],
                              ),
                            );
                          }

                          isCompared = !isCompared;
                        });
                      },
                      child: Image.asset(
                        'assets/icons/up-down.png',
                        height: 18.h,
                        width: 18.w,
                      ),
                    ),
                    10.width(),

                    /// PopupMenuButton
                    PopupMenuButton<int>(
                      icon: pageNumber == 0
                          ? const Icon(Icons.view_stream_outlined)
                          : Image.asset(
                              pageNumber == 1
                                  ? iconsOfPopUpMenuButton[1]
                                  : iconsOfPopUpMenuButton[2],
                              height: 20.h,
                              width: 20.w,
                            ),
                      color: Colors.white,
                      onSelected: (value) {
                        setState(() {
                          pageNumber = value;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Galereya"),
                              10.width(),
                              if (pageNumber == 0) const Icon(Icons.check)
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Ro'yxat"),
                              10.width(),
                              if (pageNumber == 1) const Icon(Icons.check)
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Mozaika"),
                              10.width(),
                              if (pageNumber == 2) const Icon(Icons.check)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            /// creating products depending on choose PopupMenuButton
            for (var each in CarsInfoLs.listOfProductsSale)
              if (pageNumber == 0)
                GalleryView(
                  carName: each['carName'],
                  description: each['description'],
                  price: each['price'],
                  carPhotoPath: each['carPhotoPath'],
                  isTop: each['isTop'],
                  isNew: each['isNew'],
                  location: each['location'],
                )
              else if (pageNumber == 1)
                CustomListView(
                  carName: each['carName'],
                  description: each['description'],
                  price: each['price'],
                  carPhotoPath: each['carPhotoPath'],
                  isTop: each['isTop'],
                  isNew: each['isNew'],
                  location: each['location'],
                ),

            if (pageNumber == 2)
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var each in CarsInfoLs.listOfProductsSale)
                    MosaicView(
                      carName: each['carName'],
                      description: each['description'],
                      price: each['price'],
                      carPhotoPath: each['carPhotoPath'],
                      isTop: each['isTop'],
                      isNew: each['isNew'],
                      location: each['location'],
                    ),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 55.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var each in iconData)
              iconButtonCreator(
                icon: each['icon'],
                iconText: each['iconText'],
              ),
          ],
        ),
      ),
    );
  }

  Widget iconButtonCreator({
    required IconData icon,
    required String iconText,
  }) {
    return Column(
      children: [
        ZoomTapAnimation(
          onTap: () {},
          child: Icon(
            icon,
            size: 20.sp,
          ),
        ),
        Text(
          iconText,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF002F34),
          ),
        ),
      ],
    );
  }
}
