//
//  DB_ManagerCategory.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/10.
//

import Foundation
// import library
import SQLite
 
class DB_ManagerCategory {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var categories: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var category:Expression<String>!    // カテゴリ
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/mayca_user1.sqlite3")
             
            // creating table object
            categories = Table("categorys")
             
            // create instances of each column
            id = Expression<Int64>("id")
            category = Expression<String>("category")
             
            // check if the category's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_categorys_created")) {
 
                // if not, then create the table
                try db.run(categories.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(category)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_categorys_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    public func addCategory(categoryValue: String) {
        do {
            try db.run(categories.insert(category <- categoryValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    // return array of category models
    public func getCategories() -> [CategoryModel] {
         
        // create empty array
        var categoryModels: [CategoryModel] = []
     
        // get all categories in descending order
        categories = categories.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all categories
            for ctgry in try db.prepare(categories) {
     
                // create new model in each loop iteration
                let categoryModel: CategoryModel = CategoryModel()
     
                // set values in model from database
                categoryModel.id = ctgry[id]
                categoryModel.category = ctgry[category]
                // append in new array
                categoryModels.append(categoryModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return categoryModels
    }
    
    // get single category data
    public func getCategory(idValue: Int64) -> CategoryModel {
     
        // create an empty object
        let categoryModel: CategoryModel = CategoryModel()
         
        // exception handling
        do {
     
            // get category using ID
            let ctgry: AnySequence<Row> = try db.prepare(categories.filter(id == idValue))
     
            // get row
            try ctgry.forEach({ (rowValue) in
     
                // set values in model
                categoryModel.id = try rowValue.get(id)
                categoryModel.category = try rowValue.get(category)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return categoryModel
    }

    // function to update user
    public func updateCategory(idValue: Int64, categoryValue: String) {
        do {
            // get user using ID
            let user: Table = categories.filter(id == idValue)
             
            // run the update query
            try db.run(user.update(category <- categoryValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    // function to delete user
    public func deleteCategory(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = categories.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}
