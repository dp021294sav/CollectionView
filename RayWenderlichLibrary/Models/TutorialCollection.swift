
import Foundation

struct TutorialCollection: Decodable, Hashable  {
    let title: String
    let tutorials: [Tutorial]
    let identifier = UUID().uuidString
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: TutorialCollection, rhs: TutorialCollection) -> Bool {
        return lhs.title == rhs.title
    }
}

extension TutorialCollection {
    var queuedTutorials: [Tutorial] {
        return tutorials.filter({ $0.isQueued })
    }
}
