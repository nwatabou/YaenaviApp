//
//  ScheduleCell.swift
//  Timetable
//
//  Created by Wataru Nakanishi on 2022/01/10.
//

import UIKit

final class ScheduleCell: UICollectionViewCell {
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17.0)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let statusLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func getSize(width: CGFloat) -> CGSize {
        let contentWidth = (width - (Const.horizontalMargin * 3)) / 2
        return CGSize(width: contentWidth, height: Const.height)
    }
}

extension ScheduleCell {
    private enum Const {
        static let height: CGFloat = 60.0
        static let verticalMargin: CGFloat = 8.0
        static let horizontalMargin: CGFloat = 16.0
    }

    private func commonInit() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8.0

        contentView.addSubview(timeLabel)
        contentView.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.verticalMargin),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.horizontalMargin),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.horizontalMargin),

            statusLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Const.verticalMargin),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.horizontalMargin),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.horizontalMargin),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Const.verticalMargin)
        ])
    }
}

extension ScheduleCell {
    enum Input {
        case time(String)
        case status(String)
    }

    func apply(_ input: Input) {
        switch input {
        case let .time(time):
            timeLabel.text = time
        case let .status(status):
            statusLabel.text = status
        }
    }
}
