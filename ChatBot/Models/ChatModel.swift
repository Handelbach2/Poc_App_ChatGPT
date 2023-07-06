//
//  ChatModel.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit

struct ChatStruct {
    var chat: String?
    var type: String?
}

enum typeChat {
    case openai
    case user
}


struct sendObj : Encodable {
    var model: String?
    var prompt: String?
    var max_tokens: Int?
    var temperature: Float?
    var top_p: Int?
    var n: Int?
    var stream: Bool?
}

struct ChatResp : Decodable {
    var id: String?
    var object: String?
    var created: Int?
    var model: String?
    var choices: [ChoicesStruct]?
    var usage: UsageStruct?
}

struct ChoicesStruct : Decodable {
    var text: String?
    var index: Int?
    var logprobs: String?
    var finish_reason: String?
}

struct UsageStruct : Decodable {
    var prompt_tokens: Int
    var completion_tokens: Int
    var total_tokens: Int
}
