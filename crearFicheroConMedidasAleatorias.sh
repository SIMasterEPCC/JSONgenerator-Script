numDispositivos=1
anio="2017"
mes="01"
numDias=31
numHoras=24

dispositivo=1
while [ $dispositivo -le $numDispositivos ]
do
	echo "[" > filetemp.json

	dia=1
	while [ $dia -le $numDias ]
	do
		hora=0
		while [ $hora -lt $numHoras ]
		do
			temperatura=`echo $((RANDOM%50-10))`
			humedad=`echo $((20+RANDOM%60))`
			if [ $dia -lt 10 ] && [ $hora -lt 10 ]
			then
				fecha="$anio/$mes/0$dia 0$hora:00:00"
			elif [ $dia -lt 10 ]
			then
				fecha="$anio/$mes/0$dia $hora:00:00"
			elif [ $hora -lt 10 ]
			then
				fecha="$anio/$mes/$dia 0$hora:00:00"
			else
				fecha="$anio/$mes/$dia $hora:00:00"
			fi

			hora=`expr $hora + 1`

			if [ $hora != $numHoras ] || [ $dia != $numDias ]
			then
				echo "	{\"Dispositivo\": $dispositivo,	\"Temperatura\": $temperatura,	\"Humedad\": $humedad,	\"Fecha\": \"$fecha\"}," >> filetemp.json
			else
				echo "	{\"Dispositivo\": $dispositivo,	\"Temperatura\": $temperatura,	\"Humedad\": $humedad,	\"Fecha\": \"$fecha\"}" >> filetemp.json
			fi
		done
	
		dia=`expr $dia + 1`
	done

	echo "]" >> filetemp.json

	mv filetemp.json "medidasDispositivo$dispositivo.json"
	
	dispositivo=`expr $dispositivo + 1`
done
