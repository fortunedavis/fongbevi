import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="audio"
export default class extends Controller {

  connect() {
    console.log("we are in")
    const player = document.getElementById("player");
    const recodingBtn = document.querySelector("#recodingBtn");
    recodingBtn.addEventListener(
      "click",
      () => {
        console.log("recoding..");
        this.startRecoding();
      },
      false
    );
    
    recodingBtn.addEventListener(
      "click",
      () => {
        this.stopRecoding();
        console.log("recoding stopped.");
      },
      false
    );
    
  }
  

  startRecoding = () => {
  var mediaRecorder;
  const clip_audio = document.getElementById("clip_audio");
  
    window.recordedChunks = [];
    navigator.mediaDevices
      .getUserMedia({ audio: true, video: false })
      .then((stream) => {
        window.stream = stream;
        const options = { mimeType: "audio/webm" };
        mediaRecorder = new MediaRecorder(stream, options);
  
        mediaRecorder.ondataavailable = (e) => {
          window.recordedChunks.push(e.data);
        };
  
        mediaRecorder.onstop = function (e) {
          const audioType = "audio/ogg; codecs=opus";
          var blob = new Blob(window.recordedChunks, { 'type': audioType });
          var blobURL = window.URL.createObjectURL(blob);
          window.recordedChunks = [];

          let file = new File([blob], (Math.random() + 1).toString(36).substring(7)+".ogg", {
            type: audioType,
            lastModified: new Date().getTime(),
          });

          let container = new DataTransfer();
          container.items.add(file);

          clip_audio.files = container.files;

         //window.player.src = blobURL;
        }
  
        mediaRecorder.addEventListener("stop", function () {
        	//downloadLink.value = URL.createObjectURL(new Blob(recordedChunks));

        });
  
        mediaRecorder.start();
        window.mediaRecorder = mediaRecorder;
      });
  };
  
  stopRecoding = () => {
    try {
      window.mediaRecorder.stop();
      window.stream.getTracks().forEach(function (track) {
        track.stop();
      });
    } catch (error) {
      console.log(error);
    }
  };

}