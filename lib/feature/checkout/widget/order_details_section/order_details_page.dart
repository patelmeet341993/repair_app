import 'package:repair/core/core_export.dart';

class OrderDetailsPage extends StatelessWidget {
  final bool isFromProduct;

  const OrderDetailsPage({Key? key, this.isFromProduct = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isFromProduct ? Container() : ServiceSchedule(),
          isFromProduct ? AddressInformation() : ServiceInformation(),
          isFromProduct ? ProductShowVoucher() : ShowVoucher(),
          isFromProduct ? ProductCartSummery() : CartSummery(),
        ],
      ),
    );
  }
}
