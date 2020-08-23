
const functions= require('firebase-functions');
const admin = require('firebase-admin');


admin.initializeApp();
const db = admin.firestore();
const fcm =admin.messaging();

var msgdate ;
var msgdatespeaker ;
var msgdateplace ;



exports. sendToDevice = functions.firestore.document('Events/{eventId}').onCreate(async snapshot => {
    msgdate = snapshot.data();
    

const querySnapshot =  await db.collection('tokens').where("Interests", "array-contains" , msgdate.trakName).get();

const tokens = new Array();


querySnapshot.forEach(async tokenDoc => {
tokens.push(tokenDoc.data().token);
console.log(tokenDoc.data().token);
});

if(Array.isArray(tokens))
{
  const payload1  ={

    "notification" : {
       "title" : "New Event are Created",
       "body" : " hello our client. Event with your preferred track " + msgdate.trakName + " was created .Tap for more details",
       "click_action": 'FLUTTER_NOTIFICATION_CLICK',
       "sound": 'eventually',
       "image": "https://k.top4top.io/p_16679fdc21.png",
       "icon" : 'https://i.ibb.co/jHW5W6J/logo.png',
    } 
    
   };
   const options = {
   Priorty : "high" , 
   
   };
   return fcm.sendToDevice(tokens , payload1,options);
}

  return console.log("Empty");




});
/******************************************************************* */
exports. sendToDevicespeakers = functions.firestore.document('Events/{eventId}').onCreate(async snapshot => {
  msgdatespeaker = snapshot.data();
  var speakers = new Array();
  const tokens = new Array();
  const queryArray =new Array();

 speakers = msgdatespeaker.speaker ;

 const query =  await db.collection('user').where('speaker' , '==' , 'speaker').get();
 var query_to_get_username = await db.collection('user').where('id' , '==' , msgdatespeaker.owner).get(); 


  query.forEach(async spek =>
  {
    for(var index of speakers)
    {
   if(spek.data().name === index )
   {
     tokens.push(spek.data().token);
    console.log(spek.data().token);
   }
    }
    
  });

  query_to_get_username.forEach(async useer =>
    {
      queryArray.push(useer.data().name);

    console.log(useer.data().name);
  
if(Array.isArray(tokens))
{
const payload1  ={

  "notification" : {
     "title" : "New invitation From "+ useer.data().name,
     "body" : useer.data().name +" invite you to attend Event  " + msgdatespeaker.name  + "  in "+ msgdatespeaker.date +  " .Tap for more details",
     "click_action": 'FLUTTER_NOTIFICATION_CLICK',
     "sound": 'eventually',
     "image": "https://k.top4top.io/p_16679fdc21.png",
     "icon" : 'https://i.ibb.co/jHW5W6J/logo.png',
  } 
  
 };
 const options = {
 Priorty : "high" , 
 
 };
 return fcm.sendToDevice(tokens , payload1,options);
}
 } );
return console.log("Empty");




});



/******************************************************************* */
exports. sendToDevicePlaces = functions.firestore.document('Events/{eventId}').onCreate(async snapshot => {
  msgdateplace = snapshot.data();
  var place ; 
  const tokens = new Array();
  place = msgdateplace.place ; 
  console.log(place);

  const querytOGetPlace =  await db.collection('place').where('placeName' , '==' , place).get();

  querytOGetPlace.forEach(async DocToken =>
  {
  if(DocToken.data().placeName === place)
    tokens.push(DocToken.data().token);
    console.log(DocToken.data().token);

  });
  
if(Array.isArray(tokens))
{
const payload1  ={

  "notification" : {
     "title" : "New Request For You",
     "body" : "your Place " + msgdateplace.place + " Has new Request for Event " + msgdateplace.name ,
     "click_action": 'FLUTTER_NOTIFICATION_CLICK',
     "sound": 'eventually',
     "image": "https://k.top4top.io/p_16679fdc21.png",
     "icon" : 'https://i.ibb.co/jHW5W6J/logo.png',
  } 
  
 };
 const options = {
 Priorty : "high" , 
 
 };
 return fcm.sendToDevice(tokens , payload1,options);
}

return console.log("Empty");




});
var msgdateJoin ; 
//////////////////////////////////////
exports. sendToDeviceJoins = functions.firestore.document('join_event_speaker/{eventId}').onCreate(async snapshot => {
  msgdateJoin = snapshot.data();
  var speaker ;
  var owner ;
  const tokens = new Array();
  const query =new Array();

 speaker = msgdateJoin.user ;
 owner = msgdateJoin.owner ; 

 var querypush =  await db.collection('user').where('id' , '==' , speaker).get();
 
 
 //console.log(query.data().name);

 const query2 = await db.collection('tokens').where('user_Id' , '==' , msgdateJoin.owner).get() ; 


 query2.forEach(async DocToken =>
  {
  if(DocToken.data().user_Id === owner)
    tokens.push(DocToken.data().token);
    console.log(DocToken.data().token);

  });
  

  querypush.forEach(async useer =>
    {
    query.push(useer.data().name);

    console.log(useer.data().name);

    if(Array.isArray(tokens))
    {
    
    const payload1  ={
    
      "notification" : {
         "title" : "speaker "+ useer.data().name +"  had accepted your Request",
         "body" : " Speaker you choosed had accepted your Request to attend event " + msgdateJoin.title + " .Tap for more details",
         "click_action": 'FLUTTER_NOTIFICATION_CLICK',
         "sound": "eventually.mp3",
         "image": "https://k.top4top.io/p_16679fdc21.png",
         "icon" : 'ic_sync_black',
         
      } 
      
     };
     const options = {
     Priorty : "high" , 
     
     };
     return fcm.sendToDevice(tokens , payload1,options);
    }

     } );



return console.log("Empty");




});
