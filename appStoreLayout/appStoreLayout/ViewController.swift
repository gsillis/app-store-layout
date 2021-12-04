//
//  ViewController.swift
//  appStoreLayout
//
//  Created by Gabriela Sillis on 03/12/21.
//

import UIKit
import ViewCodePreview

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class TestView: UITableViewCell {

    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        view.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

 struct ViewPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = TestView()
            return view
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height:   300))
    }
}

#endif


