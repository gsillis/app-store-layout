//
//  DownloadTableCell.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 10/12/21.
//

import UIKit
import ViewCodePreview

class DownloadTableCell: UICollectionViewCell, ConfigureCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()

    private let appImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .random()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()

    private let downloadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        labelStackView.axis = .vertical

        let groupStackView = UIStackView(arrangedSubviews: [appImage, labelStackView, downloadButton])
        groupStackView.alignment = .center
        groupStackView.spacing = 10

        return groupStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: App) {
        nameLabel.text = model.name
        subtitleLabel.text = model.subheading
    }
}

extension DownloadTableCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func addConstraints() {
        stackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        appImage.constrainSize(CGSize(width: 50, height: 50))
        downloadButton.constrainWidth(38)
    }
}

// MARK: Preview
#if canImport(SwiftUI) && DEBUG

import SwiftUI

 struct DownloadTableCellPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = DownloadTableCell()
            let app = App(tagline: "", name:  "Lorem ipsum", subheading:  "Lorem ipsum")
            view.configure(with: app)

            return view
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   80))
    }
}

#endif
