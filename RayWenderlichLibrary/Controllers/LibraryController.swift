
import UIKit

final class LibraryController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>!
    private let tutorialCollections = DataSource.shared.tutorials
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        collectionView.register(TitleSupplementaryView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
        
        
        self.title = "Library"
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
        configureSnapshot()
    }
}

// MARK: - Collection View
extension LibraryController {
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

// MARK: - Diffable Data Source
extension LibraryController {
    typealias TutorialDataSource = UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, tutorial: Tutorial) -> UICollectionViewCell? in
    
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier, for: indexPath) as? TutorialCell else {
                return nil
            }
            
            cell.titleLabel.text = tutorial.title
            cell.thumbnailImageView.image = tutorial.image
            cell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
            
            return cell
        }
         
        dataSource.supplementaryViewProvider = { [weak self]
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if let self = self,
            let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
                
                let tutorialCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                titleSupplementaryView.textLabel.text = tutorialCollection.title
                
                return titleSupplementaryView
            } else {
                return nil
            }
        }
    }
    
    func configureSnapshot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<TutorialCollection, Tutorial>()
     
        tutorialCollections.forEach { collection in
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.tutorials)
            print(currentSnapshot)
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

// MARK: - UICollectionViewDelegate
extension LibraryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tutorial = dataSource.itemIdentifier(for: indexPath),
           let tutorialDetailController = storyboard?.instantiateViewController(identifier: TutorialDetailViewController.identifier, creator: { coder in
                return TutorialDetailViewController(coder: coder, tutorial: tutorial)
           }) {
            show(tutorialDetailController, sender: nil)
        }
    }
}
