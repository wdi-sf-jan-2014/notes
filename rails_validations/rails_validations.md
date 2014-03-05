#Validations

- Validations are used to ensure that only valid data is saved into your database.
- Validations are most often found at the model-level.
- Most prevalent validations are model-level validations. You can also find controller-level & client-side validations.

###Advantages to Having Validations

- they are database agnostic
- cannot be bypassed by end users
- convenient to test & maintain
- Rails provides built-in helpers for it

###When do Validations Happen?

Validations are typically run before the INSERT or UPDATE commands are sent to the database.

###Methods that trigger validations & will save the object to the database only if the object is valid:

- create
- create!
- save
- save!
- update
- update!

*The bang versions (e.g. save!) raise an exception if the record is invalid. The non-bang versions don't, save and update return false, create just returns the object.


###Validation Helpers

- Active Record offers many pre-defined validation helpers that you can use directly inside your class definitions. These helpers provide common validation rules. 
- Common helpers:
  - length
  - format
  - numericality
  - presence
  - uniqueness

###Exercise
Since your User model in the Ritly app is where a lot of the authentication is happening, let's add validations to it.

  1) validate that a name exists
  
  2) validate that the length of the name has a maximum of 50 characters
  
  3) validate that an email exists
  
  4) validate that an email is case insensitive
  
  5) validate that a password is present
  
  6) validate that a password has a minimum of 6 characters
  
  7) validate that a password_confirmation exists