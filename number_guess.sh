#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"

read USER_INPUT
  
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USER_INPUT'")

  if [[ -z $USER_ID ]]
  then
    echo -e "\nWelcome, $USER_INPUT! It looks like this is your first time here."

    NEW_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES ('$USER_INPUT', 0, 0)")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USER_INPUT'")
  else
    USERNAME=$($PSQL "SELECT username FROM users WHERE user_id = '$USER_ID'")
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE user_id = '$USER_ID'")
    BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE user_id = '$USER_ID'")


    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi

RANDOM_NUMBER=$(( 1 + RANDOM % 10 ))
TRIES_NUMBER=0
BEST_GAME_TRIES=99999

while true; do
echo -e "\nGuess the secret number between 1 and 1000:"
read GUESS

if [[ $GUESS =~ ^[0-9]+$ ]]
then
  (( TRIES_NUMBER++ ))
  if [[ $GUESS -gt $RANDOM_NUMBER ]]
  then

  echo -e "\nIt's lower than that, guess again:"

  elif [[ $GUESS -lt $RANDOM_NUMBER ]]
  then

  echo -e "\nIt's higher than that, guess again:"

  else

  echo -e "\nYou guessed it in $TRIES_NUMBER tries. The secret number was $RANDOM_NUMBER. Nice job!"
  (( GAMES_PLAYED++ ))

  if [[ -z $BEST_GAME ]]
  then

    BEST_GAME_TRIES=$TRIES_NUMBER
    UPDATING_BEST_GAME=$($PSQL "UPDATE users SET best_game = $BEST_GAME_TRIES WHERE user_id = '$USER_ID'")
 
  else
    if [[ $TRIES_NUMBER -lt $BEST_GAME ]]
    then
    UPDATING_BEST_GAME=$($PSQL "UPDATE users SET best_game = $TRIES_NUMBER WHERE user_id = '$USER_ID'")
   
    fi
  fi
  UPDATING_USER_TRIES=$($PSQL "INSERT INTO tries (user_id, number_of_guesses) VALUES('$USER_ID', '$TRIES_NUMBER')")
  UPDATING_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED WHERE user_id = '$USER_ID'")
 
  break
 
  fi
else

echo -e "\nThat is not an integer, guess again:"

fi
done
