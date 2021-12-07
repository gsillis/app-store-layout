//
//  ViewController.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 03/12/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: typealias
    typealias UserDataSource = UICollectionViewDiffableDataSource<Section, App>
    typealias SnapshotData = NSDiffableDataSourceSnapshot<Section, App>

    // MARK: Properties
    private let section = [Section].parse(jsonFile: "sampleData")
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    private lazy var dataSource: UserDataSource = createDataSource()

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCell()
        reloadSnapshotData()
    }

    // MARK: Register Cell
    private func registerCell() {
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.identifier)
        collectionView.register(ListTableCell.self, forCellWithReuseIdentifier: ListTableCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        }

    // MARK: DiffableDataSourceSnapshot
    private func reloadSnapshotData() {
        var snapshot = SnapshotData()
        snapshot.appendSections(section)

        section.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource.apply(snapshot)
    }

    // MARK: CollectionView Data Source
    private func createDataSource() -> UserDataSource {
        UserDataSource(collectionView: collectionView) { collectionView, indexPath, app in
            switch self.section[indexPath.section].type {
                case "listTable":
                    return collectionView.configure(ListTableCell.self, with: app, for: indexPath)
                default:
                    return collectionView.configure(FeatureCollectionViewCell.self, with: app, for: indexPath)
            }
        }
    }

    // MARK: CollectionView Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.section[sectionIndex]

            switch section.type {
                case "listTable":
                    return self.createListSection()
                default:
                    return self.createFeatureSection()
            }
        }
        let configure = UICollectionViewCompositionalLayoutConfiguration()
        configure.interSectionSpacing = 20
        layout.configuration = configure

        return layout
    }

    private func createFeatureSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(350))

        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

        return layoutSection
    }

    private func createListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 0)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))

        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

        return layoutSection
    }
}

// MARK: extension - ViewCode
extension ViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.fillSuperview()
    }
}
