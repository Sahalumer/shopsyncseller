import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/profile/views/screens/add_edit_main_view.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class BeforeSaveDetails extends StatelessWidget {
  const BeforeSaveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is FetchSuccess) {
          return Column(
            children: [
              Text(
                "Hello, ${state.userModel.username}! You don't have a store yet. Add your store details to unlock more features, such as listing products, receiving orders, and chatting with customers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: size.scaledHeight(3),
              ),
              InkWell(
                onTap: () => CustomNavigator.goTo(
                    context,
                    AddEditMainView(
                      uid: state.userModel.uid!,
                    )),
                child: Container(
                  height: size.scaledHeight(6),
                  decoration: BoxDecoration(
                    color: AppColors().appBlack,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      "Add Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
