import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/app_database_constants.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/ui_feedback.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';
import 'package:kisan_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/widgets/common/custom_text_field.dart';
import '../../../auth/presentation/widgets/common_button.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitInquiry() async {
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    if (subject.isEmpty || message.isEmpty) {
      UIFeedback.showSnackbar(
        context,
        'Please fill in all fields',
        isError: true,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final supabase = GetIt.instance<SupabaseClient>();
      final userId = context.read<AuthBloc>().state.user?.id;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await supabase.from(AppDatabaseConstants.contactUsTable).insert({
        'user_id': userId,
        'title': subject,
        'message': message,
      });

      if (mounted) {
        UIFeedback.showSnackbar(context, 'Inquiry sent successfully!');
        _subjectController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        UIFeedback.showSnackbar(
          context,
          'Failed to send inquiry: ${e.toString()}',
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(title: context.l10n.contactUs, showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [32.heightBox, _buildContactForm(context), 40.heightBox],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Subject',
          controller: _subjectController,
          hint: "Subject",
        ),
        CustomTextField(
          label: 'Message',
          hint: "Type your message here...",
          controller: _messageController,
          maxLines: 5,
        ),
        50.heightBox,
        CustomGradientButton(
          text: "Send",
          isLoading: _isSubmitting,
          onTap: () => _submitInquiry(),
        ),
      ],
    );
  }
}
