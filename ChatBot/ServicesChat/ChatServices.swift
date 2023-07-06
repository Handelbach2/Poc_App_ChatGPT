//
//  ChatServices.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit
import Alamofire

final class ChatService {
    
    static let shared = ChatService()
    
    let api_key: String = Globals.shared.apiKey
    
    // status success
    private let statusOK = 200...299
    
    // envia el prompt a chatgpt
    func sendQuest(msj: String, succes: @escaping(_ chat: ChatResp) -> (), failure: @escaping ( _ error: Error?) -> ()) {
        print("msj: ", msj)
        
        let url = "https://api.openai.com/v1/completions"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(api_key)"
        ]
        

        
        let obj: sendObj = sendObj(model: "text-davinci-003", prompt: msj, max_tokens: 4000, temperature: 0.5, top_p: 1, n: 1,stream: false)
        
        
        
        print("header: ", headers)
        
        AF.request(url, method: .post, parameters: obj, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: statusOK).responseDecodable(of: ChatResp.self) { res in
            print("repsuesta: ", res)
            switch res.result {
                
            case .success(let chat) :
                print("chat: ", chat)
                succes(chat)
            case .failure(let error) :
                failure(error)
            }
        }
    }
    

    
    
}
