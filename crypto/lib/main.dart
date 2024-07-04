import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'cubit/crypto_cubit.dart';
import 'services/crypto_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CryptoService()),
        BlocProvider(create: (context) => CryptoCubit(context.read<CryptoService>())),
      ],
      child: MaterialApp(
        home: CryptoScreen(),
      ),
    );
  }
}

class CryptoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
      ),
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return ListView.builder(
            itemCount: state.cryptos.length,
            itemBuilder: (context, index) {
              final crypto = state.cryptos[index];
              return ListTile(
                title: Text(crypto.name),
                subtitle: Text('\$${crypto.price}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CryptoCubit>().fetchCryptos(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
