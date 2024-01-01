import SwiftUI

struct BookRow: View {
    @ObservedObject var viewModel: BookRowViewModel

    init(book: Book) {
        self.viewModel = BookRowViewModel(book: book)
    }

    var body: some View {
        HStack(spacing: 16) {
            // Cover Image
            AsyncImage(url: viewModel.book.coverImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 120)
            } placeholder: {
                // Placeholder image or loading indicator
                Color.gray
                    .frame(width: 80, height: 120)
            }
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(viewModel.book.title)
                    .font(.headline)
                    .lineLimit(2)

                // Author
                Text(viewModel.book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Average Ratings with Star Icon
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(viewModel.roundedAverageRating)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.trailing, 8)
        }
        .padding(8)
    }
}

struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Book(title: "Sample Title",
                              author: "Sample Author",
                              ratingsAverage: 4.5,
                              ratingsCount: 100,
                              coverID: 123,
                              coverImageURL: URL(string: "https://example.com/sample-image.jpg")!, firstPublishYear: 1999)
        
        _ = BookRowViewModel(book: sampleBook)
        
        return BookRow(book: sampleBook)
            .previewLayout(.fixed(width: 300, height: 150)) // Adjust the preview size as needed
            .padding()
    }
}
