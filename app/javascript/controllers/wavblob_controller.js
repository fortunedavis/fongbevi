import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Jesus")
  }

  static targets = ['downloadLink'];

  download() {
    const url = window.URL.createObjectURL(this.downloadLinkTarget.blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = 'audio.wav';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  
}
