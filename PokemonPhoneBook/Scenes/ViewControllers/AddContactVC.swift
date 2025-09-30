
import Foundation
import UIKit
import SnapKit
import CoreData

class AddContactVC:UIViewController{
    let addView = AddContactView()
    let pokemonSpriteFetcher = PokemonSpriteFetch()
    
    var container: NSPersistentContainer!
    
    weak var delegate: AddContactDelegate?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "연락처 추가"
        setupNavigationBar()
        configureView()
        setupUI()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetAddContactUI()
    }
    
    private func resetAddContactUI(){
        addView.randomIMG.image = nil
        addView.nameTextField.text = ""
        addView.phoneNumberTextField.text = ""
    }
    
    private func configureView(){
        view.addSubview(addView)
        
        addView.randomImgButton.addTarget(self, action: #selector(randomImgButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI(){
        addView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar(){
        let saveButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    enum saveButtonError: Error {
        case noRandomImgError
        case phoneNumsError
        case noNameError
    }
    
    @objc func saveButtonTapped(){
        let alert = UIAlertController(title: "알림", message: nil, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "확인", style: .default)
        
        do {
            guard let image = addView.randomIMG.image?.pngData() else {
                throw saveButtonError.noRandomImgError
            }
            
            guard let name = addView.nameTextField.text, !name.isEmpty else {
                throw saveButtonError.noNameError
            }
            guard let phoneNumber = addView.phoneNumberTextField.text, !phoneNumber.isEmpty else {
                throw saveButtonError.phoneNumsError
            }
            
            createData(name: name, phoneNumber: phoneNumber, image: image)
            delegate?.didAddNewContact()
            self.navigationController?.popViewController(animated: true)
            
        } catch let error as saveButtonError {
            switch error {
            case .noRandomImgError:
                alert.message = "랜덤 이미지 생성을 누르세요."
            case .noNameError:
                alert.message = "이름을 입력하세요."
            case .phoneNumsError:
                alert.message = "전화번호를 입력하세요"
            }
            alert.addAction(doneAction)
            self.present(alert, animated: true)
        } catch {
            alert.message = "알 수 없는 오류가 발생했습니다: \(error.localizedDescription)"
            alert.addAction(doneAction)
            self.present(alert, animated: true)
        }
        
        
    }
    
    @objc func randomImgButtonTapped(){
        print("buttonTap")
        pokemonSpriteFetcher.fetchPokemonSprite{
            [weak self] image in DispatchQueue.main.async{
                self?.addView.randomIMG.image = image
            }
        }
    }
    
    func createData(name: String, phoneNumber: String, image: Data)  {
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else {return}
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: "name")
        newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
        newPhoneBook.setValue(image, forKey: "image")
        
        do{
            try self.container.viewContext.save()
            print("저장 성공")
        }catch{
            print("저장 실패")
        }
    }
    
}


#Preview{
    AddContactVC()
}
