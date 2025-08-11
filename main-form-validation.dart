import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Demo',
      home: const MyFormPage(),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  // Key to identify the form and access its state
  final _formKey = GlobalKey<FormState>();

  // Controllers to read input values if needed
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Validate returns true if the form is valid
    if (_formKey.currentState!.validate()) {
      // If valid, you can do what you want here, e.g., send data to backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form is valid! Sending data...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Validation Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            children: [
              // Email input field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // Validator function returns null if input is valid,
                  // or a string error message if invalid
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  // Basic email validation check
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null; // means input is valid
                },
              ),
              const SizedBox(height: 16),
              // Password input field
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                obscureText: true, // hide input for passwords
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
