import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dictaphone"
export default class extends Controller {
  connect() {
    console.log("dictaphone")
    const clip_audio = document.getElementById("clip_audio");
    const record = document.querySelector('.record');
    const stop = document.querySelector('.stop');
    const soundClips = document.querySelector('.sound-clips');
    const canvas = document.querySelector('.visualizer');
    const mainSection = document.querySelector('.main-controls');

    stop.disabled = true;

    // visualiser setup - create web audio api context and canvas
    let audioCtx;
    const canvasCtx = canvas.getContext("2d");

    if (navigator.mediaDevices.getUserMedia) {
      console.log('getUserMedia supported.');
      const constraints = { audio: true };
      let chunks = [];

      let onSuccess = function(stream) {
        const mediaRecorder = new MediaRecorder(stream);


        record.onclick = function() {
          mediaRecorder.start();
          console.log(mediaRecorder.state);
          console.log("recorder started");
          record.style.background = "red";
    
          stop.disabled = false;
          record.disabled = true;
        }


        stop.onclick = function() {
          mediaRecorder.stop();
          console.log(mediaRecorder.state);
          console.log("recorder stopped");
          record.style.background = "";
          record.style.color = "";
          // mediaRecorder.requestData();
    
          stop.disabled = true;
          record.disabled = false;
        }


        mediaRecorder.onstop = function(e) {
          console.log("data available after MediaRecorder.stop() called.");
          const player = document.getElementById("player");
          const clipName = "Clip name";
    
          // const clipContainer = document.createElement('article');
          // const clipLabel = document.createElement('p');
          // const audio = document.createElement('audio');
          // const deleteButton = document.createElement('button');
          // const audioType = "audio/ogg; codecs=opus";
          // clipContainer.classList.add('clip');
          // audio.setAttribute('controls', '');
          // deleteButton.textContent = 'Delete';
          // deleteButton.className = 'delete';

          // clipContainer.appendChild(audio);
          // clipContainer.appendChild(clipLabel);
          // clipContainer.appendChild(deleteButton);
          // soundClips.appendChild(clipContainer)

          //audio.controls = true;
          const audioType = "audio/ogg; codecs=opus";

          const blob = new Blob(chunks, { 'type' : 'audio/ogg; codecs=opus' });
          chunks = [];
          const audioURL = window.URL.createObjectURL(blob);
          //audio.src = audioURL;
          console.log("recorder stopped");


          let file = new File([blob], (Math.random() + 1).toString(36).substring(7)+".ogg", {
            type: audioType,
            lastModified: new Date().getTime(),
          });
          
          let container = new DataTransfer();
          container.items.add(file);

          clip_audio.files = container.files;
          player.src = audioURL;

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
