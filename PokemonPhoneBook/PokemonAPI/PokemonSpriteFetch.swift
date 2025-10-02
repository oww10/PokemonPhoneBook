
import Foundation
import UIKit
import Alamofire

class PokemonSpriteFetch{
    
    private func fetchDataByAlamofire<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void){
        // Alamofire를 사용하여 GET 요청 및 디코딩
        AF.request(url).responseDecodable(of: T.self){ response in
                completion(response.result)}
        }
    
    // 포켓몬 이미지를 비동기로 가져오는 함수
    func fetchPokemonSprite(completion: @escaping(UIImage?) -> Void){
        let randomNums = Int.random(in: 1...1000)
        //URLComponents 생성
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(randomNums)")
        
        //URLComponents의 URL 객체를 가져옴 실패하면 print 출력
        guard let url = urlComponents?.url else{
            print("잘못된 URL")
            completion(nil)
            return
        }
        
        //PokemonModel타입으로 디코딩 성공 시 이미지 URL 가져오며 실패 시 nil 처리
        fetchDataByAlamofire(url: url){(result: Result<PokemonModel, AFError>) in
            switch result{
            case .success(let result):
                let imageURL = result.sprites.frontDefault
                
                AF.request(imageURL).responseData{ response in
                    if let data = response.data, let image = UIImage(data: data){
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            case .failure(let error):
                print("데이터 로드 실패: \(error)")
            }
        }
    }
    
    
}
