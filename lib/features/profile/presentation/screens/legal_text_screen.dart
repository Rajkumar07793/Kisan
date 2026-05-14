import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_it/get_it.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/localization/locale_bloc.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';

import '../../domain/repositories/app_content_repository.dart';

class LegalTextScreen extends StatefulWidget {
  final String title;
  final String? htmlContent;
  final String? slug;

  const LegalTextScreen({
    super.key,
    required this.title,
    this.htmlContent,
    this.slug,
  });

  @override
  State<LegalTextScreen> createState() => _LegalTextScreenState();
}

class _LegalTextScreenState extends State<LegalTextScreen> {
  late Future<String> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = _loadContent();
  }

  Future<String> _loadContent() async {
    if (widget.slug != null) {
      final repository = GetIt.instance<AppContentRepository>();
      final String languageCode = context
          .read<LocaleBloc>()
          .state
          .locale
          .languageCode;

      final result = await repository.getContent(
        widget.slug!,
        languageCode: languageCode,
      );
      return result.fold(
        (failure) => '<h1>Error</h1><p>Failed to load content.</p>',
        (content) => content.contentHtml,
      );
    }
    return widget.htmlContent ?? '<h1>No Content</h1>';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: widget.title, showBackButton: true),
      body: FutureBuilder<String>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final content = snapshot.data ?? '<h1>No Content</h1>';

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HtmlWidget(
                  content,
                  textStyle: context.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: AppColors.color5A5C5C,
                  ),
                  customStylesBuilder: (element) {
                    if (element.localName == 'h1' ||
                        element.localName == 'h2') {
                      return {
                        'color':
                            '#${AppColors.primary.value.toRadixString(16).substring(2)}',
                        'font-weight': 'bold',
                        'margin-bottom': '12px',
                        'margin-top': '24px',
                      };
                    }
                    return null;
                  },
                ),
                40.height,
              ],
            ),
          );
        },
      ),
    );
  }
}
