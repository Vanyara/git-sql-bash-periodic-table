PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#CHECK FOR THE PASSED PARAMS
if [[ $1 ]]
then

ATOM=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number=$1")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")

if [[ -z $ATOM && -z $SYMBOL && -z $NAME ]]
then

echo "I could not find that element in the database."
else
#IF PARAM IS A NUMBER
if [[ $1 =~ ^[0-9]+$ ]]
then
ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$1")
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
echo "The element with atomic number $1 is $ELEMENT ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $ELEMENT has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
elif [[ $1 =~ ^[A-Z]$ || $1 =~ ^[A-Z][a-z]$ ]]
#IF PARAM IS A SYMBOL
then
ATOMIC=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC")
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC")
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC")
MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC")
BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC")
echo "The element with atomic number $ATOMIC is $ELEMENT ($1). It's a $TYPE, with a mass of $MASS amu. $ELEMENT has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
elif [[ $1 =~ ^[A-Z][a-z][a-z]+$ ]]
then
ATOMIC=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC")
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC")
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC")
MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC")
BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC")
echo "The element with atomic number $ATOMIC is $1 ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $1 has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
fi
fi
else
echo "Please provide an element as an argument."
fi