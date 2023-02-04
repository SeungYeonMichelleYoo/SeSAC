//
//  CameraViewController.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/12.
//

import UIKit
import YPImagePicker
import Alamofire
import SwiftyJSON

//1번 버튼만 YPImagePicker라이브러리를 사용, 나머지 3가지 버튼은 내장된 UIImagePickerController를 사용

class CameraViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    //UIImagePickerController 1.
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIImagePickerController 2.
        picker.delegate = self
        
    }
    
    //OpenSource
    //권한은 다 허용하기!
    @IBAction func ypImagePickerButtonClicked(_ sender: UIButton) {
        
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                self.resultImageView.image = photo.image
                
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    //UIImagePickerController
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 사용자에게 토스트/얼럿")
            return
        }
        
        picker.sourceType = .camera
        picker.allowsEditing = false //편집화면
        
        present(picker, animated: true)
        
    }
    
    
    //UIImagePickerController
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("사용불가 + 사용자에게 토스트/얼럿")
            return
        }
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false //편집화면
        
        present(picker, animated: true)
    }
    
    
    //네번째 버튼 클릭시 (위의 버튼 3가지 클릭 후 이미지뷰에 이미지 뜬 상태에서 이거 클릭하면 갤러리에 저장)
    @IBAction func saveToPhotoLibrary(_ sender: UIButton) {
        
        if let image = resultImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    //이미지뷰 이미지 -> 네이버 -> 얼굴분석 해줘 요청 -> 응답!
    //문자열이 아닌 파일, 이미지, pdf 파일 자체가 그대로 전송되지 않음. -> 텍스트 형태로 인코딩
    //어떤 파일의 종류가 서버에게 전달이 되는 지 명시 = Content-Type
    @IBAction func clovaFaceButtonClicked(_ sender: UIButton) {
        // 유명인 얼굴 인식 API
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "P2ycBelQ4_Uvc_bFVaxX",
            "X-Naver-Client-Secret" : "LMNEQvP0_w",
            "Content-Type": "multipart/form-data"
        ]
        
        //UIImage를 텍스트형태(바이너리 타입)로 변환해서 전달
        guard let imageData = resultImageView.image?.jpegData(compressionQuality: 0.5) else {
            print("이미지가 큼")
            return
        }
        
        //Alamofire - Uploading Multipart Form Data 가져옴
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: url, headers: header)
        .validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

//UIImagePickerController 3.
//네비게이션 컨트롤러를 상속받고 있음
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //UIImagePickerController 4. 사진을 선택하거나 카메라 촬영 직후
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        //원본, 편집, 메타 데이터 등 - infoKey
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.resultImageView.image = image
            dismiss(animated: true)
        }
    }
    
    //UIImagePickerController 5. 취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
    
}
