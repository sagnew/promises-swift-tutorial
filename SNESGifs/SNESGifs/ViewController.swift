//
//  ViewController.swift
//  SNESGifs
//
//  Created by Sam Agnew on 2/24/17.
//  Copyright © 2017 Sam Agnew. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit
import SwiftyGif

class ViewController: UIViewController {
  
  @IBOutlet var beerGifImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    let giphy = GiphyManager()
    
    giphy.fetchRandomGifUrl(forSearchQuery: "SNES").then { imageUrlString in
      self.fetchImage(forImageUrl: imageUrlString)
    }.then { imageData in
      self.attachImage(withImage: imageData)
    }.catch { error in
        print(error)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func fetchImage(forImageUrl imageUrlString: String) -> Promise<Data> {
    return Promise { fulfill, reject in
      Alamofire.request(imageUrlString).responseData { response in
        if let imageData = response.result.value {
          print("image downloaded")
          fulfill(imageData)
        } else {
          reject(response.error!)
        }
      }
    }
  }
  
  func attachImage(withImage imageData: Data) -> Void {
    print("Displaying image")
    let image = UIImage(gifData: imageData)
    self.beerGifImageView.setGifImage(image)
  }

}

