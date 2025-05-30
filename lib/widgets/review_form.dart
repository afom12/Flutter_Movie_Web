



import 'package:flutter/material.dart';
import '../models/review.dart';

class ReviewForm extends StatefulWidget {
  final Function(Review) onSubmit;

  const ReviewForm({super.key, required this.onSubmit});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _commentController = TextEditingController();
  double _rating = 4.0;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newReview = Review(
        user: _userController.text.trim(),
        comment: _commentController.text.trim(),
        rating: _rating,
      );
      widget.onSubmit(newReview);
      _userController.clear();
      _commentController.clear();
      setState(() {
        _rating = 4.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Write a Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (val) => val == null || val.isEmpty ? 'Name required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(labelText: 'Your Review'),
                validator: (val) => val == null || val.isEmpty ? 'Review required' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Rating:'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Slider(
                      value: _rating,
                      onChanged: (val) => setState(() => _rating = val),
                      min: 1.0,
                      max: 5.0,
                      divisions: 4,
                      label: '${_rating.toStringAsFixed(1)} ⭐',
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
