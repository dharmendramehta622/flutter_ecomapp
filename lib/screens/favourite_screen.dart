import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/blocs/favourite_bloc/favourite_bloc.dart';
import 'package:new_project/resources/constants.dart';
import 'package:new_project/resources/routes.dart';
import 'package:new_project/widgets/custom_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary600,
        title: RegularText('Saved Items', 16, kWhite),
        leading: GestureDetector(
          onTap: () {
            context.go(Routes.landing);
          },
          child: Icon(
            Icons.adaptive.arrow_back,
            color: kWhite,
          ),
        ),
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          switch (state.status) {
            case ListStatus.initial:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ListStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ListStatus.failure:
              return Center(
                  child: RegularText(state.status.toString(), 16, kBlack));
            case ListStatus.success:
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                ),
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final e = state.products[index];
                  return ProductCard(e);
                },
              );
            default:
              throw UnimplementedError('Not a valid state');
          }
        },
      ),
    );
  }
}
