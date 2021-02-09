//
//  Letter.swift
//  
//
//  Created by Joseph Simeone on 2/8/21.
//

import Fluent
import Vapor

final class Letter: Model, Content {
    static let schema = "letters"
    
    //Unique identifier for this account
    @ID(key: .id)
    var id: UUID?
    
    //Letter details
    @Field(key: "recipientID")
    var recipientID: String
    @Field(key: "senderID")
    var senderID: String
    @Field(key: "letterData")
    var letterData: String
    
    //empty initializer
    init() {}
    
    //constructor for new letter with all parameters filled (Shouldn't be any situation where they all aren't being filled at the same time, unlike an account)
    init(id: UUID?, rID: String, sID: String, data: String) {
        self.id = id
        self.recipientID = rID
        self.senderID = sID
        self.letterData = data
    }
}
