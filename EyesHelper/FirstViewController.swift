//
//  ViewController.swift
//  EyesHelper
//
//  Created by joyce huang on 2022-04-06.
//

import UIKit
import Vision
import VisionKit

class FirstViewController: UIViewController, VNDocumentCameraViewControllerDelegate {
    
    let textRecognizationQueue = DispatchQueue.init(label: "TextRecognizationQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem, target: nil)
        var request = [VNRequest]()

    
    @IBOutlet weak var scanTextButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        //func viewDidLoad() would override the initial state of the textview (e.g. if you write hello on the UI), bc viewDidLoad() would run immediately
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpVision()
        scanTextButton.titleLabel?.font = UIFont.systemFont(ofSize: 68.0)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 68.0)
    }
    
    func setUpVision(){
            let textRecognizationRequest = VNRecognizeTextRequest{
                (request,Error) in
                guard let observationsResults = request.results as? [VNRecognizedTextObservation] else {
                    print("NO Result")
                    return
                }
                let maximunCandidates = 1
                var resultInText=""
                for observation in observationsResults {
                    let candidate = observation.topCandidates(maximunCandidates).first
                    resultInText += candidate?.string ?? " "+"\n"
                    
                }
                
                self.textView.text=resultInText
                print(resultInText)
            }
            textRecognizationRequest.recognitionLevel = .accurate
            self.request = [textRecognizationRequest]
        }
    
    @IBOutlet weak var textView: UITextView! //rename this to textView
    
    @IBAction func scanTextIsPressed(_ sender: UIButton) {
        let dCC = VNDocumentCameraViewController()
        dCC.delegate=self
        self.present(dCC, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonIsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecond", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "goToSecond" {
                    let destinationVC = segue.destination as! SecondViewController
                    destinationVC.result=textView.text;
                }
    }
    
    // The client is responsible for dismissing the document camera in these callbacks.
    // The delegate will receive one of the following calls, depending whether the user saves or cancels, or if the session fails.
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
        controller.dismiss(animated: true, completion: nil)
                for i in 0..<scan.pageCount{
                    let scannedImage = scan.imageOfPage(at: i)
                        if let cgImage = scannedImage.cgImage {
                            let requestHandler = VNImageRequestHandler.init(cgImage:cgImage, options: [:])
                            do {
                                try requestHandler.perform(self.request)
                                    
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                }
    }

    
    
    // The delegate will receive this call when the user cancels.
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController){
        controller.dismiss(animated: true, completion: nil)
    }
}

