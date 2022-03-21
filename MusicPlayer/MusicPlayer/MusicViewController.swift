//
//  MusicViewController.swift
//  MusicPlayer
//
//  Created by 신상원 on 2022/03/20.
//

import AVFoundation
import UIKit
import MediaPlayer
import SnapKit

class MusicViewController: UIViewController {
    
    let musicView = MusicView()
    var isPlaying = false
    var timer: Timer!
    var session = AVAudioSession.sharedInstance()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupTarget()
        setupAudioSession()
        initializePlayer()
        remoteCenterSetting()
        remoteCommandInfoCenterSetting()
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
    
    func setupTarget() {
        musicView.playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        musicView.backwardButton.addTarget(self, action: #selector(backwardButtonClicked), for: .touchUpInside)
        musicView.forwardButton.addTarget(self, action: #selector(forwardButtonClicked), for: .touchUpInside)
        musicView.slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
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
//            self.invalidateTimer()
            self.musicView.playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc func backwardButtonClicked() {
        if Double(player!.currentTime) < 15 {
            self.player?.currentTime = TimeInterval(0.0)
        } else {
            self.player?.currentTime = TimeInterval(player!.currentTime - 15)
        }
    }
    
    @objc func forwardButtonClicked() {
        if Double(player!.currentTime + 15) >= Double(player!.duration) {
            self.player?.currentTime = TimeInterval(player!.duration)
        } else {
            self.player?.currentTime = TimeInterval(player!.currentTime + 15)
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        self.updateSpendTime(time: TimeInterval(sender.value))
        self.player?.currentTime = TimeInterval(sender.value)
    }
    
}

extension MusicViewController: AVAudioPlayerDelegate {
    
    // 세선을 설정해주는것만으로 백그라운드 재생이 된다 But 홈화면에서 정보를 받을 수 없다.
    func setupAudioSession() {
        session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default, options: [])
        } catch let error as NSError {
            print("Session Error", error)
        }
    }
   
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
            print("Player Error", error)
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
    
    
    // 홈화면 및 제어화면에서 제어 할 수 있도록 설정 (playBack모드)
    func remoteCenterSetting() {
        // remote control event 받기 시작
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let center = MPRemoteCommandCenter.shared() // 제어 센터 재생버튼 누르면 발생할 이벤트를 정의합니다.
        center.playCommand.addTarget { (commandEvent) -> MPRemoteCommandHandlerStatus in
            self.player!.play()
            return MPRemoteCommandHandlerStatus.success
        }
        
        // 제어 센터 pause 버튼 누르면 발생할 이벤트를 정의합니다.
        center.pauseCommand.addTarget { (commandEvent) -> MPRemoteCommandHandlerStatus in
            self.player!.pause()
            return MPRemoteCommandHandlerStatus.success
        }
    }
    
    // 홈화면 및 제어화면에서 재생중인 음악의 정보를 확인할 수 있도록
    func remoteCommandInfoCenterSetting() {
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "싱글벙글"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "시니"
        if let albumCoverPage = UIImage(named: "sini") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                return albumCoverPage })

        } // 콘텐츠 총 길이
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player!.duration // 콘텐츠 재생 시간에 따른 progressBar 초기화
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player!.rate // 콘텐츠 현재 재생시간
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player!.currentTime
        center.nowPlayingInfo = nowPlayingInfo
    }


}


