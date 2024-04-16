

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCufBc900fpie6WrI2BtNXUlPCxetqM0v8",
  authDomain: "koren-esp32.firebaseapp.com",
  databaseURL: "https://koren-esp32-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "koren-esp32",
  storageBucket: "koren-esp32.appspot.com",
  messagingSenderId: "572323561403",
  appId: "1:572323561403:web:1a8cf334c3305f9403ce9e"
};
// Initialize Firebase
const app = firebase.initializeApp(firebaseConfig);


console.log(app);

const dbRef = firebase.database().ref("/tofb2");
const dbRef2 = firebase.database().ref("/tofb");

if(document.URL.includes("about%20us.html"))
  {
    firebase.database().ref("/tofb").on('value', sensData);
  }


function sensData(data) {
  var binaryData = data.val().toString(2).padStart(8, '0');
  var L = binaryData.substring(0, 4);
  var R = binaryData.substring(4, 8);

  // Print the data to the console for debugging
  console.log("Raw Data:", data.val());
  console.log("Binary Data:", binaryData);
  console.log("Parsed L:", parseInt(L, 2));
  console.log("Parsed R:", parseInt(R, 2));

  // Update the corresponding HTML elements
  document.getElementById("waterLevelSensor").innerText = parseInt(L, 2);
    document.getElementById("soilMoistureSensor").innerText = parseInt(R, 2);
}

let getFromDbX = "";

window.addEventListener("load",() =>{
  getFromDb();

});

function getFromDb(){
  dbRef2.on("value",(snapshot) => {
    if(snapshot.exists()){
      getFromDbX = snapshot.val();
      console.log(snapshot.val());
      
    }
  })
}



function createUserOnBB(){
    email = document.getElementById("email").value;
    password = document.getElementById("pass").value;

    
    

    //יש לבדוק את הנתונים שנקלתים מהיזר


    firebase.auth().createUserWithEmailAndPassword(email, password)
  .then((userCredential) => {
    // Signed in 
    inpname = document.getElementById("name").value;
    email = document.getElementById("email").value;
    password = document.getElementById("pass").value;

    var user = userCredential.user;
    console.log(user.uid)
    console.log(userCredential)
    
    data = {
      name:inpname,
      email:email,
      password:password,

  }
  console.log(data.email)
  firebase.database().ref('users/'+data.name).set(data);

   
    // ...
  })
  .catch((error) => {
    var errorCode = error.code;
    var errorMessage = error.message;
    console.log(errorMessage)
    // ..
  });

}


function login(){
    email = document.getElementById("email2").value
    password = document.getElementById("pass2").value
    console.log(password)
    console.log(email)


    //יש לבדוק את הנתונים שנקלתים מהיזר



    firebase.auth().signInWithEmailAndPassword(email, password)
  .then((userCredential) => {
    // Signed in 
    var user = userCredential.user;
    console.log(user.uid)
    console.log(userCredential)
    // ...
  })
  .catch((error) => {
    var errorCode = error.code;
    var errorMessage = error.message;
    console.log(errorMessage)
    // ..
  });
}



firebase.database().ref("users/kurin/name").on('value',newData);

  function newData(data){
    console.log(data.val())
      //document.getElementById("dbsender").innerHTML = '<span id="dbsender">'+data.val()+'</span>'
  }


  firebase.database().ref("/tofb").on('value',sensData);
 

  // Function to send a value to Firebase
  function sendValueToFirebase(value) {
      dbRef.set(value);
  }

  
  // Function to send a value of 0 to Firebase
function sendZeroToFirebase() {
  const valueToSend = 0; // Value to send (in this case, 0)
  dbRef.set(valueToSend); // Replace "/tofb" with your desired path
  // OR use this line for the "/rx" path:
  // firebase.database().ref("/rx").set(valueToSend);
}


  function SignOut(){
    firebase.auth().signOut().then(() => {
      // Sign-out successful.
    }).catch((error) => {
      // An error happened.
      console.log(error.message);
      console.log("Error Code: " + error.code);
    });
  }
  function changeValue(value) {
    // Implement logic for handling the power buttons
    if (value === 1) {
        // Logic for turning on
        console.log('Turn On');
        sendDataToESP(1);
    } else if (value === 0) {
        // Logic for turning off
        console.log('Turn Off');
        sendDataToESP(0);
    } else if (value === 'changeHumidity') {
        // Logic for submitting humidity value
        console.log('Change Humidity');
    }
}

function updateSliderValue(sliderValue) {
    // Update the text showing the selected value for the humidity slider
    document.getElementById('sliderValue').innerText = 'Selected Value: ' + sliderValue;
}
function sendDataToESP(value) {
    let bitVector = value.toString(2).padStart(8, '0');
  
    fetch("/sendToESP", {
      method: "GET",
      body: new URLSearchParams({ bitVector: bitVector }),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });
  
    // Handle the value for changeValue and updateSliderValue
    //handleData(value);
  
    // Update /tofb2 when the button is pressed
    updateToFB2(value);
  }
  
  function updateToFB2(value) {
    // Assuming dbRef2 is your Firebase database reference for /tofb2
    // Replace this with your actual path if needed
    dbRef.set({
      value: value,
      timestamp: firebase.database.ServerValue.TIMESTAMP,
    });
  }
