import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/asset_path.dart';

class STFProductItemWidget extends StatelessWidget {
  final String productName;
  final String brandName;
  final String price;
  final String originalPrice;
  final String imagePath;

  const STFProductItemWidget({
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
      height: 120,
      width: 115,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            width: 115,
            height: 120 * 0.65,
            fit: BoxFit.cover,
            'https://magento-1231949-4398885.cloudwaysapps.com/media/catalog/product/${imagePath}',
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
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
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Text('Failed to load image');
            },
          ),
          // Image.asset(
          //   'https://magento-1231949-4398885.cloudwaysapps.com/media/catalog/product/${imagePath}',
          //   width: 115,
          //   height: 120 * 0.65,
          //   fit: BoxFit.cover,
          // ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName, // menggunakan productName yang diteruskan
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lora(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      brandName, // menggunakan brandName yang diteruskan
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
                "\$$price", // menggunakan harga yang diteruskan
                style: GoogleFonts.lora(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "\$$originalPrice", // menggunakan harga asli yang diteruskan
                style: GoogleFonts.lora(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.5),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
