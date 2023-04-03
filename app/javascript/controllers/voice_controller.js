import { Controller } from "@hotwired/stimulus"
import { AudioContext } from 'web-audio-api';

export default class extends Controller {
  static targets = ['audio'];
  
  connect() {
    this.context = new AudioContext();
    this.mediaRecorder = null;
    this.chunks = [];
    
  }



  startRecording() {
    navigator.mediaDevices.getUserMedia({ audio: true })
      .then((stream) => {
        this.mediaRecorder = new MediaRecorder(stream);
        this.mediaRecorder.ondataavailable = (event) => {
          this.chunks.push(event.data);
        };
        this.mediaRecorder.onstop = () => {
          const audioBlob = new Blob(this.chunks, { type: 'audio/wav' });
          const audioUrl = URL.createObjectURL(audioBlob);
          this.audioTarget.src = audioUrl;
        };
        this.mediaRecorder.start();
      })
      .catch((error) => {
        console.error(error);
      });
  }


 stopRecording() {
    this.mediaRecorder.stop();
    this.chunks = [];
  }



  get audioTarget() {
    return this.targets.find('audio');
  }



}
