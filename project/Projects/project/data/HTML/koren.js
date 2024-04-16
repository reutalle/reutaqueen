

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCufBc900fpie6WrI2BtNXUlPCxetqM0v8", //Firebase שמשמש לאימות ואישור כדי לגשת לשירותי ה Firebase של ה API -מפתח ה  
  authDomain: "koren-esp32.firebaseapp.com", //Firebase Authentication הכתובת אינטררנט שבה מתבצע אימות המשתמשים באמצעות 
  databaseURL: "https://koren-esp32-default-rtdb.europe-west1.firebasedatabase.app", //זוהי הכתובת אינטרנט
  storageBucket: "koren-esp32.appspot.com", //Firebase Storage המקום בו נשמרים קבצים בשירות אחסון 
  messagingSenderId: "572323561403",//Firebase Cloud Messaging (FCM)המשתמש בשירות ID זהו השולח 
  appId: "1:572323561403:web:1a8cf334c3305f9403ce9e" // Firebase זהו זיהוי היישום בתוך הפרויקט
};
// Initialize Firebase
const app = firebase.initializeApp(firebaseConfig); // FirebaseConfigבעזרת הגדרות הנתונים שנמצאים ב Firebase אתחול ה


console.log(app); //לקונסולה Firebaseמדפיסים את היישום של ה

const dbRef = firebase.database().ref("/tofb"); //Firebase בבסיס הנתונים של ה tofb2 מגדירים משתנה מסוג רפרנס בשם 

if(document.URL.includes("about%20us.html")) //אם כן אז , "about%20us.html" בודקים את הכתובת הנוכחית כוללת את המחרוזת 

  {
    firebase.database().ref("/tofb").on('value', sensData); // כאשר ישנם שינויים sensData וקוראים לפונקצייה  Firebase מגדירים מאזין לשינויים של הנתונים במשתנה הממוקם ב 
  }


function sensData(data) { 
   var binaryData = data.val().toString(2).padStart(8, '0');//המרת הנתונים שנקלטו למחרוזת בינארית באורך של 8 תווים
   var L = binaryData.substring(0, 4); //binaryData מציגים את 4 התווים הימניים במחרוזת 
   var R = binaryData.substring(4, 8);//binaryData מציגים את 4 התווים השמאליים במחרוזת 

  // Print the data to the console for debugging
  console.log("Raw Data:", data.val()); //Firebase הדפסת הנתונים המקוריים מבסיס הנתונים של ה  
   console.log("Binary Data:", binaryData); //הדפסת הנתונים המקוריים אחרי המרתם לבינארי
   console.log("Parsed L:", parseInt(L, 2));//אשר הומר מבינארי למספר שלם L מדפיס את הערך של 
   console.log("Parsed R:", parseInt(R, 2));//אשר הומר מבינארי למספר שלם R מדפיס את הערך של 
  // Update the corresponding HTML elements
  
}






function createUserOnBB(){//This line declares a JavaScript function named createUserOnBB.
    email = document.getElementById("email").value;//מקבל את הערך שהוזן לו בשדה הטקסט המשויך לו email המשתנה 
    password = document.getElementById("pass").value;//מקבל את הערך שהוזן לו בשדה הטקסט המשויך לו password המשתנה 
    //יש לבדוק את הנתונים שנקלתים מהיוזר
    firebase.auth().createUserWithEmailAndPassword(email, password)// firebaseומעבירים ל createUserWithEmailAndPassword יוצרים משתמש חדש לפי 
  .then((userCredential) => {//מקבלים את הנתונים של המשתמש החדש
    // Signed in 
    inpname = document.getElementById("name").value;//את הערך שהוזן בשדה הטקסט המשויך לו  name מעבירים למשתנה 
    email = document.getElementById("email").value;//את הערך שהוזן בשדה הטקסט המשויך לו  email מעבירים למשתנה 
    password = document.getElementById("pass").value;//את הערך שהוזן בשדה הטקסט המשויך לו  pass מעבירים למשתנה 

    var user = userCredential.user;// userCredential משיגים את המשתמש מתוך הנתונים הנמצאים במשתנה 
    console.log(user.uid)//מדפיסים את נתוני המשתמש
    console.log(userCredential)//Firebase מדפיסים את נתוני המשתמש המאומת באמצעות ה
    data = {
      name:inpname,
      email:email,
      password:password,//בו אנו שומרים את הנתונים אשר נרצה לשמור data מגדירים אובייקט בשם  

  }
  console.log(data.email)//בודק אם המייל רשום נכון

  firebase.database().ref('users/'+data.name).set(data);//firebase הגדרת מיקום הנתונים של המשתמש ב

   
    
  })
  .catch((error) => {

    var errorCode = error.code;
    var errorMessage = error.message;
    console.log(errorMessage)
    // //מגלה ופותר שגיאות הנוצרו במהלך יצירת המשתמש, מודיע הודעה אם ישנם שגיאות
  });

}


function login(){
    email = document.getElementById("email2").value//email את ערך המשתנה  email2 מעבירים למשתנה 
    password = document.getElementById("pass2").value//password את ערך המשתנה  pass2 מעבירים למשתנה 
    console.log(password)//מדפיסים את הסיסמא
    console.log(email)// מדפיסים את האימייל
    firebase.auth().signInWithEmailAndPassword(email, password)//ביצוע התחברות
  .then((userCredential) => {
    // Signed in 
    var user = userCredential.user;//משיגים את המשתמש לפי פרטי המשתמש שהושגו
    console.log(user.uid)//מדפיסים את פרטי זיהוי המשתמש אשר מחובר
    console.log(userCredential)//מדפיסים את הנתונים של המשתמש ומידע על ההתחברות
    // ...
  })
  .catch((error) => {//אם ההתחברות נכשלה, יודיע למשתמש
    var errorCode = error.code;
    var errorMessage = error.message;
    console.log(errorMessage)
    // ..
  });
}






  firebase.database().ref("/tofb").on('value',sensData);//אשר בודק אם הנתונים משתנים, אם כן אז sensData הגדרת מסלול ב
 



  function SignOut(){//פונקציה זו מבצעת התנתקות מהמשתמש, אם ההתנתקות נכשלה ידפיס שגיאה
    firebase.auth().signOut().then(() => {
      // Sign-out successful.
    }).catch((error) => {
      // An error happened.
      console.log(error.message);
      console.log("Error Code: " + error.code);
    });
  }
