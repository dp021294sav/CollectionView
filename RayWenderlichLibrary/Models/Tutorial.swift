
import UIKit

class Tutorial: Decodable, Hashable {
    let title: String
    let thumbnail: String
    let artworkColor: String
    var isQueued: Bool
    let publishDate: Date
    let content: [Section]
    var updateCount: Int
    let identifier = UUID().uuidString
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension Tutorial: Equatable {
    static func ==(lhs: Tutorial, rhs: Tutorial) -> Bool {
        return lhs.title == rhs.title && lhs.publishDate == rhs.publishDate
    }
}

extension Tutorial {
    var image: UIImage? {
        return UIImage(named: thumbnail)
    }
    
    var imageBackgroundColor: UIColor? {
        return UIColor(hexString: artworkColor)
    }
    
    func formattedDate(using formatter: DateFormatter) -> String? {
        return formatter.string(from: publishDate)
    }
}
