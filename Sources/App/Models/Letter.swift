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
    @Field(key: "beenOpened")
    var beenOpened: Bool
    
    //empty initializer
    init() {}
    
    //do I really need an extra structure to get data out or can I just use the class itself? I shouldn't need to access one part without another
    struct postLetter: Content {
        var recipientID: String
        var senderID: String
        var letterData
    }
    
    //struct to get the ID of a letter out of the database and return to user on creation
    
    
    //constructor for new letter with all parameters filled (Shouldn't be any situation where they all aren't being filled at the same time, unlike an account)
    init(id: UUID?, rID: String, sID: String, data: String) {
        self.id = id
        self.recipientID = rID
        self.senderID = sID
        self.letterData = data
    }
}

struct LetterController {
    //Create new letter
    func newLetter(req: Request) throws -> EventLoopFuture<Letter> {
        input = try req.content.decode(Letter)
        
        let id = UUID()
        let letter = Letter(id: id, rID: input.rec, sID: <#T##String#>, data: <#T##String#>)
    }
    
    //Called when the a user has read a letter. Use a webhook to update other client's screen when this happens and show an opened envelope
    func openedLetter(req: Request) throws -> EventLoopFuture<Bool>
    //update 'beenOpened to reflect'
}
