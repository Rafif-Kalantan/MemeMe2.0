import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: Declarations
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        defaultTextField(topTextField)
        defaultTextField(bottomTextField)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    //MARK: Picking an Image
    
    //Pick an Image Function
    func pickAnImage(sourceType: UIImagePickerController.SourceType){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion:nil)
        }
    
    //Pick an Image From Camera
    @IBAction func PickAnImageFromCamera(_ sender: Any) {
        pickAnImage(sourceType:  UIImagePickerController.SourceType.camera)
    }
    
    //Pick an Image From Album
    @IBAction func PickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(sourceType: UIImagePickerController.SourceType.photoLibrary)
    }
    
    //MARK: Display Selected Image on Image View
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

       if let image = info[.originalImage] as? UIImage  {
           
           imagePickerView.image = image
           self.view.layoutIfNeeded()
           self.dismiss(animated: true, completion: nil)
       }
        
    }
    
    //MARK: UITextField Functions
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3
    ]
    
    // Setting default text in UITextField
    func defaultTextField (_ textField: UITextField){
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        if textField == topTextField {
            topTextField.text = "TOP"
        }
        else if textField == bottomTextField {
            bottomTextField.text = "BOTTOM"
        }
        
        textField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //Erase the default text when editing
        if textField == topTextField {
            
            textField.text = ""
            
        } else if textField == bottomTextField {
            
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    //MARK: Keyboard
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Move the the view frame up with the keyboard
    @objc func keyboardWillShow(_ notification:Notification) {
        
        //only apply if the bottom text field is being edited
        if (bottomTextField.isEditing){
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    // Return the view frame to its original position
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    // Get the keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: Tool Bar and Navigation Bar
    
    // Show/hide navigation bar and toolbar
    func showBars(hidden: Bool) {
        
        NavigationBar.isHidden = hidden
        Toolbar.isHidden = hidden
        
    }
    
    //MARK: Saving the Meme
    
    func save(memedImage: UIImage) {
            // Create the meme
        let meme = Meme(topText: topTextField.text! as NSString, bottomText: bottomTextField.text! as NSString, image: imagePickerView.image!, memedImage: memedImage)
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return memedImage
    }
    
    //MARK: Sharing the Meme
    
    @IBAction func shareMeme(_ sender: Any) {
        
        showBars(hidden: true)
        let memedImage = generateMemedImage()
        
        let shareActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed {
                self.save(memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        
        }
        present(shareActivityViewController, animated: true, completion: nil)
        showBars(hidden: false)
    }
    
    //MARK: Restart
    @IBAction func restartMeme(_ sender: Any) {
        
        if imagePickerView.image != nil {
                self.imagePickerView.image = nil
                defaultTextField(topTextField)
                defaultTextField(bottomTextField)
            }
        }
    
    //MARK: Cancel Button
    @IBAction func CancelButton(_ sender: Any){
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
}
