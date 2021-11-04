//
//  SettingViewController.swift
//  11ShoppingList
//
//  Created by 지영 on 2021/11/04.
//

import UIKit
import MobileCoreServices
import Zip
import JGProgressHUD
import Toast_Swift



class SettingViewController: UIViewController {
    
    let progress = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
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
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("shoppinglist_backup.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
        
        // 저장 여부에 따라 토스트 띄워주기
        vc.completionWithItemsHandler =  { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.view.makeToast(" 백업파일이 성공적으로 저장되었습니다 ", position: .center)
            } else {
                self.view.makeToast(" 백업파일을 저장하지 못했습니다 ", position: .center)
            }
            if let shareError = error {
                self.view.makeToast("\(shareError.localizedDescription)")
            }
        }
    }
    
    func makeBackUpZipFile() {
        var urlPaths = [URL]()
        
        if let path = documentDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일 없음")
            }
        }
        
        progress.show(in: view, animated: true)
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "shoppinglist_backup")
            print("압축경로: \(zipFilePath)")
            
            self.progress.dismiss(animated: true)
            presentActivityViewController()
        }
        catch {
            print("Something went wrong")
        }
    }
    
    func presentDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "백업하기", message: "파일에 저장해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            self.makeBackUpZipFile()
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "복원하기", message: "shoppinglist_backup.zip 파일을 선택해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            self.presentDocumentPicker()
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.view.makeToast(" 복원하지 못했습니다 ", position: .center)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("shoppinglist_backup.zip")
                
                progress.show(in: view, animated: true)
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    self.progress.dismiss(animated: true)
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
                let fileURL = documentDirectory.appendingPathComponent("shoppinglist_backup.zip")
                
                progress.show(in: view, animated: true)
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    self.progress.dismiss(animated: true)
                }, fileOutputHandler: { unzipFile in
                    print("unzipFile: \(unzipFile)")
                })
            } catch {
                print("error")
            }
            
        }
        
        let alert = UIAlertController(title: "복원 완료", message: "앱을 재실행해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
}
