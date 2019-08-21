import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var squareView2: DistortionView!
    @IBOutlet weak var squareView3: DistortionView!
    @IBOutlet weak var squareView4: DistortionView!
    
    @IBAction func square1Animation(_ sender: Any) {
        // Square 1
        self.squareView.backgroundColor = UIColor.red
        UIView.animate(withDuration: 1.0) {
            self.squareView.backgroundColor = UIColor.blue
        }
    }
    
    @IBAction func square2Animation(_ sender: Any) {
        // Square 2
        self.squareView2.backgroundColor = UIColor.red
        self.squareView2.distortion = 0
        UIView.animate(withDuration: 1.0) {
            self.squareView2.backgroundColor = UIColor.blue
            self.squareView2.distortion = 1
        }
    }
    
    @IBAction func square3Animation(_ sender: Any) {
        // Square 3
        self.squareView3.backgroundColor = UIColor.red
        self.squareView3.distortion = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.4,
                       options: [],
                       animations: {
                        self.squareView3.distortion = 1
                        self.squareView3.backgroundColor = UIColor.blue
        }, completion: nil)
    }
    
    @IBAction func square4Animation(_ sender: Any) {
        // Square 4
        self.squareView4.backgroundColor = UIColor.red
        self.squareView4.distortion = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options:[.curveEaseOut, .autoreverse],
                       animations: {
                        self.squareView4.distortion = 1
                        self.squareView4.backgroundColor = UIColor.blue
        },completion: { finished in
            if finished == true {
                self.squareView4.distortion = 0
                self.squareView4.backgroundColor = UIColor.red
            }
        })
    }
}

