import Foundation

class BookRowViewModel: ObservableObject {
    let book: Book

    init(book: Book) {
        self.book = book
    }

    var roundedAverageRating: String {
        String(format: "%.1f", book.ratingsAverage)
    }
}

