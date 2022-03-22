//
//  SliderTableViewCell.swift
//  MVVM
//
//  Created by Darshan on 22/03/22.
//

import UIKit

protocol SliderProtocol{
    func sliderUpdatewithValue(sliderValue:SliderValue)
}
class SliderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stacKView:UIStackView!
    
    @IBOutlet weak var objSlider:UISlider!
    @IBOutlet weak var txtSliderValue:UITextField!
    
    var delegate:SliderProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stacKView.layer.borderWidth  = 1.0
        self.stacKView.layer.borderColor = UIColor.black.cgColor
        self.stacKView.layer.cornerRadius = 0.7
        // Initialization code
        self.objSlider.addTarget(self, action: #selector(SliderTableViewCell.slidervalueChange), for: .valueChanged)
        self.txtSliderValue.delegate = self
        self.txtSliderValue.keyboardType = .numberPad
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.objSlider.value = 0
        self.txtSliderValue.text = "0"
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func slidervalueChange(){
        DispatchQueue.main.async {
            self.delegate?.sliderUpdatewithValue(sliderValue: SliderValue.init(value: "\(self.objSlider.value)", index: self.tag))
        }
    }
    func updateSliderValue(sliderValue:SliderValue){
        DispatchQueue.main.async {
            let updatedValue = Float("\(sliderValue.value)") ?? 0.0
            
            self.objSlider.value = updatedValue > self.objSlider.maximumValue ? 100 : updatedValue
            self.txtSliderValue.text = updatedValue > self.objSlider.maximumValue ? "100" : "\(Int(updatedValue))"
        }
    }
    
}
extension SliderTableViewCell:UITextFieldDelegate{
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let typpedString = ((textField.text)! as NSString).replacingCharacters(in: range, with: string)
        print("=== \(typpedString) \(typpedString.count)")
        
       
        guard typpedString.count > 0 else{
            self.objSlider.value = 0
            self.txtSliderValue.text = "0"
            return  true
        }
       
        self.updateSliderValue(sliderValue: SliderValue.init(value: typpedString, index: self.tag))
        return true
    }
}
