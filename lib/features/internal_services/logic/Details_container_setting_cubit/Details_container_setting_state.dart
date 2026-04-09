class DetailsContainerSettingState {
  final bool isExpanded;
  final int? selectedOption;

  DetailsContainerSettingState({this.isExpanded = false, this.selectedOption});

  DetailsContainerSettingState copyWith({
    bool? isExpanded,
    int? selectedOption,
  }) {
    return DetailsContainerSettingState(
      isExpanded: isExpanded ?? this.isExpanded,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }
}
