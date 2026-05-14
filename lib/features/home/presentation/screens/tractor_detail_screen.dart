import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/features/home/domain/entities/tractor_entity.dart';
import 'package:kisan_app/features/home/presentation/screens/home_screen.dart';

class TractorDetailScreen extends StatelessWidget {
  final TractorEntity tractor;
  final VoidCallback onBack;
  final Function(TractorEntity) onBook;

  const TractorDetailScreen({
    super.key,
    required this.tractor,
    required this.onBack,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          // 1. Gradient Header
          Container(
            // height: 250,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '← वापस',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(tractor.image, style: const TextStyle(fontSize: 64)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tractor.ownerName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            tractor.model,
                            style: const TextStyle(
                              color: Color(0xFFC8E6C9),
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                '★★★★★',
                                style: TextStyle(
                                  color: AppColors.amber,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tractor.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Overlapping Content
          Positioned.fill(
            top: 200, // Starts overlapping the header
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.gray200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildFeatureBox('इंजन', tractor.hp),
                            const SizedBox(width: 12),
                            _buildFeatureBox('दर', '₹${tractor.price}'),
                            const SizedBox(width: 12),
                            _buildFeatureBox(
                              'समीक्षा',
                              tractor.reviews.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: AppColors.gray100),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('📍', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${tractor.village}, ${tractor.city}, ${tractor.district}, ${tractor.state}',
                                style: const TextStyle(
                                  color: AppColors.gray700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.gray200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'उपलब्ध सेवाएं',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.gray800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemCount: tractor.services.length,
                          itemBuilder: (context, index) {
                            final sId = tractor.services[index];
                            final svc = services.firstWhere(
                              (e) => e.id == sId,
                              orElse: () => ServiceItem(
                                id: sId,
                                label: sId,
                                icon: '🚜',
                                color: Colors.grey,
                              ),
                            );
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: svc.color.withOpacity(0.08),
                                border: Border.all(
                                  color: svc.color.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    svc.icon,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      svc.label,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.gray800,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: tractor.available
                          ? () => onBook(tractor)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        tractor.available
                            ? '📅 अभी बुक करें (मुफ्त)'
                            : '⏳ अभी उपलब्ध नहीं',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.greenPale,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontSize: 15,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: AppColors.gray500, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
