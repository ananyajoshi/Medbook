import Foundation

// Controller class for sorting books based on different options
class SortingController {
    
    // Function to sort books based on the specified option
    static func sortBooks(_ books: inout [Book], by option: SortOption) {
        switch option {
        case .title:
            books.sort { $0.title < $1.title } // Sort books by title in ascending order
        case .average:
            books.sort { $0.ratingsAverage > $1.ratingsAverage } // Sort books by average ratings in descending order
        case .hits:
            books.sort { $0.ratingsCount > $1.ratingsCount } // Sort books by ratings count in descending order
        case .classics:
            books.sort { $0.firstPublishYear > $1.firstPublishYear } // Sort books by first publish year in descending order
        }
    }
}

// Enum representing different options for sorting books
enum SortOption: String, CaseIterable {
    case title = "Title"     // Sort by title
    case average = "Average"  // Sort by average ratings
    case hits = "Hits"        // Sort by ratings count
    case classics = "Classics" // Sort by first publish year (considered as classics)
}
