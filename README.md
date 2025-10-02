## ☎️ Pokemon API을 활용한 연락처 앱입니다.

## 📱주요 기능
<table>
  <tr>
    <th>저장한 연락처보기</th>
    <th>새로운 연락처 추가하기</th>
    <th>기존 연락처 편집하기</th>
    <th>데이터 초기화</th>
  </tr>
  <tr>
    <td><img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-02 at 10 11 09" src="https://github.com/user-attachments/assets/4df80ba4-84c8-4daf-92d7-2cc4dd6788cd" /></td>
    <td><img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-02 at 10 10 46" src="https://github.com/user-attachments/assets/41ae793a-8f88-4544-8c7a-7b23f5487228" /></td>
    <td><img width="302" height="656" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-02 at 10 11 05" src="https://github.com/user-attachments/assets/863e8237-7b75-4b31-8a86-f97f62faba1d" /></td>
    <td><img width="302" height="656" alt="simulator_screenshot_25AD01B4-CE32-4B1B-AA13-1B1B8F519ADD" src="https://github.com/user-attachments/assets/cb55c267-a0c7-476f-9d85-9f77bf891362" /></td>
  </tr>
</table>

## 🏗️ 사용 아키텍처 (MVC 아키텍처)
```
💾 Model (데이터 계층)
📁 Data: 포켓몬 전화번호부 항목과 관련된 핵심 데이터 구조 및 로직을 포함합니다.
└──PhoneBook+CoreDataClass
└──PhoneBook+CoreDataProperties
└──PokemonPhoneBook (CoreData)

🖼️ View (표시 계층)
📁 Scenes: 애플리케이션의 시각적 표시를 처리합니다.
TableCell
└──PhoneBookCell
Views
└──AddContactView
└──PhoneBookTableView

⚙️ Controller (로직 계층)
📁 ViewControllers: 사용자 상호 작용을 관리하고, 모델을 업데이트하며, 뷰를 수정합니다.
└──AddContactVC
└──MainVC
```
## 🛠️기술 스택
**Xcode Version: 16**<br />
**Swift Version: 5**<br />
**UI: UIKit + SnapKit**<br />
**URL: Alamofire**<br />
**https://pokeapi.co/** <br />
**Data: CoreData** <br />
Minimum iOS: 18.0

## 💾데이터 저장
사용자는 "랜덤 이미지 선택" 버튼을 누르면 다음과 같은 과정이 진행됩니다:

포켓몬API에서 이미지를 하나 불러옵니다.<br />
작성한 이름과 전화번호와 함께 불러온 이미지를 CoreData에 저장합니다.

## 💻 OS/Editors<br />


![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)<br />
## 📋 Languages<br />
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)<br />

## 🕓 Version Control<br />
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
