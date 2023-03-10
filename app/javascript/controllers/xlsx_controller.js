
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vote"
export default class extends Controller {
  connect() {
    console.log("xlsx controller")
  }
  

downloadBlob(blob, name = 'file.xlsx') {
  // Convert your blob into a Blob URL (a special url that points to an object in the browser's memory)
  
  const blobUrl = URL.createObjectURL(blob);

  // Create a link element
  const link = document.createElement("a");

  // Set link's href to point to the Blob URL
  link.href = blobUrl;
  link.download = name;

  // Append link to the body
  document.body.appendChild(link);

  // Dispatch click event on the link
  // This is necessary as link.click() does not work on the latest firefox
  link.dispatchEvent(
    new MouseEvent('click', { 
      bubbles: true, 
      cancelable: true, 
      view: window 
    })
  );

  // Remove link from body
  document.body.removeChild(link);
}


/* For the example */
//const exportButton = document.getElementById('export');
//const jsonBlob = new Blob(['{"name": "test"}'])

//exportButton.addEventListener('click', () => {
  //downloadBlob(jsonBlob, 'myfile.json');
//});


}