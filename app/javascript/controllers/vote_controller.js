import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vote"
export default class extends Controller {
  connect() {
    console.log("vote controller")
  }
  
  playsong(e) {
    //var player = document.getElementById('myaudio');
    var yesbutton = document.getElementById('yesbutton')
    var halftime = e.duration/2
    if (e.currentTime >= halftime) {
      yesbutton.disabled = false;

    }
  }
  upvote = (e) => {
    e.preventDefault();
    const clip_id = document.getElementById('clip_id')
    const user_id = document.getElementById('user_id')
    const formData = new FormData()
    formData.append('vote[is_valid]', true)
    formData.append('vote[clip_id]', clip_id.value)
    formData.append('vote[user_id]', user_id.value)
    fetch('http://localhost:3000/votes', {
        method: 'POST',
        body: formData,
      })
      .then((res) => res.json())
      .then((ans) => {
        console.log(ans)
      })
      location.reload();
  }

  downvote = (e) => {
    e.preventDefault();
    const clip_id = document.getElementById('clip_id')
    const user_id = document.getElementById('user_id')
    const formData = new FormData()
    formData.append('vote[is_valid]', false)
    formData.append('vote[clip_id]', clip_id.value)
    formData.append('vote[user_id]', user_id.value)
    fetch('http://localhost:3000/votes', {
        method: 'POST',
        body: formData,
      })
      .then((res) => res.json())
      .then((data) => {
        console.log(data)
      })
      .catch((error)=>{
        console.log("Error :",error);
      })
      location.reload();
  }

  
}
