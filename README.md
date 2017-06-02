# Two Factor Authentication using Rails
The application implements a two-factor-authentication, normally the one-time-password is sent through SMS, but for convenience, it will send the one-time-password through Email.

LIVE DEMO: [https://rails-2fa.herokuapp.com/](https://rails-2fa.herokuapp.com/)

## Usage

The application is set up for production as well as development. Please see [link](https://rails-2fa.herokuapp.com/) for production demo above.

After getting the code, change directory and then execute:

    $ bundle

In order to create database and schema, run:

    $ rake db:create db:migrate
    
And to run the rails server by:

    $ rails s
    
Then your application is serving at `localhost:3000`

## Details

* The application using [postgresql](https://www.postgresql.org/) database for production, and [sqlite](https://www.sqlite.org/) for development.
* The password for account and 2FA code are encrypted by [bcrypt](https://github.com/codahale/bcrypt-ruby), means if the 2FA is 123456, then we can never get 123456 from database.
* After verified successfully, the code cannot be used anymore. (one-time-password)
* A user cannot attemps 2FA code before it's been sent: means if a user has no emails, he can never login.
* 2FA code expired in 2 minutes: means if user are not entering the code (get from email) in 2 minutes, an error `"Two Factor code has been expired, please login again"` will be shown
* 2FA code attemps can't be shorter than 10 seconds: means if user attemps 2FA code less then 10 seconds (interval of two operations), an error `"Two Factor code attemps too soon"`.
* 2FA code cannot be attepmted more than 3 times: means if user attemps 2FA code more than 3 times, an error `"Account locked due to too many failed login attempts"`. (actually it's not locked, just cannot attempt more, but can send a new code)

