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
        createHeader()
        reloadSnapshotData()
    }

    // MARK: Register Cell
    private func registerCell() {
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.identifier)
        collectionView.register(ListTableCell.self, forCellWithReuseIdentifier: ListTableCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(DownloadTableCell.self, forCellWithReuseIdentifier: DownloadTableCell.identifier)
        }

    // MARK: Header
    private func createHeader() {
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexpath in
            guard let self = self else { return  nil}

            switch self.section[indexpath.section].type {
                case "listTable", "downloadTable":
                    guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexpath) as? SectionHeader else {
                        return nil
                    }

                    guard let app = self.dataSource.itemIdentifier(for: indexpath) else { return nil }

                    guard let section = self.dataSource.snapshot().sectionIdentifier(containingItem: app) else { return nil }

                    guard !section.title.isEmpty else { return nil }
                    sectionHeader.taglineLabel.text = section.title
                    sectionHeader.subTitleLabel.text = section.subtitle

                    return sectionHeader
                default:
                    return nil
            }
        }
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
                case "downloadTable":
                    return collectionView.configure(DownloadTableCell.self, with: app, for: indexPath)
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
                case "downloadTable":
                    return self.createDownloadSection()
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
        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]

        return layoutSection
    }

    private func createDownloadSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.5))

        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]

        return layoutSection
    }

    // MARK: Layout Section Header
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(80))

        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
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
