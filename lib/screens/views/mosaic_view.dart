import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:olx_app/utils/extension/sized_box_extension.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MosaicView extends StatefulWidget {
  final String carName;
  final String description;
  final String price;
  final String carPhotoPath;
  final bool isTop;
  final bool isNew;
  final String location;

  const MosaicView({
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
  State<MosaicView> createState() => _MosaicViewState();
}

class _MosaicViewState extends State<MosaicView> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.r),
                topRight: Radius.circular(5.r),
              ),
              image: DecorationImage(
                image: AssetImage(widget.carPhotoPath),
                fit: BoxFit.cover,
              ),
            ),
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
            padding: EdgeInsets.only(
              left: 10.0.w,
              right: 5.w,
              top: 10.h,
              bottom: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// car description
                    Container(
                      width: 125,
                      child: Text(
                        widget.carName,
                        style: const TextStyle(
                          color: Color(0xFF052D32),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ZoomTapAnimation(
                          onTap: () {
                            setState(() {
                              isPressed = !isPressed;
                            });
                          },
                          child: Icon(isPressed? Icons.favorite : Icons.favorite_border_rounded),
                        ),
                      ],
                    ),
                  ],
                ),

                /// is new container
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
                Text(
                  widget.price,
                  style: TextStyle(
                    fontSize: widget.isNew ? 15.sp : 18.sp,
                    color: const Color(0xFF002D32),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.location,
                  style: TextStyle(
                    color: const Color(0xFF002D32).withOpacity(0.8),
                    fontSize: widget.isNew ? 10.sp : 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
