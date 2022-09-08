//
//  ChatInpuAccesaryView.swift
//  ChatAppTraining
//
//  Created by USER on 2022/09/08.
//

import UIKit

class ChatInputAccesaryView: UIView {
    
//    カスタムUIViewやUIButtonを作成した時に、initメソッド内で定数や配列の初期化などを行いたい
//初期化というのは何か値を与えること
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
        
    }
    
    //カスタムビューの作り方。カスタムビューを作ることでUIを使い回すことができる。（xibのファイルをこのViewの上にセットしたいため記述）
    private func nibInit() {
        let nib = UINib(nibName: "ChatInputAccesaryViewCell", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        view.frame = self.bounds
        //UIViewがサイズ変更、向きの変更、テーブルビューセルでの編集コントロールの表示などによってスーパービューが変更されたときに、適切にシフトおよびサイズ変更することです。
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
