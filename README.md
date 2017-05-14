https://afternoon-badlands-18041.herokuapp.com/

[![Build Status](https://travis-ci.org/FummiTaksi/ttmanagement.png)](https://travis-ci.org/FummiTaksi/ttmanagement)



[![Coverage Status](https://coveralls.io/repos/github/FummiTaksi/ttmanagement/badge.svg?branch=master)](https://coveralls.io/github/FummiTaksi/ttmanagement?branch=master)

DATAMALLI: https://yuml.me/dad7d55b
Features:

1) User can sign up to system
  
  Validations:
  
  -User has to have firstname and lastname
  
  -Password Cant be blank
  
  
2) Unique username is generated from user's firstname and lastname
  
  -If someone has same name, numbers added to end of username
  
3) User can sign in  to system with own account
  
4) User can edit own account

5) User can delete own account

6) Admin can give another player clubowner status

7) Admin can remove clubowner status from player

6) Clubowner can create club

 Validations: 
 
 -Club can't be created if clubowner is already in a club
 
 7) Clubowner can add players to own club
 
 Validations:
 
 - Only players, who don't have club can be added
 
 8) Player can leave from club
 
 Validations:
 
 - Clubowner can destroy club only if he is the only player there
 
 9) Admin can add matches between other players
 
   Validations:
   
   -Match has to be between different players who belong in a club
   
   -Match's score has to be valid
 
 10) Admin can toggle another player's admin status
 
 11) Admin can toggle another player's clubowner status
 
 
  
