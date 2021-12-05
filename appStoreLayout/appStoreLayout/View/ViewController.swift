//
//  ViewController.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 03/12/21.
//

import UIKit

class ViewController: UIViewController {

//    private let section = [Section].parse(jsonFile: "sampleData")

    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.section[sectionIndex]

            switch section.type {
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
}

extension ViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.fillSuperview()
    }
}

//#if canImport(SwiftUI) && DEBUG
//
//import SwiftUI
//
// struct ViewPreview: PreviewProvider {
//    static var previews: some View {
//        Preview {
//            let view = TestView()
//            return view
//        }
//        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   300))
//    }
//}
//
//#endif


