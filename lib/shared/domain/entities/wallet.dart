enum WalletType { cash, visa, smartWallet, emergency }

class Wallet {
  final WalletType type;
  final double balance;

  const Wallet({
    required this.type,
    required this.balance,
  });

  Wallet copyWith({
    WalletType? type,
    double? balance,
  }) {
    return Wallet(
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wallet &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          balance == other.balance;

  @override
  int get hashCode => type.hashCode ^ balance.hashCode;

  @override
  String toString() => 'Wallet{type: $type, balance: $balance}';
}
