import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dictaphone"
export default class extends Controller {
  connect() {
    console.log("dictaphone")
    const clip_audio = document.getElementById("clip_audio");
    const player = document.querySelector('#player');
   
     }
    // visualiser setup - create web audio api context and canvas
  
   phone(e){
    e.preventDefault();
    const record = document.querySelector('.record');
    if (navigator.mediaDevices.getUserMedia) {
      console.log('getUserMedia supported.');
      const constraints = { audio: true };
      let chunks = [];

      let onSuccess = function(stream) {
        const mediaRecorder = new MediaRecorder(stream);

        record.onclick = function(e) {
          e.preventDefault();
          if (mediaRecorder.state == "inactive"){
            mediaRecorder.start();
            console.log("recorder started");
            record.classList.remove("bg-green-500");
            record.classList.add("bg-red-500");
            record.innerHTML = "Stop";
          }else{
            mediaRecorder.stop();
            console.log("state 2",mediaRecorder.state);
            console.log("recorder stopped");
            record.classList.remove("bg-red-500");
            record.classList.add("bg-green-500");
            record.innerHTML = "Parler";
            console.log("duration",player.duration)
          }
          
        }

        mediaRecorder.onstop = function() {
          console.log("data available after MediaRecorder.stop() called.");
    
          //audio.controls = true;
          const audioType = "audio/ogg; codecs=opus";

          const blob = new Blob(chunks, { 'type' : 'audio/ogg; codecs=opus' });
          chunks = [];
          const audioURL = window.URL.createObjectURL(blob);
          console.log("recorder stopped");

          let file = new File([blob], (Math.random() + 1).toString(36).substring(7)+".ogg", {
            type: audioType,
            lastModified: new Date().getTime(),
          });
          
          let container = new DataTransfer();
          container.items.add(file);
          console.log("audio url",audioURL);
         // player.setAttribute('src',audioURL);
         // console.log("audio url",player.src );
          document.getElementById("player").setAttribute('src', audioURL);
          document.getElementById("player").load();
         // document.getElementById("my-audio").play();

          //player.src = audioURL;

          clip_audio.files = container.files;

          // deleteButton.onclick = function(e) {
          //   e.target.closest(".clip").remove();
          // }

          mediaRecorder.ondataavailable = function(e) {
            chunks.push(e.data);
          }
        }
        
      }

      let onError = function(err) {
        console.log('The following error occured: ' + err);
      }
      navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);
    }
  }
}
