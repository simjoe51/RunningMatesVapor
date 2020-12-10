import Fluent
import Vapor

//Struct for login request
struct Login: Content {
    var email: String
    var password: String
}

func routes(_ app: Application) throws {
    
    let accountController = AccountController()
    app.get { req in
        return "It works!"
    }

    app.get("accounts") { req -> EventLoopFuture<[Account]> in
        Account.query(on: req.db).all()
    }
    
   // app.get("login") { req -> String in
      //  let userData = try accountController.login(req: req)
      //  let enteredData = try req.content.decode(Account.loginCheck.self)
        //let decodedUserData = userData.map { Account.loginCheck()
        //    return
       // }
       // if userData.map(to: Account.loginCheck.self) == enteredData.password {
            
       // }
      //  return "hi"
    //}
    
    app.post("createaccount") { req -> EventLoopFuture<Account.idOut> in
        
        //Pass the request to the newAccount method
        let returnData = try accountController.newAccount(req: req)
        return returnData
    }

    try app.register(collection: TodoController())
}
