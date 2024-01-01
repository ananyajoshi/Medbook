import Foundation

// Model representing a book
struct Book: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var author: String
    var ratingsAverage: Double
    var ratingsCount: Int
    var coverID: Int
    var coverImageURL: URL
    var firstPublishYear: Int
}
