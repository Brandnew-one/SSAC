//
//  ContentViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import UIKit
import RealmSwift

class ContentViewController: UIViewController {
    
    //우리가 작성한 Realm 의 주소값을 받아 온다고 생각
    let localRealm = try! Realm()

    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "일기작성"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        print("Realm is located at: ", localRealm.configuration.fileURL!)
        
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func saveButtonClicked() {
        
        // 비어있는 Record 를 값을 채워서 task에 저장
        let task = UserDiary(diaryTitle: titleLabel.text!, diaryContent: contentLabel.text!, diaryDate: Date(), diaryPostDate: Date())
        // Realm 에 위의 task 를 추가한다
        try! localRealm.write {
            localRealm.add(task)
            //PK 를 이미지의 이름으로 사용!
            saveImageToDocumentDirectory(imageName: "\(task._id).png", image: contentImageView.image!)
        }
        
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        
        //1. 이미지 저장할 경로 설정 : Document 폴더
        //Desktop/~~/~~/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        print(documentDirectory)
        
        //2. 이미지 파일 이름 & 최종 경로 설정
        //Desktop/~~/~~/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        //3. 이미지 압축(optional) image.pngData()
        guard let data = image.pngData() else { return }
        //guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        //4-1. 이미지 경로 여부 확인 (만약 최종 경로에 동일한 파일이 있는 경우)
        if FileManager.default.fileExists(atPath: imageURL.path) {
            //4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            }
            catch {
                print("이미지 삭제하지 못했습니다.")
            }
        }
        
        //5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        }
        catch {
            print("이미지 저장 실패")
        }
    }

}
