import 'package:flutter/material.dart';

class FavourItem extends StatefulWidget {
  const FavourItem({Key? key}) : super(key: key);

  @override
  State<FavourItem> createState() => _FavourItemState();
}

class _FavourItemState extends State<FavourItem> {
  late bool isFavour;

  @override
  void initState() {
    super.initState();
    isFavour = false;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => setState(() {
          isFavour = !isFavour;
        }),
        icon: Icon(
          isFavour ? Icons.favorite : Icons.favorite_border,
          color: isFavour ? Colors.red : Colors.black,
        ));
  }
}
