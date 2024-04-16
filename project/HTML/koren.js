

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


console.log(app)

const dbRef = firebase.database().ref("/tofb2");
const dbRef2 = firebase.database().ref("/tofb");

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
      document.getElementById("dbsender").innerHTML = '<span id="dbsender">'+data.val()+'</span>'
  }


  firebase.database().ref("/tofb").on('value',sensData);

  function sensData(data){

    console.log(data.val().toString(2).padStart(8, '0'))
   L =  data.val().toString(2).padStart(8, '0').substring(0, 4)
   R =  data.val().toString(2).padStart(8, '0').substring(4, 8)
   console.log(parseInt(L, 2))
   console.log(parseInt(R, 2))
    document.getElementById("dbsender").innerText = parseInt(R, 2)
    document.getElementById("signuptext").innerText = parseInt(L, 2)
  }

 

  // Function to send a value to Firebase
  function sendValueToFirebase(value) {
      dbRef.set(value);
  }
  
  // Event listener for the button click
  document.getElementById("sendButton").addEventListener("click", function() {
    
      sendValueToFirebase(1);
  });

  
  // Function to send a value of 0 to Firebase
function sendZeroToFirebase() {
  const valueToSend = 0; // Value to send (in this case, 0)
  dbRef.set(valueToSend); // Replace "/tofb" with your desired path
  // OR use this line for the "/rx" path:
  // firebase.database().ref("/rx").set(valueToSend);
}

// Event listener for the turn-off button click
document.getElementById("turnOffButton").addEventListener("click", function() {
  // Call the function to send 0 to Firebase when the turn-off button is clicked
  sendZeroToFirebase();
});


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
    } else if (value === 0) {
        // Logic for turning off
        console.log('Turn Off');
    } else if (value === 'changeHumidity') {
        // Logic for submitting humidity value
        console.log('Change Humidity');
    }
}

function updateSliderValue(sliderValue) {
    // Update the text showing the selected value for the humidity slider
    document.getElementById('sliderValue').innerText = 'Selected Value: ' + sliderValue;
}

function convertPercentToBin(percent)
{
  if()
}