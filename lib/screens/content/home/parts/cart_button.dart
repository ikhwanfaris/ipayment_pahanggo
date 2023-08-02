part of '../home.dart';

class _CartButton extends StatefulWidget {
  const _CartButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<_CartButton> {
  late StreamSubscription onCartUpdated;
  late Future<CartCountResponse?> cartCountFuture;

  @override
  void initState() {
    super.initState();

    cartCountFuture = Future.value(null);

    onCartUpdated = eventBus.on<CartUpdatedEvent>().listen((event) {
      setState(() {
        if (isLoggedIn()) {
          cartCountFuture = ApiCart().getCount();
        } else {
          cartCountFuture = Future.value(
            CartCountResponse(getGuestCart().count()),
          );
        }
      });
    });

    // fire once to get latest cart item counts
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => eventBus.fire(
        CartUpdatedEvent(),
      ),
    );
  }

  @override
  void dispose() {
    onCartUpdated.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: AppStyles.u1 * 14,
          child: Icon(
            LineIcons.addToShoppingCart,
            color: Constants().primaryColor,
            size: AppStyles.u11,
          ),
        ),
        FutureBuilder<CartCountResponse?>(
          future: cartCountFuture,
          builder: (context, future) {
            if (future.connectionState != ConnectionState.done) {
              return SizedBox.shrink();
            }

            if (future.data == null) {
              return SizedBox.shrink();
            }

            int cartCount = future.data?.count ?? 0;
            String cartCountText =
                cartCount > 100 ? "$cartCount+" : "$cartCount";

            return Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                decoration: AppStyles.decoRounded.copyWith(
                  color: Colors.redAccent,
                ),
                padding: EdgeInsets.all(AppStyles.u1),
                child: Text(
                  cartCountText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
