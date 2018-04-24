set -x

for i in 1 2 3 4 5
do
  username="devop0$i"
  userdel $username -r
done
