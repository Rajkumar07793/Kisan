import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/features/home/presentation/screens/booking_form_screen.dart';
import 'package:kisan_app/features/home/presentation/screens/tractor_detail_screen.dart';

class ServiceModel {
  final String id;
  final String label;
  final String labelEn;
  final String icon;
  final Color color;

  ServiceModel({
    required this.id,
    required this.label,
    required this.labelEn,
    required this.icon,
    required this.color,
  });
}

final List<ServiceModel> SERVICES = [
  ServiceModel(
    id: "jutai",
    label: "जुताई",
    labelEn: "Ploughing",
    icon: "🚜",
    color: const Color(0xFF795548),
  ),
  ServiceModel(
    id: "harvesting",
    label: "कटाई",
    labelEn: "Harvesting",
    icon: "🌾",
    color: const Color(0xFFF57F17),
  ),
  ServiceModel(
    id: "ganna",
    label: "गन्ना लोडिंग",
    labelEn: "Sugarcane Loading",
    icon: "🎋",
    color: const Color(0xFF2E7D32),
  ),
  ServiceModel(
    id: "threshing",
    label: "थ्रेशिंग",
    labelEn: "Threshing",
    icon: "🌽",
    color: const Color(0xFFE65100),
  ),
  ServiceModel(
    id: "transport",
    label: "ढुलाई",
    labelEn: "Transport",
    icon: "🚛",
    color: const Color(0xFF1565C0),
  ),
  ServiceModel(
    id: "rotavator",
    label: "रोटावेटर",
    labelEn: "Rotavator",
    icon: "⚙️",
    color: const Color(0xFF6A1B9A),
  ),
  ServiceModel(
    id: "laser_leveling",
    label: "लेज़र लेवलिंग",
    labelEn: "Laser Leveling",
    icon: "📐",
    color: const Color(0xFF00695C),
  ),
  ServiceModel(
    id: "sowing",
    label: "बुआई",
    labelEn: "Sowing",
    icon: "🌱",
    color: const Color(0xFF558B2F),
  ),
];

class TractorModel {
  final int id;
  final String owner;
  final String ownerEn;
  final String phone;
  final String tractorModel;
  final String hp;
  final List<String> services;
  final String village;
  final String city;
  final String district;
  final String state;
  final String country;
  final double rating;
  final int reviews;
  final bool available;
  final String price;
  final String image;
  final bool verified;

  TractorModel({
    required this.id,
    required this.owner,
    required this.ownerEn,
    required this.phone,
    required this.tractorModel,
    required this.hp,
    required this.services,
    required this.village,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.rating,
    required this.reviews,
    required this.available,
    required this.price,
    required this.image,
    required this.verified,
  });
}

final List<TractorModel> DEMO_TRACTORS = [
  TractorModel(
    id: 1,
    owner: "रामलाल यादव",
    ownerEn: "Ramlal Yadav",
    phone: "9876543210",
    tractorModel: "Mahindra 575 DI",
    hp: "47 HP",
    services: ["jutai", "harvesting", "rotavator"],
    village: "सेमरिया",
    city: "जबलपुर",
    district: "जबलपुर",
    state: "मध्य प्रदेश",
    country: "भारत",
    rating: 4.8,
    reviews: 34,
    available: true,
    price: "800/घंटा",
    image: "🚜",
    verified: true,
  ),
  TractorModel(
    id: 2,
    owner: "सुरेश पटेल",
    ownerEn: "Suresh Patel",
    phone: "9812345678",
    tractorModel: "John Deere 5050 D",
    hp: "50 HP",
    services: ["ganna", "transport", "harvesting"],
    village: "पाटन",
    city: "जबलपुर",
    district: "जबलपुर",
    state: "मध्य प्रदेश",
    country: "भारत",
    rating: 4.5,
    reviews: 21,
    available: true,
    price: "1000/घंटा",
    image: "🚜",
    verified: true,
  ),
  TractorModel(
    id: 3,
    owner: "मोहन सिंह",
    ownerEn: "Mohan Singh",
    phone: "9834567890",
    tractorModel: "Swaraj 855 FE",
    hp: "55 HP",
    services: ["jutai", "sowing", "threshing", "laser_leveling"],
    village: "बरेला",
    city: "नरसिंहपुर",
    district: "नरसिंहपुर",
    state: "मध्य प्रदेश",
    country: "भारत",
    rating: 4.2,
    reviews: 15,
    available: false,
    price: "900/घंटा",
    image: "🚜",
    verified: false,
  ),
];

class HomeScreen extends StatefulWidget {
  final String? role;
  const HomeScreen({super.key, this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String filterService = 'all';
  TractorModel? selectedTractor;
  TractorModel? bookingTractor;
  bool showDetail = false;
  bool showBooking = false;

  @override
  Widget build(BuildContext context) {
    if (showBooking && bookingTractor != null) {
      return BookingFormScreen(
        tractor: bookingTractor!,
        onBack: () => setState(() => showBooking = false),
      );
    }

    if (showDetail && selectedTractor != null) {
      return TractorDetailScreen(
        tractor: selectedTractor!,
        onBack: () => setState(() => showDetail = false),
        onBook: (t) => setState(() {
          bookingTractor = t;
          showBooking = true;
          showDetail = false;
        }),
      );
    }

    if (widget.role == 'owner') {
      return _buildOwnerHome();
    }
    return _buildKisanHome();
  }

  Widget _buildKisanHome() {
    final filtered = filterService == 'all'
        ? DEMO_TRACTORS
        : DEMO_TRACTORS
              .where((t) => t.services.contains(filterService))
              .toList();

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 28),
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
                Text(
                  '${context.l10n.welcomeBack} 🙏',
                  style: const TextStyle(
                    color: Color(0xFFA5D6A7),
                    fontSize: 13,
                  ),
                ),
                Text(
                  context.l10n.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  context.l10n.nearbyTractors,
                  style: const TextStyle(
                    color: Color(0xFFC8E6C9),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.gray400,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.searchPlaceholderHome,
                        style: TextStyle(
                          color: AppColors.gray400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                    child: Text(
                      context.l10n.chooseServices,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.gray800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildFilterChip('all', context.l10n.viewAll),
                        ...SERVICES.map(
                          (s) => _buildFilterChip(
                            s.id,
                            s.label,
                            icon: s.icon,
                            color: s.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${context.l10n.nearbyTractors} (${filtered.length})',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.gray800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (filtered.isEmpty)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Column(
                                children: [
                                  Text('😔', style: TextStyle(fontSize: 48)),
                                  Text(
                                    context.l10n.noResultsFound,
                                    style: TextStyle(color: AppColors.gray400),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ...filtered.map(
                            (t) => _TractorCard(
                              tractor: t,
                              onView: () => setState(() {
                                selectedTractor = t;
                                showDetail = true;
                              }),
                              onBook: () => setState(() {
                                bookingTractor = t;
                                showBooking = true;
                              }),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String id,
    String label, {
    String? icon,
    Color? color,
  }) {
    final isSelected = filterService == id;
    final themeColor = color ?? AppColors.primary;

    return GestureDetector(
      onTap: () => setState(() => filterService = id),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? themeColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? themeColor : AppColors.gray300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[Text(icon), const SizedBox(width: 4)],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.gray700,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerHome() {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
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
                Text(
                  '${context.l10n.welcomeBack} 🙏',
                  style: TextStyle(color: Color(0xFFA5D6A7), fontSize: 13),
                ),
                Text(
                  context.l10n.tractorDashboard,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  context.l10n.manageYourTractors,
                  style: TextStyle(color: Color(0xFFC8E6C9), fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'नई बुकिंग',
                        '1',
                        AppColors.amber,
                        AppColors.amberLight,
                        '🔔',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildStatCard(
                        'सक्रिय',
                        '1',
                        AppColors.primary,
                        AppColors.greenPale,
                        '✅',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildStatCard(
                        'पूर्ण',
                        '1',
                        AppColors.blue,
                        AppColors.blueLight,
                        '🏆',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.gray200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.quickActions,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildQuickAction(
                        '🚜',
                        context.l10n.addTractor,
                        context.l10n.registerNewTractor,
                      ),
                      const Divider(height: 1, color: AppColors.gray100),
                      _buildQuickAction(
                        '📋',
                        context.l10n.viewBookings,
                        '1 ${context.l10n.newBookingsPending}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String val,
    Color color,
    Color bg,
    String icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          Text(
            val,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.gray600, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String icon, String label, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.greenPale,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(icon, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray800,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    color: AppColors.gray500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.gray300),
        ],
      ),
    );
  }
}

class _TractorCard extends StatelessWidget {
  final TractorModel tractor;
  final VoidCallback onView;
  final VoidCallback onBook;
  const _TractorCard({
    required this.tractor,
    required this.onView,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: tractor.available ? AppColors.greenPale : AppColors.gray100,
            child: Row(
              children: [
                Text(tractor.image, style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            tractor.owner,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.gray900,
                            ),
                          ),
                          if (tractor.verified) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '✓ ${context.l10n.verified}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '${tractor.tractorModel} • ${tractor.hp}',
                        style: const TextStyle(
                          color: AppColors.gray600,
                          fontSize: 13,
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
                              color: AppColors.gray600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' (${tractor.reviews} ${context.l10n.reviews})',
                            style: const TextStyle(
                              color: AppColors.gray500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: tractor.available
                            ? AppColors.primary
                            : AppColors.gray400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tractor.available
                            ? context.l10n.available
                            : context.l10n.busy,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${tractor.price}',
                      style: const TextStyle(
                        color: AppColors.amber,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('📍', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(
                      '${tractor.village}, ${tractor.city}, ${tractor.district}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tractor.services.map((s) {
                    final svc = SERVICES.firstWhere(
                      (element) => element.id == s,
                    );
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        border: Border.all(color: AppColors.gray200),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${svc.icon} ${svc.label}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.gray700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        onPressed: onView,
                        label: 'विवरण देखें',
                        isOutline: true,
                      ),
                    ),
                    if (tractor.available) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ActionButton(
                          onPressed: onBook,
                          label: '📅 बुक करें',
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isOutline;

  const _ActionButton({
    required this.onPressed,
    required this.label,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isOutline ? Colors.white : AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          border: isOutline
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isOutline ? AppColors.primary : Colors.white,
              fontWeight: isOutline ? FontWeight.w600 : FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
