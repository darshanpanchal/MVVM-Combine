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
            self.objSlider.value = Float("\(sliderValue.value)") ?? 0.0
            self.txtSliderValue.text = "\(sliderValue.value)"
        }
    }
    
}
