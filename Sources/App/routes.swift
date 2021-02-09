import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let accountController = AccountController()
    app.get { req in
        return "It works!"
    }

    app.get("accounts") { req -> EventLoopFuture<[Account]> in
        Account.query(on: req.db).all()
    }
    
    //MARK: Create New Account
    app.post("createaccount") { req -> EventLoopFuture<Account.idOut> in
        
        print("Creating New Account...")
        
        //Pass the request to the newAccount method
        let returnData = try accountController.newAccount(req: req)
        return returnData
    }
    
    //MARK: Create Account with notification privileges
    app.post("createaccountnotifs") { req -> EventLoopFuture<Account.idOut> in
        print("creatign new account with notification privileges")
        
        let returnData = try accountController.newAccountNotifs(req: req)
        return returnData
    }
    
    //MARK: Check for user's new partner
    //app.post("checkpartner") { req -> EventLoopFuture<Account.partnerOut> in
      //  print("Checking for user's new partners...")
       // let returnData = try accountController.checkPartners(req: req)
       // return returnData
    //}
    
    //app.post("getnew") { req ->}

    try app.register(collection: TodoController())
}
