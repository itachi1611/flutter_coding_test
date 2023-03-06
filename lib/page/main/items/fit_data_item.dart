import 'package:flutter/material.dart';
import 'package:flutter_temp/page/main/items/favour_item.dart';

import '../../../models/responses/fit_response.dart';
import 'fit_data_detail_page.dart';

class FitDataItem extends StatelessWidget {
  final FitResponse fitResponse;

  const FitDataItem({
    Key? key,
    required this.fitResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return FitDataDetailPage(fitResponse: fitResponse);
        }));
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Hero(
                tag: fitResponse.id!,
                child: Image.network(
                  fitResponse.thumb ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ));
                  },
                ),
              ),
              title: Text(fitResponse.name ?? ''),
              subtitle: Text(fitResponse.headline ?? ''),
              isThreeLine: true,
              trailing: const FavourItem(),
            ),
          ],
        ),
      ),
    );
  }
}
