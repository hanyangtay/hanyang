# Twitter

A Twitter app with my own UI design concept. Built with Ruby on Rails.
It's live! You can play with it here (https://twitter-hanyang.herokuapp.com).

### Screenshot
![alt text](https://raw.githubusercontent.com/hanyangtay/twitter/master/twitter.jpg "Twitter")

### Dynamic loading

Users can see their stats update immediately upon any of the actions. Only relevant sections of the web page are reloaded, saving user bandwidth.
    
### User authentication model
  * E-mails for account activations and password resets
  * Guest account access
  * Secure password hashing (storage of password digests in database)
  * Pseudo-randomly generated avatar images for new users (can be changed)
  
Always assume a malicious user.
Server-side validations are a must, and always trump client-side validations.
   
### Tweet model
  * Upload  with live preview
  * Like, retweet, delete
    
### Social Media
  * Follow, unfollow users
  * Dynamically created status feed
    
Learned the MVC model by repeatedly coding different relationships between users and their posts. 

Tools used: Ruby on Rails, PostgreSQL
