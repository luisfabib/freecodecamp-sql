#!/bin/bash
# Salon Appointment Scheduler

PSQL="psql --username=freecodecamp --dbname=salon --no-align -t -c"

# list all services offered in the salon 
SERVICE_LIST(){
  if [[ $1 ]]
  then
    echo -e $1
  fi
  echo "$SERVICES" | while read SERVICE
  do 
      echo "$SERVICE" | sed 's/|/) /'
  done
}

echo $($PSQL "SELECT * from services WHERE service_id=0;")

echo -e "\n~~~~~ FREECODECAMP SALON ~~~~~\n"
echo -e "\nWelcome to the freeCodeCamp Salon, how can we help you?"

# get services of the salon
SERVICES=$($PSQL "SELECT * FROM services")
# list them
SERVICE_LIST "These are our provided services:"

# ask client to select a valid service
NUMBER_OF_SERVICES=$($PSQL "SELECT COUNT(*) FROM services")
SERVICE_ID_SELECTED=0
while [[ -z $($PSQL "SELECT * from services WHERE service_id=$SERVICE_ID_SELECTED;") ]]
do 
  echo -e "\nPlease select one of our services:"
  read SERVICE_ID_SELECTED
  if [[ -z $($PSQL "SELECT * from services WHERE service_id=$SERVICE_ID_SELECTED;") ]]
  then
    SERVICE_LIST "\nERROR: Please select one of our provided services:"
  fi
done
SERVICE=$($PSQL "SELECT name from services WHERE service_id=$SERVICE_ID_SELECTED;")

# get the customer's phone number
echo -e "\nWhat is your phone number?"
read CUSTOMER_PHONE
# get the customer's ID
CUSTOMER_ID=$($PSQL "SELECT customer_id from customers WHERE phone='$CUSTOMER_PHONE';")
# if the customer is not registred
if [[ -z $CUSTOMER_ID ]] 
then
  # register the user
  echo -e "\nYou are a new customer! What is your name?"
  read CUSTOMER_NAME
  CUSTOMER_REGISTRATION=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  CUSTOMER_ID=$($PSQL "SELECT customer_id from customers WHERE phone='$CUSTOMER_PHONE';")
else
  CUSTOMER_NAME=$($PSQL "SELECT name from customers WHERE customer_id='$CUSTOMER_ID';")
fi
# get the requested appointment time
echo -e "At what time would you like to book your appointment?"
read SERVICE_TIME

# register the appointment 
APPOINTMENT_REGISTRATION=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")

# notify the customer 
echo -e "\nI have put you down for a $(echo $SERVICE | sed -e 's/\(.*\)/\L\1/') at $SERVICE_TIME, $CUSTOMER_NAME."
