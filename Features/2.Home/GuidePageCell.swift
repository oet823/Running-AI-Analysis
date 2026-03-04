//
//  GuidePageCell.swift
//  RCA(Programmatic UI)
//
//  Created by 오은택 on 2/28/26.
//

import UIKit

final class GuidePageCell: UICollectionViewCell {
    static let id = "GuidePageCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { nil }

    func configure(_ page: GuidePage) {
        imageView.image = UIImage(named: page.imageName)
    }
}
