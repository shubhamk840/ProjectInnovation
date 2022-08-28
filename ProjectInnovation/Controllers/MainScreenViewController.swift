//
//  MainScreenViewController.swift
//  ProjectInnovation
//
//  Created by Shubham Kushwaha on 28/08/22.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.layer.cornerRadius = 5
        imageView.layer.cornerRadius = 5
        imageView.isUserInteractionEnabled = false
        makeApiCall()
    }
    
    func makeApiCall() {
        SVProgressHUD.show(currentViewController: self)
        let Services = Services(baseUrl: "https://dog.ceo/api/breeds/image/random")
        Services.getAllCountriesName(endPoint: "",onSuccess: {
            (dogsData) in
            SVProgressHUD.dismiss(currentViewController: self)
            let url = URL(string: dogsData.message ?? "")!
            self.downloadImage(from: url)
        }, onFailure : {
            (error) in
            SVProgressHUD.dismiss(currentViewController: self)
            print(error)
        })
    }
    
    @IBAction func refreshBtnClicked(_ sender: Any) {
       makeApiCall()
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        self.refreshButton.isUserInteractionEnabled = false
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
                self?.refreshButton.isUserInteractionEnabled = true
            }
        }
    }

}
