struct ReceiverCardPickerSheet: View {
    let cards: [UserCard]
    let selectedCard: UserCard?
    let onSelect: (UserCard) -> Void

    var body: some View {
        NavigationStack {
            List(cards, id: \.self) { card in
                Button {
                    onSelect(card)
                } label: {
                    CardItemView(card: card)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Выберите карту")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
