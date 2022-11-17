import { Controller } from "@hotwired/stimulus"

    var elapsedTimeTag = document.getElementsByClassName("elapsed-time")[0];

    var audioElement = document.getElementsByClassName("audio-element")[0];
   
    var textIndicatorOfAudiPlaying = document.getElementsByClassName("text-indication-of-audio-playing")[0];

    var audioRecordStartTime;

    var maximumRecordingTimeInHours = 1;

    var elapsedTimeTimer;
    

// Connects to data-controller="recorder"
export default class extends Controller {
  static targets = [ 
    "audioElementSource",
    "microphoneButton",
    "recordingControlButtonsContainer",
    "audioElement",
   ]

  connect() {
    
  }

 // this.microphoneButtonTarget.onclick = this.startAudioRecording();

 // stopRecordingButton.onclick = this.stopAudioRecording();

 //Listen to cancel recording button

 // cancelRecordingButton.onclick = this.cancelAudioRecording(); 

 //Listen to when the ok button is clicked in the browser not supporting audio recording box

 //closeBrowserNotSupportedBoxButton.onclick = this.hideBrowserNotSupportedOverlay();

 //Listen to when the audio being played ends

 // audioElement.onended = this.hideTextIndicatorOfAudioPlaying();


  audioRecorder = {
     audioBlobs: [],
     mediaRecorder: null,
     streamBeingCaptured: null,
    
     start: function () {
         //Feature Detection
         if (!(navigator.mediaDevices && navigator.mediaDevices.getUserMedia)) {
             //Feature is not supported in browser
             //return a custom error
             return Promise.reject(new Error('mediaDevices API or getUserMedia method is not supported in this browser.'));
         }
         else {

          return navigator.mediaDevices.getUserMedia({ audio: true })
          .then(stream /*of type MediaStream*/ => {
              //save the reference of the stream to be able to stop it when necessary
              this.streamBeingCaptured = stream;
              //create a media recorder instance by passing that stream into the MediaRecorder constructor
              this.mediaRecorder = new MediaRecorder(stream); /*the MediaRecorder interface of the MediaStream Recording
              API provides functionality to easily record media*/
              //clear previously saved audio Blobs, if any
              this.audioBlobs = [];
              //add a dataavailable event listener in order to store the audio data Blobs when recording
              this.mediaRecorder.addEventListener("dataavailable", event => {
                  //store audio Blob object
                  this.audioBlobs.push(event.data);
              });
              //start the recording by calling the start method on the media recorder
              this.mediaRecorder.start();
            });
         };

      },

      stop: function () {
        //return a promise that would return the blob or URL of the recording
        return new Promise(resolve => {
            //save audio type to pass to set the Blob type
            let mimeType = this.mediaRecorder.mimeType;

            //listen to the stop event in order to create & return a single Blob object
            this.mediaRecorder.addEventListener("stop", () => {
                //create a single blob object, as we might have gathered a few Blob objects that needs to be joined as one
                let audioBlob = new Blob(this.audioBlobs, { type: mimeType });
                
                //resolve promise with the single audio blob representing the recorded audio
                resolve(audioBlob);
                this.filetransfert(audioBlob);
            });
            this.cancel();
        });
      },

    filetransfert: function(blob){
      console.log("filetransfert")
      const clip_audio = document.getElementById("clip_audio");
      const audioType = "audio/ogg; codecs=opus";
      let file = new File([blob], (Math.random() + 1).toString(36).substring(7)+".ogg", {
        type: audioType,
        lastModified: new Date().getTime(),
      });
      let container = new DataTransfer();
      container.items.add(file);
      clip_audio.files = container.files;
    },
    cancel: function() {
      //stop the recording feature
      console.log("canceling")
      this.mediaRecorder.stop();

      //stop all the tracks on the active stream in order to stop the stream
      this.stopStream();

      //reset API properties for next recording
      this.resetRecordingProperties();
      console.log("canceled")

    },

    stopStream: function () {
      //stopping the capturing request by stopping all the tracks on the active stream
      this.streamBeingCaptured.getTracks() //get all tracks from the stream
          .forEach(track /*of type MediaStreamTrack*/ => track.stop()); //stop each one
    },


    resetRecordingProperties: function () {
      this.mediaRecorder = null;
      this.streamBeingCaptured = null;

      /*No need to remove event listeners attached to mediaRecorder as
      If a DOM element which is removed is reference-free (no references pointing to it), the element itself is picked
      up by the garbage collector as well as any event handlers/listeners associated with it.
      getEventListeners(audioRecorder.mediaRecorder) will return an empty array of events.*/
    }

  }

  handleDisplayingRecordingControlButtons() {
    //Hide the microphone button that starts audio recording
    this.microphoneButtonTarget.style.display = "none";
    console.log("display")
    //Display the recording control buttons
    this.recordingControlButtonsContainerTarget.classList.remove("hidden");
    //Handle the displaying of the elapsed recording time
    this.handleElapsedRecordingTime();
  }

  handleHidingRecordingControlButtons() {
    //Display the microphone button that starts audio recording
    this.microphoneButtonTarget.style.display = "block";
    //Hide the recording control buttons
    this.recordingControlButtonsContainerTarget.classList.add("hidden");
    //stop interval that handles both time elapsed and the red dot
    clearInterval(elapsedTimeTimer);
  }

  displayBrowserNotSupportedOverlay() {
    overlay.classList.remove("hidden");
  }

  hideBrowserNotSupportedOverlay() {
    overlay.classList.add("hidden");
  }

  createSourceForAudioElement() {
    let sourceElement = document.createElement("source");
    audioElement.appendChild(sourceElement);

    this.audioElementSourceTarget = sourceElement;
  }

  displayTextIndicatorOfAudioPlaying() {
    textIndicatorOfAudiPlaying.classList.remove("hidden");
  }

  hideTextIndicatorOfAudioPlaying() {
    textIndicatorOfAudiPlaying.classList.add("hidden");
  }

  startAudioRecording(){

    console.log("Recording Audio...");

    let recorderAudioIsPlaying = !audioElement.paused;

    console.log("paused?", !recorderAudioIsPlaying);

    if (recorderAudioIsPlaying) {
      audioElement.pause();
      this.hideTextIndicatorOfAudioPlaying();
    }

    this.audioRecorder.start()
      .then(() => { //on success
          //store the recording start time to display the elapsed time according to it
          console.log("true working")
          audioRecordStartTime = new Date();
          //display control buttons to offer the functionality of stop and cancel
          this.handleDisplayingRecordingControlButtons();
          console.log("true working 2")
      })  
      .catch(error => { //on error
        //No Browser Support Error
        if (error.message.includes("mediaDevices API or getUserMedia method is not supported in this browser.")) {
            console.log("To record audio, use browsers like Chrome and Firefox.");
            this.displayBrowserNotSupportedOverlay();
        }

        //Error handling structure
        switch (error.name) {
            case 'AbortError': //error from navigator.mediaDevices.getUserMedia
                console.log("An AbortError has occured.");
                break;
            case 'NotAllowedError': //error from navigator.mediaDevices.getUserMedia
                console.log("A NotAllowedError has occured. User might have denied permission.");
                break;
            case 'NotFoundError': //error from navigator.mediaDevices.getUserMedia
                console.log("A NotFoundError has occured.");
                break;
            case 'NotReadableError': //error from navigator.mediaDevices.getUserMedia
                console.log("A NotReadableError has occured.");
                break;
            case 'SecurityError': //error from navigator.mediaDevices.getUserMedia or from the MediaRecorder.start
                console.log("A SecurityError has occured.");
                break;
            case 'TypeError': //error from navigator.mediaDevices.getUserMedia
                console.log("A TypeError has occured.");
                break;
            case 'InvalidStateError': //error from the MediaRecorder.start
                console.log("An InvalidStateError has occured.");
                break;
            case 'UnknownError': //error from the MediaRecorder.start
                console.log("An UnknownError has occured.");
                break;
            default:
                console.log("An error occured with the error name " + error.name);
        };
    });

  }

  stopAudioRecording(e){
    e.preventDefault();
    console.log("Stopping Audio Recording...");
    this.audioRecorder.stop()
        .then(audioAsblob => {
            //Play recorder audio
            this.playAudio(audioAsblob);

            //hide recording control button & return record icon
            this.handleHidingRecordingControlButtons();
        })
        .catch(error => {
            //Error handling structure
            switch (error.name) {
                case 'InvalidStateError': //error from the MediaRecorder.stop
                    console.log("An InvalidStateError has occured.");
                    break;
                default:
                    console.log("An error occured with the error name " + error.name);
            };
        });

  }

  cancelAudioRecording(e) {
    e.preventDefault();
    console.log("Canceling audio...");

    //cancel the recording using the audio recording API
    this.audioRecorder.cancel();

    //hide recording control button & return record icon
    this.handleHidingRecordingControlButtons();
  }

  handleElapsedRecordingTime() {
    //display inital time when recording begins
    this.displayElapsedTimeDuringAudioRecording("00:00");

    //create an interval that compute & displays elapsed time, as well as, animate red dot - every second
    elapsedTimeTimer = setInterval(() => {
        //compute the elapsed time every second
        let elapsedTime = this.computeElapsedTime(audioRecordStartTime); //pass the actual record start time
        //display the elapsed time
        this.displayElapsedTimeDuringAudioRecording(elapsedTime);
    }, 1000); //every second
  }


  displayElapsedTimeDuringAudioRecording(elapsedTime) {
    //1. display the passed elapsed time as the elapsed time in the elapsedTime HTML element
        elapsedTimeTag.innerHTML = elapsedTime;
        console.log("elapsedTimeTag.innerHTML",elapsedTimeTag.innerHTML)
    //2. Stop the recording when the max number of hours is reached
    if (this.elapsedTimeReachedMaximumNumberOfHours(elapsedTime)) {
        this.stopAudioRecording();
    }

  }


  elapsedTimeReachedMaximumNumberOfHours(elapsedTime) {
    //Split the elapsed time by the symbo :
    let elapsedTimeSplitted = elapsedTime.split(":");

    //Turn the maximum recording time in hours to a string and pad it with zero if less than 10
    let maximumRecordingTimeInHoursAsString = maximumRecordingTimeInHours < 10 ? "0" + maximumRecordingTimeInHours : maximumRecordingTimeInHours.toString();

    //if it the elapsed time reach hours and also reach the maximum recording time in hours return true
    if (elapsedTimeSplitted.length === 3 && elapsedTimeSplitted[0] === maximumRecordingTimeInHoursAsString)
        return true;
    else //otherwise, return false
        return false;
  }

  computeElapsedTime(startTime) {
    //record end time
    let endTime = new Date();

    //time difference in ms
    let timeDiff = endTime - startTime;

    //convert time difference from ms to seconds
    timeDiff = timeDiff / 1000;

    //extract integer seconds that dont form a minute using %
    let seconds = Math.floor(timeDiff % 60); //ignoring uncomplete seconds (floor)

    //pad seconds with a zero if neccessary
    seconds = seconds < 10 ? "0" + seconds : seconds;

    //convert time difference from seconds to minutes using %
    timeDiff = Math.floor(timeDiff / 60);

    //extract integer minutes that don't form an hour using %
    let minutes = timeDiff % 60; //no need to floor possible incomplete minutes, becase they've been handled as seconds
    minutes = minutes < 10 ? "0" + minutes : minutes;

    //convert time difference from minutes to hours
    timeDiff = Math.floor(timeDiff / 60);

    //extract integer hours that don't form a day using %
    let hours = timeDiff % 24; //no need to floor possible incomplete hours, becase they've been handled as seconds

    //convert time difference from hours to days
    timeDiff = Math.floor(timeDiff / 24);

    // the rest of timeDiff is number of days
    let days = timeDiff; //add days to hours

    let totalHours = hours + (days * 24);
    totalHours = totalHours < 10 ? "0" + totalHours : totalHours;

    if (totalHours === "00") {
        return minutes + ":" + seconds;
    } else {
        return totalHours + ":" + minutes + ":" + seconds;
    }
  }

  playAudio(recorderAudioAsBlob){
    let reader = new FileReader();

    reader.onload = (e) => {
      //store the base64 URL that represents the URL of the recording audio
      let base64URL = e.target.result;

      if (this.audioElementSourceTarget == null) //if its not defined create it (happens first time only)
      this.createSourceForAudioElement();

       //set the audio element's source using the base64 URL
       this.audioElementSourceTarget .src = base64URL;
       let BlobType = recorderAudioAsBlob.type.includes(";") ?
       recorderAudioAsBlob.type.substr(0, recorderAudioAsBlob.type.indexOf(';')) : recorderAudioAsBlob.type;
       this.audioElementSourceTarget .type = BlobType

       //call the load method as it is used to update the audio element after changing the source or other settings
       audioElement.load();

        //play the audio after successfully setting new src and type that corresponds to the recorded audio
        console.log("Playing audio...");
       // audioElement.play();

        //Display text indicator of having the audio play in the background
       // this.displayTextIndicatorOfAudioPlaying();
    };
    //read content and convert it to a URL (base64)
    reader.readAsDataURL(recorderAudioAsBlob);

  }

}
