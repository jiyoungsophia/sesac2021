//
//  ImageManager.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/04.
//

import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    // 도큐먼트 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent("imageFolder").appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        // 1. 이미지 저장할 경로 설정: 도큐먼트 폴더(.documentDirectory), FileManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("imageFolder") else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
               
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기(원래는 자동으로 된다고,,)
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path){
            //4-2. 기존경로에 있는 이미지 삭제(원래 자동으로 삭제됨)
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완")
            } catch {
                print("이미지 삭제하지 못했습니다")
            }
        }
    }
}
