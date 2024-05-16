import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olx_app/utils/extension/sized_box_extension.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GalleryView extends StatefulWidget {
  final String carName;
  final String description;
  final String price;
  final String carPhotoPath;
  final bool isTop;
  final bool isNew;
  final String location;

  const GalleryView({
    super.key,
    required this.carName,
    required this.description,
    required this.price,
    required this.carPhotoPath,
    required this.isTop,
    required this.isNew,
    required this.location,
  });

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        children: [
          /// product photo
          Container(
            alignment: Alignment.bottomLeft,
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.r),
                topLeft: Radius.circular(5.r),
              ),
              image: DecorationImage(
                image: AssetImage(widget.carPhotoPath),
                fit: BoxFit.cover,
              ),
            ),

            /// top container
            child: Container(
              height: widget.isTop ? 20.h : 0,
              width: widget.isTop ? 50.w : 0,
              decoration: BoxDecoration(
                color: const Color(0xFF1EE1D7),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(3.r),
                ),
              ),
              child: const Center(
                child: Text(
                  'TOP',
                  style: TextStyle(
                    color: Color(0xFF002D32),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 8.w, right: 8.w, top: 15.h, bottom: 10.h),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.carName,
                    style: TextStyle(
                      color: const Color(0xFF052D32),
                      fontWeight: FontWeight.w700,
                      fontSize: 17.sp,
                    ),
                  ),
                  Row(
                    children: [
                      /// car description
                      Expanded(
                        child: Text(
                          widget.description,
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF052D32),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      20.width(),
                      ZoomTapAnimation(
                        onTap: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                        child: Icon(
                          isPressed
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                        ),
                      ),
                    ],
                  ),
                  10.height(),

                  /// container for new cars
                  if (widget.isNew)
                    Container(
                      height: 25.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F4),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: const Center(
                        child: Text(
                          'Yangi',
                          style: TextStyle(
                            color: Color(0xFF002D32),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (widget.isNew) 10.height(),

                  /// car price
                  Text(
                    widget.price,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color(0xFF002D32),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  5.height(),
                  Text(
                    widget.location,
                    style: TextStyle(
                      color: const Color(0xFF002D32).withOpacity(0.8),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
