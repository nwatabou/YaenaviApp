//
//  TimetableViewController.swift
//  Timetable
//
//  Created by Wataru Nakanishi on 2022/01/10.
//

import API
import UIKit

public final class TimetableViewController: UIViewController {

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 16.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let outwardRouteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let returnRouteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8.0
        layout.minimumLineSpacing = 24.0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.layer.cornerRadius = 12.0
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 70.0, right: 0.0)
        view.registerClass(cellType: ScheduleCell.self)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var testData: RouteScheduleListResponse = {
        .init(
            name: "波照間航路",
            outwardRouteName: "石垣発",
            outwardRouteSchedules: [
                .init(time: "08:00", status: "○"),
                .init(time: "11:45", status: "○"),
                .init(time: "14:30", status: "○")
            ],
            returnRouteName: "波照間発",
            returnRouteSchedules: [
                .init(time: "09:50", status: "○"),
                .init(time: "13:15", status: "○"),
                .init(time: "16:20", status: "○")
            ]
        )
    }()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    @objc private func changedSegmented(sender: AnyObject) {
        collectionView.reloadData()
    }
}
extension TimetableViewController {
    private enum Const {
        static let backgroundColor: UIColor = .init(hex: "87CEEB")
    }

    private func configureView() {
        title = testData.name
        view.backgroundColor = Const.backgroundColor

        view.addSubview(stackView)
        stackView.addArrangedSubview(outwardRouteLabel)
        stackView.addArrangedSubview(returnRouteLabel)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            stackView.heightAnchor.constraint(equalToConstant: 20.0),

            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        outwardRouteLabel.text = testData.outwardRouteName
        returnRouteLabel.text = testData.returnRouteName
    }
}

extension TimetableViewController: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return testData.outwardRouteSchedules.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ScheduleCell.self, for: indexPath)
        let schedule: RouteScheduleResponse
        let isOutwardRoute = indexPath.item == 0
        if isOutwardRoute {
            schedule = testData.outwardRouteSchedules[indexPath.section]
        } else {
            schedule = testData.returnRouteSchedules[indexPath.section]
        }

        cell.apply(.time(schedule.time))
        cell.apply(.status(schedule.status))

        return cell
    }
}

extension TimetableViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ScheduleCell.getSize(width: collectionView.frame.width)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.0, left: 8.0, bottom: 0.0, right: 8.0)
    }
}
