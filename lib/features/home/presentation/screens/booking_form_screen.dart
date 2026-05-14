import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';
import 'package:kisan_app/features/home/domain/entities/tractor_entity.dart';
import 'package:kisan_app/features/home/presentation/screens/home_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final TractorEntity tractor;
  final VoidCallback onBack;

  const BookingFormScreen({
    super.key,
    required this.tractor,
    required this.onBack,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  late String selectedService;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _acresController = TextEditingController(
    text: '1',
  );
  final TextEditingController _noteController = TextEditingController();
  String selectedTime = '7:00 AM';
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    selectedService = widget.tractor.services.isNotEmpty
        ? widget.tractor.services[0]
        : 'all';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _villageController.dispose();
    _dateController.dispose();
    _acresController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _villageController.text.isNotEmpty &&
        _dateController.text.isNotEmpty) {
      setState(() {
        _submitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return _buildSuccessScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'बुकिंग करें',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            Text(
              '${widget.tractor.ownerName} • ${widget.tractor.model}',
              style: const TextStyle(color: AppColors.gray500, fontSize: 12),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.gray200, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(
              title: 'सेवा चुनें',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.tractor.services.map((sId) {
                  final svc = services.firstWhere(
                    (e) => e.id == sId,
                    orElse: () => ServiceItem(
                      id: sId,
                      label: sId,
                      icon: '🚜',
                      color: Colors.grey,
                    ),
                  );
                  final isSelected = selectedService == sId;
                  return GestureDetector(
                    onTap: () => setState(() => selectedService = sId),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? svc.color.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? svc.color : AppColors.gray200,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '${svc.icon} ${svc.label}',
                        style: TextStyle(
                          color: isSelected ? svc.color : AppColors.gray600,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            _buildSection(
              title: 'आपकी जानकारी',
              child: Column(
                children: [
                  _buildTextField(
                    'आपका नाम *',
                    _nameController,
                    'पूरा नाम दर्ज करें',
                  ),
                  _buildTextField(
                    'मोबाइल नंबर *',
                    _phoneController,
                    '10 अंक का नंबर',
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    'गाँव / मोहल्ला *',
                    _villageController,
                    'अपना गाँव या मोहल्ला',
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'तारीख और समय',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'तारीख *',
                          _dateController,
                          'Select Date',
                          isDate: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'समय',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.gray600,
                              ),
                            ),
                            4.height,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.gray300,
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedTime,
                                  items:
                                      [
                                            "5:00 AM",
                                            "6:00 AM",
                                            "7:00 AM",
                                            "8:00 AM",
                                            "9:00 AM",
                                            "10:00 AM",
                                            "2:00 PM",
                                            "3:00 PM",
                                          ]
                                          .map(
                                            (t) => DropdownMenuItem(
                                              value: t,
                                              child: Text(t),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      setState(() => selectedTime = val!),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'एकड़ (अनुमानित)',
                    _acresController,
                    'जैसे: 2',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'अतिरिक्त जानकारी (वैकल्पिक)',
              child: TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      'जैसे: खेत नंबर, रास्ते की जानकारी, फसल का प्रकार...',
                  hintStyle: const TextStyle(
                    color: AppColors.gray400,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.gray300,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.amberLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFE082)),
              ),
              child: const Row(
                children: [
                  Text('ℹ️', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'यह सेवा बिल्कुल मुफ्त है। कोई शुल्क नहीं।',
                      style: TextStyle(color: AppColors.amber, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '📅 बुकिंग कन्फर्म करें',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.gray800,
            ),
          ),
          12.height,
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    bool isDate = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.gray600),
        ),
        4.height,
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: isDate,
          onTap: isDate
              ? () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    controller.text = "${date.year}-${date.month}-${date.day}";
                  }
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.gray400, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.gray300,
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSuccessScreen() {
    return Scaffold(
      backgroundColor: AppColors.greenPale,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 80)),
              const SizedBox(height: 16),
              const Text(
                'बुकिंग हो गई!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                ),
              ),
              const Text(
                'Booking Successful!',
                style: TextStyle(color: AppColors.primary, fontSize: 15),
              ),
              const SizedBox(height: 8),
              const Text(
                'को आपकी बुकिंग की सूचना भेज दी गई है। वे जल्द ही संपर्क करेंगे।',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray600, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.gray200),
                ),
                child: Column(
                  children: [
                    const Text(
                      'बुकिंग नंबर',
                      style: TextStyle(color: AppColors.gray500, fontSize: 12),
                    ),
                    Text(
                      'BK${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: widget.onBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'होम पर जाएं',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
