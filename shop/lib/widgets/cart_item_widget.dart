import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {

  final CartItem cartItem;

  CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.productId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Remover produto',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 40
            ),
          ],
        ),
        padding: EdgeInsets.only(right: 16),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Você tem certeza?'),
            content: Text('Quer remover o item do carrinho?'),
            actions: [
              TextButton(
                child: Text('NÃO'),
                onPressed: () {
                  // Fecha o Dialog retornando algum valor a ser passado para o confirmDismiss, neste caso, false.
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('SIM'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              )
            ],
          )
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
          .removeItem(cartItem.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            // leading: CircleAvatar(
            //   child: Padding(
            //     padding: EdgeInsets.all(5),
            //     child: FittedBox(
            //       child: Text('R\$ ${cartItem.price}'),
            //     ),
            //   ),
            // ),
            title: Text(cartItem.title),
            subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}