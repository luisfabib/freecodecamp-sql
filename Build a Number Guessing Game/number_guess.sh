#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align --csv -c"

# login prompt
echo "Enter your username:"
read USERNAME 

# get user's information
USER_INFO=$($PSQL "SELECT username,games_played,best_game FROM users WHERE username='$USERNAME';")
echo $USER_INFO
# check if user exists in the database
if [[ -z $USER_INFO ]]
then
  # if it does not exist, register it
  USERNAME_REGISTRATION=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  # if it does exists, retrieve its information
  IFS=',' read USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# game loop
SECRET_NUMBER=$(($RANDOM % 1000))
echo $SECRET_NUMBER
echo "Guess the secret number between 1 and 1000:"
read USER_GUESS
TRIES=1
while [[ $USER_GUESS != $SECRET_NUMBER ]]
do
  if [[ ! $USER_GUESS =~ ^-?[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    read USER_GUESS
    ((TRIES=$TRIES+1))
  fi

  if [[ $USER_GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
  read USER_GUESS
  ((TRIES=$TRIES+1))
done

# update the database 
GAMES_PLAYED_UPDATE=$($PSQL "UPDATE users SET games_played=games_played+1 WHERE username='$USERNAME'")

if [[ -z $BEST_GAME || $TRIES < $BEST_GAME ]]
then
  BEST_GAME_UPDATE=$($PSQL "UPDATE users SET best_game=$TRIES WHERE username='$USERNAME'")
fi

# announce the winner
echo "You guessed it in $TRIES tries. The secret number was $SECRET_NUMBER. Nice job!"
