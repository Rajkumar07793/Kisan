import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/services/injection_container.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';
import 'package:kisan_app/core/widgets/common/custom_loader.dart';
import 'package:kisan_app/features/profile/presentation/bloc/faqs/faqs_bloc.dart';
import 'package:kisan_app/features/profile/presentation/bloc/faqs/faqs_event.dart';
import 'package:kisan_app/features/profile/presentation/bloc/faqs/faqs_state.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FaqsBloc>()..add(FetchFaqs()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: CustomAppBar(title: context.l10n.faqs, showBackButton: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [30.heightBox, _buildFaqList(context), 40.heightBox],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqList(BuildContext context) {
    return BlocBuilder<FaqsBloc, FaqsState>(
      builder: (context, state) {
        if (state is FaqsLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: CustomLoader(),
            ),
          );
        }

        if (state is FaqsError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  16.heightBox,
                  ElevatedButton(
                    onPressed: () => context.read<FaqsBloc>().add(FetchFaqs()),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is FaqsLoaded) {
          if (state.faqs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(context.l10n.noResultsFound),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.faqs.length,
            itemBuilder: (context, index) {
              final faq = state.faqs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: ExpansionTile(
                  title: Text(
                    faq.question,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                  ),
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                  collapsedShape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                  ),
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          faq.answer,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.color64748B,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
