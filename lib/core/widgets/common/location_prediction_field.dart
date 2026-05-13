import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kisan_app/core/network/location_service.dart';
import 'package:kisan_app/core/widgets/common/custom_text_field.dart';

class LocationPredictionField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final Function(LocationPrediction) onSelected;

  const LocationPredictionField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon = Icons.location_on_outlined,
    required this.onSelected,
  });

  @override
  State<LocationPredictionField> createState() =>
      _LocationPredictionFieldState();
}

class _LocationPredictionFieldState extends State<LocationPredictionField> {
  final LocationService _locationService = GetIt.instance<LocationService>();
  List<LocationPrediction> _predictions = [];
  bool _isLoading = false;
  Timer? _debounce;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.length < 3) {
        _hideOverlay();
        return;
      }

      setState(() => _isLoading = true);
      final results = await _locationService.getPredictions(query);
      setState(() {
        _predictions = results;
        _isLoading = false;
      });

      if (_predictions.isNotEmpty) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  void _showOverlay() {
    _hideOverlay();
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _predictions.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final prediction = _predictions[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 20,
                    ),
                    title: Text(
                      prediction.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      [
                        prediction.city,
                        prediction.country,
                      ].where((e) => e.isNotEmpty).join(', '),
                      style: const TextStyle(fontSize: 12),
                    ),
                    onTap: () {
                      widget.controller.text = prediction.fullAddress;
                      widget.onSelected(prediction);
                      _hideOverlay();
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CustomTextField(
        controller: widget.controller,
        label: widget.label,
        hint: widget.hint,
        prefixIcon: Icon(widget.prefixIcon, color: Colors.grey, size: 20),
        suffixIcon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : null,
        onChanged: _onSearchChanged,
      ),
    );
  }
}
