import SwiftUI

struct ContentView: View {
    @ObservedObject var bookController = BookController()
    @State private var searchText = ""
    @State private var selectedSortOption: SortOption = .title

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image("bookImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .font(.title)
                VStack(alignment: .leading, spacing: 5) {
                    Text("MedBook")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Which topic interests you today?")
                        .font(.subheadline)
                }
            }
            
            SearchBar(searchText: $searchText, onSearch: searchBooks)
            
            if bookController.books.isEmpty {
                Text("No results found")
            } else {
                SortingFilter(selectedOption: $selectedSortOption, onSortChanged: sortBooks)
                List {
                    ForEach(bookController.books) { book in
                        BookRow(book: book)
                            .onAppear {
                                if self.bookController.books.last == book {
                                    self.bookController.loadMore(search: searchText)
                                }
                            }
                    }
                }
            }
        }
        .padding()
    }

    private func searchBooks() {
        bookController.books.removeAll()
        bookController.searchBooks(query: searchText) {
        }
    }

    private func sortBooks(by option: SortOption) {
        SortingController.sortBooks(&bookController.books, by: option)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SortingFilter: View {
    @Binding var selectedOption: SortOption
    var onSortChanged: (SortOption) -> Void

    var body: some View {
        HStack {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button(action: {
                    self.selectedOption = option
                    self.onSortChanged(option)
                }) {
                    Text(option.rawValue)
                        .foregroundColor(self.selectedOption == option ? .blue : .black)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
