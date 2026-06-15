import 'package:equatable/equatable.dart';

abstract class RiwayatEvent extends Equatable {
  const RiwayatEvent();
  @override
  List<Object?> get props => [];
}

/// Load awal / refresh dari halaman 1
class RiwayatLoaded extends RiwayatEvent {
  const RiwayatLoaded();
}

/// Load halaman selanjutnya (infinite scroll)
class RiwayatLoadMore extends RiwayatEvent {
  const RiwayatLoadMore();
}

/// Filter berdasarkan varietas (1=Aligator, 2=Miki, null=Semua)
class FilterChanged extends RiwayatEvent {
  final int? varietasId;
  const FilterChanged(this.varietasId);
  @override
  List<Object?> get props => [varietasId];
}

/// Hapus item riwayat
class RiwayatDeleted extends RiwayatEvent {
  final int id;
  const RiwayatDeleted(this.id);
  @override
  List<Object?> get props => [id];
}
