//
//  SectionHeader.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 07/12/21.
//


import UIKit
import ViewCodePreview

class SectionHeader: UICollectionViewCell  {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: UI Properties
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()

     let taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

     let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [separatorView, taglineLabel, subTitleLabel])
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
        subTitleLabel.text = model.name
    }
}

// MARK: extension - ViewCode
extension SectionHeader: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func addConstraints() {
        separatorView.constrainHeight(1)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        stackView.setCustomSpacing(10, after: separatorView)
    }
}

// MARK: Preview
#if canImport(SwiftUI) && DEBUG

import SwiftUI

 struct SectionHeaderPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = SectionHeader()
            view.subTitleLabel.text = "Lorem ipsum"
            view.taglineLabel.text =  "Lorem ipsum"
            return view
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   80))
    }
}

#endif


