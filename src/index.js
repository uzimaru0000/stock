'use struct'

import './index.html';
import './style.css';
import 'bulma/css/bulma.css';
import 'spinkit/css/spinners/8-circle.css';

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
const provider = new firebase.auth.TwitterAuthProvider();
auth.languageCode = 'jp';
auth.getRedirectResult();
auth.onAuthStateChanged((() => {
    let flag = false;
    return user => {
        if (!flag) {
            elmInit(Main.fullscreen(user ? createUser(user) : null));
            flag = true;
        }
    };
})());

const createUser = raw => {
    return {
        name: raw.displayName,
        iconUrl: raw.photoURL || null
    };
};

const elmInit = app => {
    app.ports.login.subscribe(() => {
        if (!auth.currentUser) {
            auth.signInWithRedirect(provider);
        }
    });

    app.ports.logout.subscribe(() => {
        if (auth.currentUser) auth.signOut().then(_ => app.ports.logoutSuccess.send(null));
    });

    app.ports.postListInit.subscribe(() => {
        db.ref(`${auth.currentUser.uid}/posts`)
            .once('value')
            .then(ss => {
                const postList = [];
                ss.forEach(x => {
                    postList.push({
                        uid: x.key,
                        asset: x.val()
                    });
                });

                app.ports.getPostListData.send(postList);
            });
    });

    app.ports.editInit.subscribe(uid => {
        db.ref(`${auth.currentUser.uid}/posts/${uid}`)
            .once('value')
            .then(ss => app.ports.getEditData.send({ uid: ss.key, asset: ss.val() }));
    });

    app.ports.storePost.subscribe(post => {
        if (post[0]) {
            db.ref(`${auth.currentUser.uid}/posts/${post[0]}`)
                .set(post[1])
                .then(_ => app.ports.successStorePost.send(post[0]));
        } else {
            db.ref(`${auth.currentUser.uid}/posts`)
                .push(post[1])
                .then(x => app.ports.successStorePost.send(x.key));
        }
    });

    app.ports.postInit.subscribe(uid => {
        db.ref(`${auth.currentUser.uid}/posts/${uid}`)
            .once('value')
            .then(ss => app.ports.getPostData.send({ uid: ss.key, asset: ss.val() }));
    });

};