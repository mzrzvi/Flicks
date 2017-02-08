//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Moiz Rizvi on 2/6/17.
//  Copyright © 2017 Moiz Rizvi. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)

        let title = movie["title"]
        titleLabel.text = title as! String?

        let overview = movie["overview"]
        overviewLabel.text = overview as! String?
        overviewLabel.sizeToFit()

        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = baseUrl + posterPath
            let posterRequest = URLRequest(url: URL(string: posterUrl)!)
            
            posterView.setImageWith(
                posterRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        self.posterView.alpha = 0.0
                        self.posterView.image = image
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            self.posterView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        self.posterView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in }
            )
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
