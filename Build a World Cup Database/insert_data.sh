#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Clean database
echo $($PSQL "TRUNCATE TABLE games, teams;")

# Fill the database
cat games.csv | while IFS="," read YEAR ROUND WINNER LOSER WINNER_GOALS LOSER_GOALS
do 
  # Ignore header
  if [[ $YEAR != year ]]
  then
    # Get the winner team's ID 
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # If not found 
    if [[ -z $WINNER_ID ]]
    then
      # Add winner's team to the database 
      WINNER_ID_EXIT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      # Get the new ID     
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi     

    # Get the loser team's ID 
    LOSER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$LOSER'")
    # If not found 
    if [[ -z $LOSER_ID ]]
    then
      # Add winner's team to the database 
      LOSER_ID_EXIT=$($PSQL "INSERT INTO teams(name) VALUES('$LOSER')")
      # Get the new ID     
      LOSER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$LOSER'")
    fi  

    # Add game to the database 
    GAME_EXIT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$LOSER_ID,$WINNER_GOALS,$LOSER_GOALS)")

  fi
done
