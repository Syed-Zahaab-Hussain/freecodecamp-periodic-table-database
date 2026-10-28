#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -X -t --no-align -c"
if [[ $# -eq 0 ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi
ELEMENT_SQL=${1//\'/\'\'}
if [[ $1 =~ ^[0-9]+$ ]]; then
  CONDITION="e.atomic_number::text = '$ELEMENT_SQL'"
else
  CONDITION="e.symbol = '$ELEMENT_SQL' OR e.name = '$ELEMENT_SQL'"
fi
ELEMENT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p USING(atomic_number) JOIN types t USING(type_id) WHERE $CONDITION")
if [[ -z $ELEMENT ]]; then
  echo "I could not find that element in the database."
  exit 0
fi
IFS='|' read -r NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$ELEMENT"
echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
