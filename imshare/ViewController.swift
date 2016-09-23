//
//  ViewController.swift
//  imshare
//
//  Created by Abdullah Hafeez on 06/09/2016.
//  Copyright © 2016 Abdullah Hafeez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource
{
    var imagePicker : UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var collectionView: UICollectionView!
    
    let engineProducts = ["Intercooler", "ForgedPistons", "HKSExManifold", "TurboCharger"]
    let imageArray = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3"), UIImage(named: "image4")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.engineProducts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        as! CollectionViewCell
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        
        cell.titleLabel?.text = self.engineProducts[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! NewViewController
            
            vc.image = self.imageArray[indexPath.row]!
            vc.title = self.engineProducts[indexPath.row]
        
        }
    }
    @IBAction func logoutAction2(sender: AnyObject) {
       try! FIRAuth.auth()?.signOut()
        self.performSegueWithIdentifier("showLogin", sender: self)
        let alertController = UIAlertController(title: "Tired?", message: "Logout Successful", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    @IBAction func addPictureBtnAction(sender: AnyObject) {
    
        
        let alertController : UIAlertController = UIAlertController(title: "Title", message: "Select Camera or Photo Library", preferredStyle: .ActionSheet)
        let cameraAction : UIAlertAction = UIAlertAction(title: "Camera", style: .Default, handler: {(cameraAction) in
            print("camera Selected...")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
                
                self.imagePicker.sourceType = .Camera
                self.present()
                
            }else{
                self.presentViewController(self.showAlert("Title", Message: "Camera is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
                
            }
            
        })
        
        let libraryAction : UIAlertAction = UIAlertAction(title: "Photo Library", style: .Default, handler: {(libraryAction) in
            
            print("Photo library selected....")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == true {
                
                self.imagePicker.sourceType = .PhotoLibrary
                self.present()
                
            }else{
                
                self.presentViewController(self.showAlert("Title", Message: "Photo Library is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
            }
        })
        
        let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel , handler: {(cancelActn) in
            print("Cancel action was pressed")
        })
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func present(){
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("info of the pic reached :\(info) ")
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    //Show Alert
    
    
    func showAlert(Title : String!, Message : String!)  -> UIAlertController {
        
        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .Alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { (alert) in
            print("User pressed ok function")
            
        }
        
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        return alertController
    }

    }

