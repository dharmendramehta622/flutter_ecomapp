import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_project/Networks/models/product_model.dart';
import 'package:new_project/resources/constants.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen(this.e, {super.key});
  final ProductModel e;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.network(
                  e.image ?? '',
                  height: 240,
                  width: 240,
                ),
              ),
            ),
            //name and price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * .75,
                    child: RegularText(e.title ?? '', 16, kBlack),
                  ),
                  BoldText('\$${e.price}', 16, kPrimary600),
                ],
              ),
            ),
            const Divider(),
            //reviews
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoldText('Reviews from customers', 18, kBlack),
            ),
            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 36),
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(12);
              },
              itemBuilder: (BuildContext context, int index) {
                return const ReviewItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText('Alex', 16, kBlack),
          RegularText('Aug 8, 2022', 14, kBlack),
          const Gap(4),
          RegularText('3.5', 14, kBlack),
          RegularText('It was really awesome really buy it.', 14, kBlack),
        ],
      ),
    );
  }
}
