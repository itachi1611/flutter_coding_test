import 'package:flutter/material.dart';

class ItemInfo extends StatefulWidget {
  final String title;
  final String firstTitle;
  final String secondTitle;
  final String firstValue;
  final String secondValue;

  const ItemInfo({
    Key? key,
    required this.title,
    required this.firstTitle,
    required this.secondTitle,
    required this.firstValue,
    required this.secondValue,
  }) : super(key: key);

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  late bool isOpen;

  @override
  void initState() {
    isOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.title),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_circle),
                ),
              ],
            )),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
          firstChild: Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            height: 50,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Image.asset(widget.firstTitle),
                      const SizedBox(width: 10),
                      Text(widget.firstValue)
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Image.asset(widget.secondTitle),
                      const SizedBox(width: 10),
                      Text(widget.secondValue)
                    ],
                  ),
                ),
              ],
            ),
          ),
          secondChild: const SizedBox(),
          crossFadeState:
          isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ],
    );
  }
}