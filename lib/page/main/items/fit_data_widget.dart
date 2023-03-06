import 'package:flutter/material.dart';
import '../../../models/responses/fit_response.dart';
import 'fit_data_item.dart';

class FitDataWidget extends StatelessWidget {
  final List<FitResponse> fits;

  const FitDataWidget({
    Key? key,
    required this.fits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return FitDataItem(fitResponse: fits[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: fits.length,
    );
  }
}
