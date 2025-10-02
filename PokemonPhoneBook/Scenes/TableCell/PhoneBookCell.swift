
import Foundation
import UIKit
import SnapKit

class PhoneBookCell:UITableViewCell{
    static let identifier = "PhoneBookCell"
    
    struct PhoneDatas{
        let name: String
        let phone: String
        let image: Data?
    }
    
    var uiImage: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 30
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.borderWidth = 1
        //튀어나오는 이미지 자르기
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    var nameText: UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    var phoneText: UILabel = {
        let label = UILabel()
        label.text = "010-0000-0000"
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(){
        [uiImage,nameText,phoneText].forEach{contentView.addSubview($0)}
        
    }
    private func setupUI(){
        uiImage.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(60)
            
        }
        
        nameText.snp.makeConstraints{ make in
            make.leading.equalTo(uiImage.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        phoneText.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
 
    }
    
    func configureData(phoneDatas: PhoneDatas){
        self.nameText.text = phoneDatas.name
        self.phoneText.text = phoneDatas.phone
        
        if let imageName = phoneDatas.image {
            uiImage.image = UIImage(data: imageName)
            uiImage.backgroundColor = .clear
        }else{
            uiImage.image = nil
            uiImage.backgroundColor = .clear
        }
    }
    

    
}
