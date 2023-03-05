//
//  ImageDownloadCell.swift
//  ImageDownloader
//
//  Created by 문다 on 2023/03/05.
//

import UIKit
import SnapKit

class ImageDownloadCell: UITableViewCell {
    
    // MARK: - Properties
    static let id = "ImageDownloadCell"
    
    var contentImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let image = UIImage(systemName: "photo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.trackTintColor = .lightGray
        bar.progressTintColor = .systemBlue
        bar.progress = 0.4
        return bar
    }()
    
    let loadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Load", for: .normal)
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ImageDownloadCell.id)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impementsl")
    }
    
    // MARK: - Selectors
    @objc func handleLoadSingleImage() {
        self.contentImage.image = UIImage(systemName: "photo")
        
        // TODO: Forced unwrapped!x2
        var request = URLRequest(url: URL(string: "https://pbs.twimg.com/media/EZ5ODOcVAAAhY9t?format=jpg&name=small")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let image = UIImage(data: data!) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.contentImage.image = image
            }
        }.resume()
    }
    
    // MARK: - Helpers
    private func setupCell() {
        contentView.addSubview(contentImage)
        contentView.addSubview(progressBar)
        contentView.addSubview(loadButton)
        
        loadButton.addTarget(self, action: #selector(handleLoadSingleImage), for: .touchUpInside)
        loadButton.showsTouchWhenHighlighted = true
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }
        
        contentImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(120)
            make.height.equalTo(80)
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.equalTo(contentImage.snp.trailing).offset(10)
            make.centerY.equalTo(contentView)
        }
        
        loadButton.snp.makeConstraints { make in
            make.leading.equalTo(progressBar.snp.trailing)
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
}
