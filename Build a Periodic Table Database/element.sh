#!/bin/bash
# Provide information on an element in the periodic table

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align --csv -c"

# check if an argument has been passed
if [[ $1 ]]
then 

  if [[ $1 =~ ^[0-9]+$ ]]; then
    # if the argument is a number  
    INFORMATION_PROVIDED="atomic_number"
  elif test $(echo $1 | wc -m) -le 3; then 
    # if the argument is a one or two charcters string
    INFORMATION_PROVIDED="symbol"  
  else
    # if the argument is a string with more than two characters
    INFORMATION_PROVIDED="name"
  fi

  # get information on the element from the database
  DATABASE_QUERY=$($PSQL "\
    SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type  FROM elements \
    FULL JOIN properties USING(atomic_number) \
    FULL JOIN types USING(type_id) 
    WHERE $INFORMATION_PROVIDED='$1'
    ;")

  if [[ -z $DATABASE_QUERY ]]; then
    # if the element is no in the database
    echo "I could not find that element in the database."
  else
    # if the element is found
    IFS=',' read ATOMIC_NUMBER ELEMENT_SYMBOL ELEMENT_NAME ATOMIC_MASS MELTING_POINT BOILING_POIINT ELEMENT_TYPE <<< "$DATABASE_QUERY"

    # return a summary of the requested element
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POIINT celsius."
  fi
else 
  # if no argument was passed
  echo "Please provide an element as an argument."
fi
