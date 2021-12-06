//
//  FeatureCollectionViewCell.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 06/12/21.
//

import UIKit
import ViewCodePreview

class FeatureCollectionViewCell: UICollectionViewCell, ConfigureCell {

    // MARK: UI Properties
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .random()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [separatorView, taglineLabel, nameLabel, subtitleLabel, imageView])
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ConfigureCell Protocol
    func configure(with model: App) {
        taglineLabel.text = model.tagline
        nameLabel.text = model.name
        subtitleLabel.text = model.tagline
    }
}

// MARK: extension - ViewCode
extension FeatureCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func addConstraints() {
        separatorView.constrainHeight(1)
        stackView.fillSuperview()
        stackView.setCustomSpacing(10, after: separatorView)
        stackView.setCustomSpacing(10, after: subtitleLabel)
    }
}

// MARK: Preview
#if canImport(SwiftUI) && DEBUG

import SwiftUI

 struct ViewPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = FeatureCollectionViewCell()
            let app = App(tagline: "Lorem ipsum", name: "Lorem ipsum", subheading: "Lorem ipsum")
            view.configure(with: app)
            return view
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   300))
    }
}

#endif


