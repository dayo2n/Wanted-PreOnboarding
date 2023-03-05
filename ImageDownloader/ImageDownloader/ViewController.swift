//
//  ViewController.swift
//  ImageDownloader
//
//  Created by 문다 on 2023/03/05.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let numberOfCells = 5
    private let imageDownloadTableView = UITableView()
    private let loadAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load All Iamges", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Selectors
    
    @objc func handleLoadAllImages() {
        for index in 0..<numberOfCells {
            let cell = imageDownloadTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ImageDownloadCell
            cell.handleLoadSingleImage()
        }
    }

    // MARK: - Helpers
    
    private func setupTableView() {
        self.imageDownloadTableView.dataSource = self
        self.imageDownloadTableView.register(ImageDownloadCell.self, forCellReuseIdentifier: ImageDownloadCell.id)
        self.imageDownloadTableView.allowsSelection = false
    }
    
    private func setupViews() {
        self.setupTableView()
        self.view.addSubview(imageDownloadTableView)
        self.view.addSubview(loadAllButton)
        self.loadAllButton.addTarget(self, action: #selector(handleLoadAllImages), for: .touchUpInside)
        self.loadAllButton.showsTouchWhenHighlighted = true
    }
    
    private func setupLayout() {
        self.setupViews()
        
        imageDownloadTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(view.frame.height / 3 * 2)
        }
        
        loadAllButton.snp.makeConstraints { make in
            make.top.equalTo(imageDownloadTableView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageDownloadCell.id) as! ImageDownloadCell
        return cell
    }
    
    
}
