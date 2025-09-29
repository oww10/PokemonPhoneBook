//
//  PokemonSpriteFetch.swift
//  PokemonPhoneBook
//
//  Created by oww on 9/29/25.
//

import Foundation
import UIKit
import Alamofire

class PokemonSpriteFetch{
    
    private func fetchDataByAlamofire<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void){
            AF.request(url).responseDecodable(of: T.self){ response in
                completion(response.result)}
        }
    
    func fetchPokemonSprite(completion: @escaping(UIImage?) -> Void){
        let randomNums = Int.random(in: 1...1000)
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(randomNums)")
        
        guard let url = urlComponents?.url else{
            print("잘못된 URL")
            completion(nil)
            return
        }
        
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
