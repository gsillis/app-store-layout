//
//  FeatureCollectionViewCell.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 06/12/21.
//

import UIKit
import ViewCodePreview

class FeatureCollectionViewCell: UICollectionViewCell {

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum"
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        return image
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [separatorView, taglineLabel, nameLabel, subtitleLabel, imageView])
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatureCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func addConstraints() {
        separatorView.constrainHeight(1)
        stackView.fillSuperview()
    }
}



#if canImport(SwiftUI) && DEBUG

import SwiftUI

 struct ViewPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = FeatureCollectionViewCell()
            return view
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   300))
    }
}

#endif


