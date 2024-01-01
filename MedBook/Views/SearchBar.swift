import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for books", text: $searchText, onCommit: onSearch)
        }
        .padding()
    }
}
