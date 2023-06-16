// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDvxPNhYR4b9C7MS-mr3tDpTM1WiYF5vkY",
  authDomain: "chatapp-2fc3d.firebaseapp.com",
  databaseURL: "https://chatapp-2fc3d-default-rtdb.firebaseio.com",
  projectId: "chatapp-2fc3d",
  storageBucket: "chatapp-2fc3d.appspot.com",
  messagingSenderId: "303940029661",
  appId: "1:303940029661:web:71a42f37794985df1d1f34",
  measurementId: "G-YBZQTQE3XC"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);