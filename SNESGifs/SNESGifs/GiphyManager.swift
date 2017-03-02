//
//  GiphyManager.swift
//  SNESGifs
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
}
