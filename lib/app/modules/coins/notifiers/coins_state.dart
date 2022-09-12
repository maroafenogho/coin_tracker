import 'package:coin_tracker/app/modules/coins/model/coins_model.dart';
import 'package:equatable/equatable.dart';

enum CoinStatus { initial, loading, success, error }

extension CoinStatusExtension on CoinStatus {
  bool get isInitial => this == CoinStatus.initial;
  bool get isoading => this == CoinStatus.loading;
  bool get isSuccess => this == CoinStatus.success;
  bool get isError => this == CoinStatus.error;
}

class CoinState extends Equatable {
  final CoinStatus status;
  final List<Coins> coins;

  const CoinState({required this.coins, this.status = CoinStatus.initial});
  factory CoinState.initial() {
    return const CoinState(coins: []);
  }

  CoinState copyWith({
    CoinStatus? status,
    List<Coins>? coins,
  }) {
    return CoinState(coins: coins ?? this.coins, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
