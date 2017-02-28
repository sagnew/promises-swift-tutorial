//
//  GiphyManager.swift
//  BeerGIFs
//
//  Created by Sam Agnew on 2/24/17.
//  Copyright © 2017 Sam Agnew. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class GiphyManager: NSObject {
  
  let giphyBaseURL = "https://api.giphy.com/v1/gifs/search"
  let apiKey: String
  let imageLimit: UInt32
  
  override init() {
    // The default public API key
    self.apiKey = "dc6zaTOxFJmzC"
    self.imageLimit = 50
    super.init()
  }
  
  init(apiKey: String, imageLimit: UInt32) {
    self.apiKey = apiKey
    self.imageLimit = imageLimit
    super.init()
  }
  
  func fetchRandomGifUrl(forSearchQuery query: String) -> Promise<String> {
    let params = ["api_key": self.apiKey, "q": query, "limit": "\(self.imageLimit)"]
    
    return Promise { fulfill, reject in
      Alamofire.request(self.giphyBaseURL, parameters: params)
        .responseJSON { response in
          if let result = response.result.value {
            let json = JSON(result)
            let randomNum = Int(arc4random_uniform(self.imageLimit))
            
            if let imageUrlString = json["data"][randomNum]["images"]["downsized"]["url"].string {
              print(imageUrlString)
              fulfill(imageUrlString)
            } else {
              reject(response.error!)
            }
            
          }
      }
    }
  }
}
