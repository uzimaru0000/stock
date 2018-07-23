'use struct'

import './index.html';
import 'bulma/css/bulma.css';
import 'spinkit/css/spinners/2-double-bounce.css';
import './style.css';

import { Main } from './Elm/Main.elm';

// firebase setting
import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/database';
firebase.initializeApp({
    apiKey: API_KEY,
    authDomain: AUTH_DOMAIN,
    databaseURL: DATABASE_URL,
    projectId: PROJECT_ID,
    storageBucket: STORAGE_BUCKET,
    messagingSenderId: MESSAGING_SENDER_ID
});

const auth = firebase.auth();
const db = firebase.database();
const providers = new firebase.auth.TwitterAuthProvider();
auth.languageCode = 'jp';
auth.getRedirectResult();

const main = document.getElementById('main');

const app = Main.fullscreen();
