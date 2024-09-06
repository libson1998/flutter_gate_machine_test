// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ItemCaution extends StatefulWidget {
  String? itemName;
  String? itemDescription;

  ItemCaution({super.key, this.itemName, this.itemDescription});

  @override
  State<ItemCaution> createState() => _ItemCautionState();
}

class _ItemCautionState extends State<ItemCaution> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(
              0.0,
              6.0,
            ),
            blurRadius: 30,
            spreadRadius: 10,
          ),
          //BoxShadow
          //BoxShadow
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.itemName!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      "assets/icons/close-circle.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.itemDescription!,
              style: TextStyle(
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
