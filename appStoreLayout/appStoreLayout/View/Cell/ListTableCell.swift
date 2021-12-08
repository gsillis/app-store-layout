//
//  ListTableCell.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 07/12/21.
//

import UIKit
import ViewCodePreview

class ListTableCell: UICollectionViewCell, ConfigureCell {

    private let  nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .label

        return label
    }()

    private let imageView: UIImageView = {
        let image  = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.backgroundColor = .random()

        return image
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stack.alignment = .fill
        stack.spacing = 20

        return stack
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

    }
}

extension ListTableCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func addConstraints() {
        stackView.fillSuperview()
        imageView.constrainSize(CGSize(width: 30, height: 30))
    }
}

// MARK: Preview
#if canImport(SwiftUI) && DEBUG

import SwiftUI

 struct ListTableViewPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = ListTableCell()
            let app = App(tagline: "", name: "Lorem ipsum", subheading: "")
            view.configure(with: app)
            return view
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   35))
    }
}

#endif
