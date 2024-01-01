import Foundation
import SwiftUI

// Controller class managing the book data and interactions
class BookController: ObservableObject {
    @Published var books: [Book] = []  // Published property to update UI when books change
    @Published var isLoading = false    // Published property to track loading state
    private var currentPage = 0         // Variable to manage pagination
    
    // Function to search books based on a query
    func searchBooks(query: String, completion: @escaping () -> Void) {
        guard !query.isEmpty else {
            return
        }
        
        isLoading = true // Set loading state to true
        
        // Construct URL for book search API with pagination
        let url = URL(string: "https://openlibrary.org/search.json?title=\(query)&limit=10&offset=\(currentPage * 10)")!
        
        // Make a data task to fetch book data from the API
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { DispatchQueue.main.async { self.isLoading = false } } // Set loading state to false after completion
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                // Decode API response into a BookListResponse
                let result = try JSONDecoder().decode(BookListResponse.self, from: data)
                // Transform API response into Book model
                let newBooks = result.docs.map { apiResponse in
                    let coverURL = URL(string: "https://covers.openlibrary.org/b/id/\(apiResponse.cover_i)-M.jpg")!
                    return Book(title: apiResponse.title,
                                author: apiResponse.author_name.first ?? "",
                                ratingsAverage: apiResponse.ratings_average,
                                ratingsCount: apiResponse.ratings_count,
                                coverID: apiResponse.cover_i,
                                coverImageURL: coverURL, firstPublishYear: apiResponse.first_publish_year)
                }
                
                // Update books array and trigger completion on the main thread
                DispatchQueue.main.async {
                    self.books.append(contentsOf: newBooks)
                    completion()
                }
                
            } catch {
            }
        }.resume() // Start the data task
    }
    
    // Function to load more books (pagination)
    func loadMore(search: String) {
        currentPage += 1 // Increment the current page for the next set of results
        searchBooks(query: search) {
            // Optionally perform any additional actions after loading more books
        }
    }
}

// Struct representing the response from the book search API
struct BookListResponse: Decodable {
    let docs: [BookAPIResponse]
}

// Struct representing a book in the API response
struct BookAPIResponse: Decodable {
    let title: String
    let author_name: [String]
    let ratings_average: Double
    let ratings_count: Int
    let first_publish_year: Int
    let cover_i: Int
}
