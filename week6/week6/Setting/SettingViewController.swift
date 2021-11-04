//
//  SettingViewController.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import Zip
import UIKit
import MobileCoreServices

class SettingViewController: UIViewController {

/*
 - 사용자의 아이폰 저장공간 확인
    - 부족 : 백업 불가
 - 백업진행(백업할 파일이 존재하는가?)
    - Realm, Folder (아무것도 없다면 백업할 데이터가 없다고 안내)
    - Progress + UI 인터렉션 금지 (백업 진행 중에 다른 화면으로 가지 않도록)
 보통 .zip 파일로 백업 파일 생성
    - 백업 완료 시점에 Progress + UI 인터렉션 허용
    - 공유화면을 띄워준다 (어디로 백업 파일을 내보낼지 선택)
 */

    
/*
 <복구하기>
 - 사용자의 아이폰 저장 공간 확인
 - 파일 앱
    - *.zip 파일 선택
- unzip 과정 필요
    - 백업 파일 이름 확인
    - 압축해제 -> 백업 파일 확인 (폴더, 파일 이름 확인)
 - 백업 당시 데이터랑 지금 현재 앱에서 사용중인 데이터를 어떻게 관리해줄 것인가?
    
 */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBarItem.title = LocalizableStrings.tab_setting.localized
        //title = LocalizableStrings.tab_setting.localized
    }
    
    // 백업할 파일이 있는지 확인 (도큐먼트 폴더 위치)
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask //디렉토리내 제한걸어 준다고생각
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        //path 는 배열형태, 0번째 인덱스에 url 이 저장된다
        
        if let directoryPath = path.first {
            return directoryPath
        }
        return nil
    }
    
    //7) 백업은 했는데 어디로 보낼까요? 띄워주는 창
    func presentActivityViewController() {
        
        //압축 파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("TEST.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        //4) 백업할 파일에 대한 URL 배열
        var urlPath = [URL]()
        
        //1) 도큐먼트 파일 위치 확인
        if let path = documentDirectoryPath() {
            //2) 백업하고자 하는 파일 확인(URL)
            //이미지 같은 경우, 백업 편의성을 위해 폴더를 생성하고, 폴더 내에 이미지를 저장하는 것이 효율적
            let realm = (path as NSString).appendingPathComponent("default.realm")
            //2) 백업하고자 하는 파일 존재 여부 확인(file)
            if FileManager.default.fileExists(atPath: realm) {
                //5) URL 배열에 백업 파일 URL 추가
                urlPath.append(URL(string: realm)!)
            }
            else {
                print("백업할 파일이 없습니다.")
            }
            
        }
        //3) 백업하기(배열에 대한 압축 파일 만들기)
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPath, fileName: "TEST") // Zip
            print("압축경로: \(zipFilePath)")
            presentActivityViewController()
        }
        catch {
          print("Something went wrong")
        }
    }
    
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        
        //복구1. 파일앱 열기 + 확장자 (import 잊지말기)
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func activityViewButtonClicked(_ sender: UIButton) {
        presentActivityViewController()
    }
    
}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        //2) 선택한 파일에 대한 경로 가져와야 함(파일앱에 존재하는 백업 파일에 대한 경로)
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent) //우리가 파일앱에서 선택한 마지막 파일
        
        //3) 압축해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            //기존에 복구하고자 하는 zip 파일을 도큐먼트에 가지고 있을 경우, 도큐먼트에 위치한 zip 을 압축해제 하면됨
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("TEST.zip")
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    //복구 완료, 앱을 다시 실행 해주세요라는 얼럿을 띄워줌
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            }
            catch {
                print("ERROR")
            }
        }
        
        else {
            //파일 앱의 zip -> 도큐먼트 폴더에 복사 하는 과정이 필요
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("TEST.zip")
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    //복구 완료, 앱을 다시 실행 해주세요라는 얼럿을 띄워줌
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
                
            }
            catch {
                print("ERROR")
            }
        }
    }
}
