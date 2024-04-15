#include <WiFi.h>//ESP אשר בעזרתה ניתן לתקשר עם ה  WIFIספריית ה 
#include <FirebaseESP32.h>//Firebase ל FirebaseESP32 הספרייה המשלבת בין 
#include <Wire.h>//I2C המאפשרת תקשורת של  Wire ספריית ה 
#include <Adafruit_GFX.h>//אשר מספקת פונקציות גרפיות לתצוגות Adafruit Graphics ספריית ה 
#include <Adafruit_SSD1306.h>//OLED בתצוגת  SSD1306 המשמשת לשליטת  Adafruit SSD1306 ספריית ה 
// Provide the token generation process info.
#include <addons/TokenHelper.h>//פונקציות עזר נוספות לניהול אסימוני אימות
// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>//Firebase פונקציות עזר נוספות המשמשות אינטרקציה עם מסד הנתונים במן אמת של 

#define SCREEN_WIDTH 128 // הגדרת רוחב התצוגה כ128 פיקסלים
#define SCREEN_HEIGHT 32 // הגדרת גובה התצוגה כ 32 פיקסלים

// create an OLED display object connected to I2C
Adafruit_SSD1306 oled(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);//הגדרת אוביקט חדש המאפשר לבצע פעולות על המסך

FirebaseAuth auth;//Auth בשם FirebaseAuth ספריית קלט של 
FirebaseConfig config;//config בשם FirebaseConfig ספריית קלט של 

// Assign the project host and api key 
const char* FIREBASE_HOST = "koren-esp32-default-rtdb.europe-west1.firebasedatabase.app";//הגדרת כתובת המארח
const char* API_KEY = "AIzaSyCufBc900fpie6WrI2BtNXUlPCxetqM0v8";;//Firebase של ה  APIהגדרת מפתח ה 
const char* WIFI_SSID ="Kinneret College";//הגדרת שם הרשת האלחוטית
const char* WIFI_PASSWORD = "";// הגדרת הסיסמא לרשת האחלוטית

#define ledpin 2//המחובר להדק 2 של המיקרוקונטרולר LED קבוע בשם 
#define RXD2 16//המחובר להדק הקלט הפיזי של המיקרוקונטרולר RX קבוע בשם  
#define TXD2 17//המחובר להדק הפלט הפיזי של המיקרוקונטרולר TX קבוע בשם 

//Define Firebase Data objects
FirebaseData fbdo;//FirebaseData המשמש לביצוע פעולות קריאה וכתיבה בבסיס הנתונים של fbdo הגדרת משתנה בשם 
int FromFB, FromAlt;// Firebase הגדרת 2 משתנים המשמשים כאחסון לערכים הנקראים מבסיס הנתונים של 
bool a = false;//false הגדרת משתנה בוליאני אשר מוגדר כ
/* ------------- functions declaration ---------------------*/

void blink1();//אשר מבצעת פעולות הבהוב של הלד blink1 הגדרת פונקציה בשם 
void ItoBin(int a, char* arr);//אשר מקבלת מספר שלם ומערך של תווים ItoBin הגדרת פונקצייה בשם 
int binToDec(String a);//לבינארי a אשר ממירה את המשתנה  binToDec הגדרת פונקציה בשם 


void setup() {
  pinMode(ledpin, OUTPUT);//הגדרת התקן זה כפלט
  Serial.begin(115200);//התחלת קריאה וכתיבת מידע ראשית מול המחשב בקצב של 115200 ביט לשנייה
  Serial2.begin(9600, SERIAL_8N1, RXD2, TXD2);//התחלת קריאה וכתיבה בקצב של 9600 ביט לשנייה, מציינים את התקני פלט וקלט 
  // initialize OLED display with I2C address 0x3C
  if (!oled.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {//אם הפעלת המסך נכשלת, התכנית תדפיס הודעת שגיאה
    Serial.println(F("failed to start SSD1306 OLED"));//ההודעת שגיאה 
    while (1);//הגדרת לולאה אינסופית
  }

  delay(2000);         // wait two seconds for initializing//הגדרת השהייה של ההרצה של 2 שניות


  while (Serial2.available()) {//כל עוד יש נתנוים זמינים הלולאה תמשיך
    FromAlt = Serial2.read();//FromAlt הנתונים נשמרים במשתנה   


    delay(2);//הגדרת השהייה של ההרצה ל2  מילי שניות
  }

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);//פקודה אשר מתחברת לאינטרנט
  Serial.print("Connecting to Wi-Fi");//הדפס הודעה שמחובר לאינטרנט
  while (WiFi.status() != WL_CONNECTED) {//לולאה הממתינה עד שניהיה התחברות לאינטרנט
    Serial.print(".");//הדפסת נקודה בכל תהליך של ההתחברות
    delay(300);//השהייה של 0.3 שניות ין כל נקודה המודפסת
  }
  Serial.println();//הדפסת שורה ריקה
  Serial.print("Connected with IP: ");//Connected with IP: הדפסת המחרוזת 
  Serial.println(WiFi.localIP());//הדפסת כתובת אינטרנט
  Serial.println();//הדפסת שורה ריקה

  // Assign the project host and api key 
  config.host = FIREBASE_HOST;//FIREBASE_HOST כמשתנה קבוע הנקרא  Firebase של השרת URL קובע את כתובת ה 
  config.api_key = API_KEY;//API_KEY כמשתנה קבוע הנקרא  Firebase של ה  API קובע את המפתח 
  config.token_status_callback = tokenStatusCallback;//tokenStatusCallback הגדרת פונקציית הקריאה החוזרת כמשתנה קבוע בשם 

  Firebase.reconnectWiFi(true);//פעולה המפעילה מחדש את החיבור לאינטרנט
  if (Firebase.signUp(&config, &auth, "", "")) {//בודקים את נוצר חיבור
    Serial.println("ok");//אם החיבור נוצר בהצלחה ok הדפסת 
  }

  Firebase.begin(&config, &auth);//פונקציה זו מאתחלת את החיבור והשירות של המיקרו בקר

}
void loop() {
  if (Firebase.getInt(fbdo, "tofb2/value")) {//אם כן הערך נשמר, Firebase בדיקה אם הפונקציה הצליחה לקרוא את הנתונים ב 
    FromFB = fbdo.intData();//פעולה זו מתרגמת את הערך לערך מספרי
  }
  delay(2);//השהייה של 2 מילי שניות

  if (Serial2.available()) {//בדיקה האם ישנם נתונים זמינים לקריאה
    Serial2.write(FromFB);//Serial2 דרך הדק  FromFB אם כן אז תשלח את ערך המשתנה 
    // Write data to Firebase when data is available from Serial2
  }
  delay(2);//השהייה של 2 מילי שניות

  while (Serial2.available()) {//בדיקה אם יש נתונים זמיני לקריאה
    FromAlt = Serial2.read();//Serial2 הפקודמה מקריאה את הנתונים הזמינים מפורט 
    delay(5);//השהייה של 5 מילי שניות
    Serial.println(FromAlt);//למסך הטרמינל Serial2 הדפסת הערכין מפורט 
    if(Firebase.setInt(fbdo, "tofb", FromAlt))//Firebase בדיקה האם התוכנית הצליחה לשלוח את הערכים מהפורט הסידורי לבסיס הנתונים של 
    {
    char arr[8]; // Declare as a local array//הגדרת מערך בגודל 8 תווים 
    ItoBin(FromAlt, arr);//פונקצייה אשר ממירה את הערך שנקרא לערך בינארי
    String waterH = String(arr[0]) + String(arr[1]) + String(arr[2]) +  String(arr[3]);//שרשור בין הערכים של החיישן גובה מים המגיעים מהמערך
    int waterH2 = binToDec(waterH);//waterH2 משנים את ערך המחרוזת לערך מספר שלם בעזרת הפונקציה ומכניסים למשתנה 
    Serial.print("water level: ");//"water level: " הדפסת הטקסט 
    Serial.println(waterH2);//בשורה חדשה waterH2 הדפסת ערכי המשתנה 
    delay(5);//השהייה של 5 מילי שניות
    String moist = String(arr[4]) + String(arr[5]) + String(arr[6]) +  String(arr[7]);//שרשור בין הערכים של החיישן לחות המגיעים מהמערך
    int moist2 = binToDec(moist);//פונקצייה אשר אשר ממירה את המחרוזת הבינארית למספר שלם
    Serial.print("moisture: ");//"moisture: " הדפסת הטקסט 
    Serial.println(moist2);//בשורה חדשה moist2 הדפסת ערכי המשתנה 
    delay(5);//השהייה של 5 מילי שניות
    }
    // Write data to Firebase when data is available from Serial2
  }
  fbdo.clear();//איפוס המשתנה, על מנת שיהיה אפשר להכניס לו ערכים חדשים
  blink1();//פונקצייה הגורמת להבהוב הלד
  delay(50);//השהייה של 50 מילי שניות
}


void blink1() {//הפונקצייה משנה ערך של משתנה להפוך ממנו
  a = not a;// המשתנה שווה להפך ממנו
  if (a == true) {//נכון a בודקים אם 
    digitalWrite(ledpin, HIGH);//אם כן נפעיל את הפינה הדיגיטלית המסומנת על ידי המשתמש

  }
  else {//אם לא
    digitalWrite(ledpin, LOW);//נכבה את הפינה הדיגיטלית

  }
}

void ItoBin(int a, char* arr) {//הגדרה של פונקצייה המקבלת 2 ארגומנטים
  int b = a; // Use a different variable name to avoid conflict//a הגדרת משתנה השווה ל
  int i = 0;// הגדרת משתנה השווה ל0

  for (int bit = 128; bit >= 1; bit = bit / 2) {//לולאה העוברת ובודקת את כל התווים של המספר,מהתו הראשון לאחרון
    if ((b - bit) >= 0) {//בודקים אם המשתנה פחות התו שווה או גדול מ0
      arr[i] = '1';// אם כן התו במיקום שווה ל 1
      b -= bit;//הגדרת המשתנה כשווה לעצמו פחות התו
    } else {//אם לא
      arr[i] = '0';// התו במיקום שווה ל0
    }
    i++;//העלת המונה לולאה
  }
}

int binToDec(String a) {//פונקציה המקבלת מחרוזת כארגומנט ומחזירה את הערך העשרוני שלו
  int decVal = 0;//ואיפוסו decVal הגדרת משתנה בשם 

  for (int i = 0; i < a.length(); i++) {//לולאה העוברת על כל תו במערך
    int bit = a.charAt(i) - '0'; // ממיר את התו למספר
    decVal = decVal * 2 + bit; // מעדכן את הערך העשרוני
  }

  return decVal;//מחזירה את הערך העשרוני של המספר
}