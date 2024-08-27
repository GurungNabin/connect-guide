import 'package:connect_me_app/core/ui/colors.dart';
import 'package:connect_me_app/presentation/view/features/bottom_navigation/mybottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final middleContainerHeight = screenHeight / 8;

    return Scaffold(
      backgroundColor: AppTheme.colorBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              // bottom container
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: screenHeight / 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.colorLightGrey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
              ),

              // Middle container
              Positioned(
                bottom: middleContainerHeight,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.colorWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.colorWhite,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // name
                              TextFormField(
                                controller: _nameController,
                                decoration:  InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(color: AppTheme.colorBlack),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.textFieldColor,
                                  filled: true,
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your name';
                                //   }
                                //   return null;
                                // },
                              ),
                              const Gap(16),
                              // email
                              TextFormField(
                                controller: _emailController,
                                decoration:  InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: AppTheme.colorBlack),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.textFieldColor,
                                  filled: true,
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your email';
                                //   }
                                //   return null;
                                // },
                              ),
                              const Gap(16),
                              // address
                              TextFormField(
                                controller: _addressController,
                                decoration:  InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: TextStyle(color: AppTheme.colorBlack),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.textFieldColor,
                                  filled: true,
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your address';
                                //   }
                                //   return null;
                                // },
                              ),
                              const Gap(16),
                              // phone
                              TextFormField(
                                controller: _phoneController,
                                decoration:  InputDecoration(
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(color: AppTheme.colorBlack),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.textFieldColor,
                                  filled: true,
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your phone number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const Gap(16),
                              // password
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration:  InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: AppTheme.colorBlack),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.textFieldColor,
                                  filled: true,
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your password';
                                //   }
                                //   return null;
                                // },
                              ),
                              const Gap(16),

                              Column(
                                children: [
                                  const Text(
                                    'By continuing, you agree to our Terms and Conditions.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const Gap(8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Checkbox(
                                          value: _isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _isChecked = value ?? false;
                                            });
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                      const Text(
                                        ' I agree to the Terms and Conditions',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: () {
                                        // if (_formKey.currentState?.validate() ??
                                        //     false) {
                                        //   // Proceed with registration
                                        // }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavBar(),
                                          ),
                                        );
                                      },
                                      child:  Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: AppTheme.colorWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
