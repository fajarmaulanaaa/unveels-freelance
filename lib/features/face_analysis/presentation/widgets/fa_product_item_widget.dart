import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';

class FAProductItemWidget extends StatelessWidget {
  final String productName;
  final String brandName;
  final String price;
  final String originalPrice;
  final String imagePath;

  const FAProductItemWidget({
    super.key,
    required this.productName,
    required this.brandName,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 242,
      width: 151,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://magento-1231949-4398885.cloudwaysapps.com/media/catalog/product/$imagePath',
            height: 242 * 0.65,
            width: 151,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Text('Failed to load image'));
            },
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lora(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      brandName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lora(
                        fontSize: 8,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$$price",
                style: GoogleFonts.lora(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SvgPicture.asset(
            IconPath.fourStarsExample,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonWidget(
                  text: "ADD TO CART",
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.white,
                  height: 27,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ButtonWidget(
                  text: "SEE\nIMPROVEMENT",
                  backgroundColor: Colors.white,
                  height: 27,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
