//
//  SoundViewController.swift
//  AlfredoSoundBoard
//
//  Created by Mescco Quiespe, Rosendo Alfredo on 31/10/23.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var grabarButton: UIButton!
    @IBOutlet weak var reproducirButton: UIButton!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var agregarButton: UIButton!
    
    
    var grabarAudio:AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarGrabacion()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func grabarTapped(_ sender: Any) {
        if grabarAudio!.isRecording {
            grabarAudio?.stop()
            grabarButton.setTitle("GRABAR", for: .normal)
        } else {
            grabarAudio?.record()
            grabarButton.setTitle("DETENER", for: .normal)
        }
    }
    @IBAction func reproducirTapped(_ sender: Any) {
    }
    @IBAction func agregarTapped(_ sender: Any) {
    }
    

    func configurarGrabacion(){
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath,"audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            print("************************************")
            print(audioURL)
            print("************************************")
            
            var settings:[String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            grabarAudio = try AVAudioRecorder(url: audioURL, settings: settings)
            grabarAudio!.prepareToRecord()
            
        } catch let error as NSError{
            print(error)
        }
    }

    // Para iniciar la grabación, llama a audioRecorder.record()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     
    */

}
