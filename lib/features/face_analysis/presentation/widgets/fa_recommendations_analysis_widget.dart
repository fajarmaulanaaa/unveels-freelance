import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../product/product_model_lipstick.dart';
import '../../../product/product_model_look.dart';
import '../../../product/product_model_perfume.dart';
import '../cubit/fa_bloc.dart';
import 'fa_product_item_widget.dart';

class FaRecommendationsAnalysisWidget extends StatelessWidget {
  final FaState faState;

  const FaRecommendationsAnalysisWidget({super.key, required this.faState});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductItemWidget(
            title: "Perfumes Recommendations",
            faState: faState.productModelPerfume,
          ),
          const SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Look Recommendations",
            description:
            "A bold red lipstick and defined brows, mirror your strong, vibrant personality",
            faState: faState.productModelLook,
          ),
          const SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Lip Color Recommendations",
            description: "The best lip color for you are orange shades",
            faState: faState.productModelLip,
          ),
        ],
      ),
    );
  }
}

class _ProductItemWidget extends StatelessWidget {
  final String title;
  final String? description;
  final dynamic faState; // Change to dynamic type to handle different product models

  const _ProductItemWidget({
    required this.title,
    required this.faState,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Determine which product model is being passed in
    final items = _getItemsBasedOnProductType(faState);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (description != null) ...[
                const SizedBox(
                  height: 6,
                ),
                Text(
                  description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 242,
          child: ListView.separated(
            itemCount: items.length, // Use the filtered list length
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              final isFirst = index == 0;
              final isEnd = index == items.length - 1;

              // Extracting item properties
              final item = items[index];
              final productName = item.name;
              final brandName = "Brand Name"; // Modify if you have brand info
              final price = item.price?.toString();
              final originalPrice = item.price?.toString(); // Same as price for now
              final imagePath = item.mediaGalleryEntries[0].file;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? SizeConfig.horizontalPadding : 0,
                  right: isEnd ? SizeConfig.horizontalPadding : 0,
                ),
                child: FAProductItemWidget(
                  productName: productName,
                  brandName: brandName,
                  price: price!,
                  originalPrice: originalPrice!,
                  imagePath: imagePath,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // This method returns the appropriate list of items based on the product type
  List<dynamic> _getItemsBasedOnProductType(dynamic faState) {
    if (faState is ProductModelLip) {
      return faState.items!; // Assuming ProductModelLip has 'items'
    } else if (faState is ProductModelPerfume) {
      return faState.items!; // Assuming ProductModelPerfume has 'items'
    } else if (faState is ProductModelLook) {
      return faState.items!; // Assuming ProductModelLook has 'items'
    }
    return []; // Return an empty list if the product model is not recognized
  }
}