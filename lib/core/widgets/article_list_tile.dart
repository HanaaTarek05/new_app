import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ArticleListTile extends StatelessWidget {
  final String title;
  final String? category;
  final String? author;
  final String? date;
  final String? authorAvatar;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ArticleListTile({
    super.key,
    required this.title,
    this.category,
    this.author,
    this.date,
    this.authorAvatar,
    required this.imageUrl,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (category != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      category!,
                      style: const TextStyle(
                        fontFamily: 'Lexend_Deca',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Lexend_Deca',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                if (author != null || date != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (authorAvatar != null) ...[
                        CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(authorAvatar!),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          [
                            if (author != null) author,
                            if (date != null) date,
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Lexend_Deca',
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported_rounded, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
