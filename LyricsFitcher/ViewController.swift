//
//  ViewController.swift
//  LyricsFitcher
//
//  Created by Jamie Cummings on 10/23/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var LyricsTextView: UITextView!
    
    // the base URL for the lyrics API, aka the point where we connect to it
    let lyricsAPIBaseURL = "https://api.lyrics.ovh/v1/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let artistName = artistTextField.text,
            let songTitle = songTextField.text else {
                return
        }
        // since we can't use spaces in our URL, we need to replace spaces in song and artist with a + sign 
        let artistNameURLComponent =
            artistName.replacingOccurrences(of: " ", with: "+")
        
        let songTitleURLComponent =
            songTitle.replacingOccurrences(of: " ", with: "+")
        
        // full URL for the request we will make to the API
        let requestURL = lyricsAPIBaseURL + artistNameURLComponent + "/" + songTitleURLComponent
        
        // we are going to use Alamofire to create an actual request using that URL
        let request = Alamofire.request(requestURL, method: .get, parameters:nil, encoding: JSONEncoding.default, headers: nil)
        
        // now we need to actually make our request
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                // in the case of success, the request has succeeded, and we've gotten some data back
                print(value)
                
                let json = JSON(value)
                
                self.LyricsTextView.text = json["lyrics"].stringValue
                
                print("Success!")
            case .failure(let error):
                // in the case of failure, the request has failed and we've gotten an error back
                print("Error")
                print(error.localizedDescription)
            }
        }
    }
    
    
}

