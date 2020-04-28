//
//  PhotoCollectionViewController.swift
//  end_Project
//
//  Created by star on 2020/4/27.
//  Copyright © 2020 star. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoVC"

class PhotoCollectionViewController: UICollectionViewController {
    
    var PhotoWalls = [PhotoWall]()

    override func viewDidLoad() {
        super.viewDidLoad()
       if let urlStr = "https://jsonplaceholder.typicode.com/photos".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
                  let decoder = JSONDecoder()
                  decoder.dateDecodingStrategy = .iso8601
                  URLSession.shared.dataTask(with: url) { (data, response , error) in
                    if let data = data, let PhotoResults = try? decoder.decode([PhotoWall].self, from: data)    {
                        self.PhotoWalls = PhotoResults
                          DispatchQueue.main.async {
                            self.collectionView.reloadData()
                          }
                      }
                  }.resume()
                  
              }
      let itemSpace: CGFloat = 0
      let columnCount: CGFloat = 4
      let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
      let width = floor((collectionView.bounds.width - itemSpace * (columnCount)) / columnCount)
      flowLayout?.itemSize = CGSize(width: width, height: width)
      flowLayout?.estimatedItemSize = .zero
      flowLayout?.minimumInteritemSpacing = 0
      flowLayout?.minimumLineSpacing = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return PhotoWalls.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
        let photo = PhotoWalls[indexPath.item]
        cell.ID.text = String(photo.id)
        cell.titleLabel.text = photo.title
        cell.titleLabel.numberOfLines = 3
        URLSession.shared.dataTask(with: photo.thumbnailUrl) { (data, response, error) in
                 if let data = data, let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         cell.PhotoImage.image = image
                     }
                 }
             }.resume()
    
        return cell
    }

    @IBSegueAction func Result(_ coder: NSCoder) -> ResultViewController? {
        let controller = ResultViewController(coder: coder)
        controller?.TitleId = PhotoWalls
        controller?.index = collectionView.indexPathsForSelectedItems?.first?.item ?? 0
        return controller
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
