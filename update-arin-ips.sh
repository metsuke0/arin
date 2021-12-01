#!/bin/sh

FILE=/tmp/ipv4-address-space.csv

rm ${FILE}

/usr/bin/fetch -o /tmp/ipv4-address-space.csv https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.csv

if [ ! -f ${FILE} ]; then
  echo "${FILE} does not exist"
  exit
fi

rm /usr/local/www/arin/index.txt

while read LINE; do
  LINE=$(echo ${LINE} | sed 's/\".*\"//g')

  if [ $(echo ${LINE} | cut -d ',' -f 4) ]; then
    if [ $(echo ${LINE} | cut -d ',' -f4) = 'whois.arin.net' ]; then
      PREFIX=$(echo "${LINE}" | cut -d '/' -f1 | sed 's/^0//' | sed 's/^0//')
      IP="${PREFIX}.0.0.0"

      if [ ${IP} = "11.0.0.0" ]; then
        continue
      elif [ ${IP} = "22.0.0.0" ]; then
        continue
      elif [ ${IP} = "26.0.0.0" ]; then
        continue
      elif [ ${IP} = "28.0.0.0" ]; then
        continue
      elif [ ${IP} = "29.0.0.0" ]; then
        continue
      elif [ ${IP} = "30.0.0.0" ]; then
        continue
      elif [ ${IP} = "55.0.0.0" ]; then
        continue
      elif [ ${IP} = "139.0.0.0" ]; then
        continue
      elif [ ${IP} = "214.0.0.0" ]; then
        continue
      elif [ ${IP} = "215.0.0.0" ]; then
        continue
      fi

      SUBNET="${IP}/8"
      echo ${SUBNET} >> /usr/local/www/arin/index.txt
    fi
  fi
done < ${FILE}

rm ${FILE}
