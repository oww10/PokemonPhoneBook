
import Foundation
import UIKit
import SnapKit
import CoreData

class AddContactVC:UIViewController{
    let addView = AddContactView()
    // 포켓몬 스프라이트 이미지를 가져오는 인스턴스
    let pokemonSpriteFetcher = PokemonSpriteFetch()
    // CoreData 스택의 NSPersistentContainer 인스턴스.
    var container: NSPersistentContainer!
    // 편집할 연락처 데이터가 있는 경우 저장되는 타입
    var contactEdit: PhoneBookCell.PhoneDatas?
    weak var delegate: ContactDelegate?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        editContact()
        setupNavigationBar()
        configureView()
        setupUI()
        
    }
    //뷰가 사라질 때 호출
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetAddContactUI()
    }
    // 연락처 추가 UI를 초기 상태로 리셋
    private func resetAddContactUI(){
        addView.randomIMG.image = nil
        addView.nameTextField.text = ""
        addView.phoneNumberTextField.text = ""
    }
    
    // contactEdit 속성에 데이터가 있는 경우 UI를 설정
    private func editContact(){
        if let contact = contactEdit{
            guard let image = contact.image else { return }
            self.title = "\(contact.name)"
            addView.nameTextField.text = contact.name
            addView.phoneNumberTextField.text = contact.phone
            addView.randomIMG.image = UIImage(data: image)
        } else {
            self.title = "새 연락처"
        }
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

    // [적용] 버튼 탭 했을 때 호출
    @objc func saveButtonTapped(){
        let alert = UIAlertController(title: "알림", message: nil, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "확인", style: .default)
        
        do {
            // 이미지 데이터 있는지 확인하고, 없으면 Error throw
            guard let image = addView.randomIMG.image?.pngData() else {
                throw saveButtonError.noRandomImgError
            }
            // 이름 텍스트가 있는지 확인하고, 없으면 Error throw
            guard let name = addView.nameTextField.text, !name.isEmpty else {
                throw saveButtonError.noNameError
            }
            // 전화번호 텍스트가 있는지 확인하고, 없으면 Error throw
            guard let phoneNumber = addView.phoneNumberTextField.text, !phoneNumber.isEmpty else {
                throw saveButtonError.phoneNumsError
            }
            // contactEdit의 데이터 업데이트
            if contactEdit != nil {
                updateData(name: name, phoneNumber: phoneNumber, image: image)
                delegate?.didUpdateContact() // delegate에게 연락처가 업데이트되었음을 알린다.
            } else { // 데이터가 없으면 새 연락처 추가
                createData(name: name, phoneNumber: phoneNumber, image: image)
                delegate?.didAddNewContact() // delegate에게 새 연락처가 추가되었음을 알린다.
            }
            // 현재 뷰 컨트롤러에서 이전 화면으로 돌아간다.
            self.navigationController?.popViewController(animated: true)
            
        } catch let error as saveButtonError { // throw에서 받은 에러 처리
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
            alert.message = "알 수 없는 오류가 발생했습니다."
            alert.addAction(doneAction)
            self.present(alert, animated: true)
        }
    }
    
    // [랜덤 이미지 선택] 버튼이 탭되었을 때 호출되는 함수
    @objc func randomImgButtonTapped(){
        print("buttonTap")
        pokemonSpriteFetcher.fetchPokemonSprite{
            //UI 변경을 위해 메인 스레드에서 업데이트 수행
            [weak self] image in DispatchQueue.main.async{
                self?.addView.randomIMG.image = image
            }
        }
    }
    
    // CoreData에 새로운 연락처 데이터를 생성하고 저장
    func createData(name: String, phoneNumber: String, image: Data)  {
        // [PhoneBook] 엔티티 설명을 가져온다. 실패하면 리턴
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else {return}
        // 새 NSManagedObject를 생성하여 CoreData에 삽입한다.
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: "name")
        newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
        newPhoneBook.setValue(image, forKey: "image")
        
        do{
            try self.container.viewContext.save() // 변경사항 저장
            print("저장 성공")
        }catch{
            print("저장 실패")
        }
    }
    
    // CoreData의 기존 연락처 데이터를 업데이트
    private func updateData(name: String, phoneNumber: String, image: Data){
        //원본 이름이 없으면 리턴
        guard let originName = self.contactEdit?.name else { return}
        let fetchRequest = PhoneBook.fetchRequest()
        // 원본 이름과 일치하는 데이터 찾기
        fetchRequest.predicate = NSPredicate(format: "name == %@", originName)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과가 있고 첫 번째 데이터가 있다면 업데이트를 진행
            if let dataUpdate = result.first {
                dataUpdate.setValue(name, forKey: "name")
                dataUpdate.setValue(phoneNumber, forKey: "phoneNumber")
                dataUpdate.setValue(image, forKey: "image")
                
                try self.container.viewContext.save()
                print("데이터 수정 완료")
            } else {
                print("업데이트할 데이터를 찾지 못했습니다.")
            }
            
        } catch {
            print("데이터 수정 실패")
        }
    }
    
}


#Preview{
    AddContactVC()
}
