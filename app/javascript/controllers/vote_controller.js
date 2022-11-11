import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vote"
export default class extends Controller {
  connect() {
    console.log("vote controller")
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
      .then((vote) => {
        console.log(vote)
      })

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
      .then((vote) => {
        console.log(vote)
      })
  }

  
}
