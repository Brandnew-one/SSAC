//
//  MusicViewController.swift
//  MusicPlayer
//
//  Created by 신상원 on 2022/03/20.
//

import AVFoundation
import UIKit
import SnapKit

class MusicViewController: UIViewController {
    
    let musicView = MusicView()
    var isPlaying = false
    var timer: Timer!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupButton()
        initializePlayer()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(musicView)
    }
    
    func setupConstraints() {
        musicView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupButton() {
        musicView.playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
    }
    
    // 분분:초초 로 표현해주기 위해서
    func updateSpendTime(time: TimeInterval) {
        let minute = Int(time / 60)
        let second = Int(time.truncatingRemainder(dividingBy: 60))
        let timeText = String(format : "%02ld:%02ld", minute, second)
        self.musicView.spendTimeLabel.text = timeText
    }
    
    // 1초마다 호출돼서 현재 플레이어의 재생시간으로 Label과 Slider를 업데이트 해준다
    func makeTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block : { [unowned self] (timer: Timer) in
            if self.musicView.slider.isTracking { return }
            self.updateSpendTime(time:self.player!.currentTime)
            self.musicView.slider.value = Float(self.player!.currentTime)
        })
        self.timer.fire()
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    @objc func playButtonClicked() {
        if !isPlaying { // 노래 정지상태에서 누른 경우
            self.player?.play()
            self.makeTimer()
            self.musicView.playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else { // 노래 재생상태에서 누른 경우
            self.player?.stop()
            self.invalidateTimer()
            self.musicView.playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
}

extension MusicViewController: AVAudioPlayerDelegate {
    
    // AVAudioPlayer 초기화
    func initializePlayer() {
        guard let soundAsset = NSDataAsset(name : "Til I Hear'em Say - NEFFEX") else {
            print("음원없음")
            return
        }
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player?.delegate = self
        } catch let error as NSError {
            print("error")
        }
        // 현재 음원의 총 길이를 Label로 표시해주기 위해서
        let minute = Int(self.player!.duration / 60)
        let second = Int(self.player!.duration.truncatingRemainder(dividingBy: 60))
        let timeText = String(format : "%02ld:%02ld", minute, second)
        self.musicView.totalTimeLabel.text = timeText
        // 슬라이더 최대,최소 값 설정
        self.musicView.slider.maximumValue = Float(self.player!.duration)
        self.musicView.slider.minimumValue = 0
        self.musicView.slider.value = Float(self.player!.currentTime)
    }

    // 현재 음악이 종료되면 타이머를 해제하고 재생버튼, 슬라이더, 재생 Label을 모두 0으로 초기화 시켜준다
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        self.musicView.playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        self.musicView.slider.value = 0;
        self.updateSpendTime(time: 0)
        self.invalidateTimer()
    }

}


