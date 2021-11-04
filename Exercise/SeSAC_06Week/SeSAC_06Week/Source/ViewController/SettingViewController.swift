//
//  SettingViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/04.
//

/*
 백업하기
 1. 사용자 아이폰 저장공간 확인 - 부족하면 백업 불가
 2. 백업 진행 - 아무 데이터도 없으면 백업할 데이터 없다고 안내
    - realm, folder
    - progress + ui 인터렉션 금지
 3. zip
    - 백업 완료 시점에 progress + ui 인터렉션 허용
 4. 공유화면
 */

/*
 복구하기
 1. 사용자 아이폰 저장공간 확인
 2. 파일 앱: zip, zip 선택
 3. zip -> unzip
    - 백업 파일 이름 확인, 압축 해제
        - 백업 파일 확인: 폴더, 파일이름
        - 정상적인 파일인가
 4. 백업 당시 데이터랑 지금 현재 앱에서 사용중인 데이터 어떻게 합칠건지에 대한 고려
 
 */

import UIKit
import Zip
import MobileCoreServices

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    1. 도큐먼트 폴더 위치
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
            
        }
    }
    
    // 7. 공유
    func presentActivityViewController() {
        // 압축파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        // 4. 백업할 파일에 대한 url 배열
        var urlPaths = [URL]()
        
        // 1. 도큐먼트 폴더 위치(~/document/default.realm)
        if let path = documentDirectoryPath() {
            // 2. 백업하고자하는 파일 url 확인
            // 이미지 같은 경우 백업 편의성을 위해 폴더를 생성하고, 폴더 내에 이미지를 저장하는 것이 효율적
            let realm = (path as NSString).appendingPathComponent("default.realm")
            // 2-1. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. url 배열에 백업 파일 url 추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일 없음")
            }
        }
        // 3.4번 배열에 대한 압축 파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축경로: \(zipFilePath)")
            presentActivityViewController()
            
        }
        catch {
          print("Something went wrong")
        }
    }
    
    @IBAction func activityVCButtonClicked(_ sender: UIButton) {
        presentActivityViewController()
    }
    
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        
        // 복구 1. 파일앱 열기 + 확장자 (import MobileCoreServices)
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
        
        
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        // 복구2. 선택한 파일에 대한 경로 가져와야 함
        // ex. iphon/jack/fileapp/archive.zip
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구3 - 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    // 복구가 완료되었습니다 얼럿
                }, fileOutputHandler: { unzipFile in
                    print("unzipFile: \(unzipFile)")
                })
            } catch {
                print("error")
            }
            
        } else {
            // 파일 앱의 zip -> 도큐먼트 폴더에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    // 복구가 완료되었습니다 얼럿
                }, fileOutputHandler: { unzipFile in
                    print("unzipFile: \(unzipFile)")
                })
            } catch {
                print("error")
            }
            
        }
    }
    
}
