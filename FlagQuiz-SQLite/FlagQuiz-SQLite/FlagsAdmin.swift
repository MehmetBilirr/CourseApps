//
//  FlagsAdmin.swift
//  FlagQuiz-SQLite
//
//  Created by Mehmet Bilir on 9.05.2022.
//

import Foundation


class FlagsAdmin{
    
    let db:FMDatabase?
    
    init(){
        
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let file = URL(fileURLWithPath: target).appendingPathComponent("flags.sqlite")
        
        db = FMDatabase(path: file.path)
}
    
    
    func getRandomFlags() ->[Flags]{
        
        var flagArray = [Flags]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM flags ORDER BY RANDOM() LIMIT 5 ", values: nil)
            while (rs.next()) {
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id"))!, flag_name: (rs.string(forColumn: "flag_ad"))!, flag_image: (rs.string(forColumn: "flag_image"))!)
                flagArray.append(flag)
            }
            
            
        }catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        return flagArray
        
        
    }
    
    func getRandom3False(bayrak_id:Int) ->[Flags]{
        
        var flagArray = [Flags]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM flags WHERE bayrak_id != ? ORDER BY RANDOM() LIMIT 3 ", values: [bayrak_id])
            while (rs.next()) {
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id"))!, flag_name: (rs.string(forColumn: "flag_ad"))!, flag_image: (rs.string(forColumn: "flag_image"))!)
                flagArray.append(flag)
            }
            
            
        }catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        return flagArray
        
        
    }
    
}
