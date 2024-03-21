#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate a random nuber
SECRET_NUMBER=$((1 + RANDOM % 1000))
echo $SECRET_NUMBER

#enter username
echo "Enter your username:"
read USERNAME

#check if username has been used
USERNAME_RESULT=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

if [[ -z $USERNAME_RESULT ]]
then
  #print out first time
  echo "Welcome, $USERNAME! It looks like this is your first time here."

  #insert username and games_played as 0
  INSERT_USER=$($PSQL "INSERT INTO users (username, games_played) VALUES ('$USERNAME', 0)")
else
  #get user info
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
  
  #print out welcome back
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

#generate first instance of guesses as 0
NUMBER_OF_GUESSES=0

#game function
GAME() {
  #increment guesses by one
  NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))

  #check if game function has an argument
  if [[ -z $1 ]]
  then
    #print guess between 1 and 1000
    echo "Guess the secret number between 1 and 1000:"

    #read input
    read GUESS
  else
    #print argument
    echo $1

    #read input
    read GUESS
  fi
  
  #check if not an integer and if so send back to game function
  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES-1))
    GAME "That is not an integer, guess again:"
  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    #check if guess is lower and send back to game function
    GAME "It's higher than that, guess again:"
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    #check if guess is higher and send back to game function
    GAME "It's lower than that, guess again:"
  elif [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    #congratulate on correct guess
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

    #increase games_played by one
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
    GAMES_PLAYED=$((GAMES_PLAYED+1))
    UPDATE_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED WHERE username = '$USERNAME'")

    #check if best_game is empty
    BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
    if [[ -z $BEST_GAME ]]
    then
      #insert new best_game
      UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
    else
      #check if best_game is lower than the one in the database. If so update to new value
      if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
      then
        UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
      fi

    fi

  fi

};

#start game function
GAME
