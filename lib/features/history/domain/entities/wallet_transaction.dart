class WalletTransaction {
  final String id;
  final double amount;
  final bool isPositive;
  final String category; // Used as the main title/label of the transaction (e.g. Food, Salary, Transport)
  final String walletType; // Cash, Visa, Smart Wallet, Emergency
  final DateTime dateTime;
  final String? notes;
  final bool isSalary;

  const WalletTransaction({
    required this.id,
    required this.amount,
    required this.isPositive,
    required this.category,
    required this.walletType,
    required this.dateTime,
    this.notes,
    required this.isSalary,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount &&
          isPositive == other.isPositive &&
          category == other.category &&
          walletType == other.walletType &&
          dateTime == other.dateTime &&
          notes == other.notes &&
          isSalary == other.isSalary;

  @override
  int get hashCode =>
      id.hashCode ^
      amount.hashCode ^
      isPositive.hashCode ^
      category.hashCode ^
      walletType.hashCode ^
      dateTime.hashCode ^
      notes.hashCode ^
      isSalary.hashCode;

  @override
  String toString() {
    return 'WalletTransaction{id: $id, amount: $amount, isPositive: $isPositive, category: $category, walletType: $walletType, dateTime: $dateTime, notes: $notes, isSalary: $isSalary}';
  }
}
