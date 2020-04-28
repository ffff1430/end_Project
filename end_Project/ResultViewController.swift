//
//  ResultViewController.swift
//  end_Project
//
//  Created by star on 2020/4/28.
//  Copyright © 2020 star. All rights reserved.
//

import UIKit



class ResultViewController: UIViewController {
    
    @IBOutlet weak var ResultImage: UIImageView!
    
    @IBOutlet weak var ResultID: UILabel!
    
    @IBOutlet weak var ResultTitle: UILabel!
    var TitleId:[PhotoWall]!
    var index:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        ResultTitle.numberOfLines = 2
        ResultID.text = String(TitleId[index].id)
        ResultTitle.text = TitleId[index].title
        let url = TitleId[index].thumbnailUrl
        URLSession.shared.dataTask(with: url){(data,response,error)in
            if let data = data{
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.ResultImage.image = image
                }
            }
        }.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
