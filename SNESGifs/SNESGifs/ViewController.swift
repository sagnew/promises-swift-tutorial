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
  
  @IBOutlet var snesGifImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    let giphy = GiphyManager()
    
    giphy.fetchRandomGifUrl(forSearchQuery: "SNES").then { imageUrlString in
      self.fetchImage(forImageUrl: imageUrlString)
    }.then { imageData in
      self.attachImage(withImageData: imageData)
    }.catch { error in
      print(error)
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func fetchImage(forImageUrl imageUrlString: String) -> Promise<Data> {
    
    // Return a Promise for the caller of this function to use.
    return Promise { fulfill, reject in
      
      // Make an HTTP request to download the image.
      Alamofire.request(imageUrlString).responseData { response in
        
        if let imageData = response.result.value {
          print("image downloaded")
          
          // Pass the image data to the next function.
          fulfill(imageData)
        } else {
          
          // Reject the Promise if something went wrong.
          reject(response.error!)
        }
      }
    }
  }
  
  func attachImage(withImageData imageData: Data) -> Void {
    print("Displaying image")
    let image = UIImage(gifData: imageData)
    self.snesGifImageView.setGifImage(image)
  }

}

