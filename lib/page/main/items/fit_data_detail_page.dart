import 'package:flutter/material.dart';

import '../../../common/app_images.dart';
import '../../../models/responses/fit_response.dart';
import 'item_info.dart';

class FitDataDetailPage extends StatelessWidget {
  final FitResponse fitResponse;

  const FitDataDetailPage({
    Key? key,
    required this.fitResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topLeft,
          child: ListView(
            children: [
              Hero(
                tag: fitResponse.id!,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AspectRatio(
                      aspectRatio: 9 / 8,
                      child: Image.network(
                        fitResponse.image ?? '',
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '# ${fitResponse.name}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Text(
                  fitResponse.headline ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                fitResponse.description ?? '',
                style: const TextStyle(
                    color: Colors.black, fontSize: 18, wordSpacing: 5),
              ),
              const Divider(
                height: 80,
                thickness: 0.5,
                color: Colors.black,
                indent: 40,
                endIndent: 40,
              ),
              ItemInfo(
                title: 'Calories'.toUpperCase(),
                firstTitle: AppImages.icCalories,
                firstValue: fitResponse.calories ?? '',
                secondTitle: AppImages.icProtein,
                secondValue: fitResponse.proteins ?? '',
              ),
              const SizedBox(height: 10),
              ItemInfo(
                title: 'Others'.toUpperCase(),
                firstTitle: AppImages.icCarbon,
                firstValue: fitResponse.carbos ?? '',
                secondTitle: AppImages.icFats,
                secondValue: fitResponse.fats ?? '',
              ),
              const Divider(
                height: 80,
                thickness: 0.5,
                color: Colors.black,
                indent: 40,
                endIndent: 40,
              ),
              Text('Duration ${fitResponse.time!.substring(2, fitResponse.time!.length - 1)} mins'),
            ],
          )),
    );
  }
}