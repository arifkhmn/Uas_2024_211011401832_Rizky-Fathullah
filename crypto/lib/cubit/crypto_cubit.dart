import 'package:bloc/bloc.dart';
import 'package:crypto/model/crypto.dart';
import '../services/crypto_service.dart';

class CryptoState {
  final List<Crypto> cryptos;
  final bool loading;
  final String? error;

  CryptoState({required this.cryptos, this.loading = false, this.error});

  CryptoState copyWith({List<Crypto>? cryptos, bool? loading, String? error}) {
    return CryptoState(
      cryptos: cryptos ?? this.cryptos,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoService cryptoService;

  CryptoCubit(this.cryptoService) : super(CryptoState(cryptos: []));

  void fetchCryptos() async {
    try {
      emit(state.copyWith(loading: true));
      final cryptos = await cryptoService.fetchCryptos();
      emit(state.copyWith(cryptos: cryptos, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }
}
