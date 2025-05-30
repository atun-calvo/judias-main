#!/bin/bash
#set -x
##Variables##
file1="$(mktemp)"
file2="$(mktemp)"
futbol="$(mktemp)"
canales_futbol="$(mktemp)"
file3="$(mktemp)"
basket="$(mktemp)"
file4="$(mktemp)"
formula="$(mktemp)"
file5="$(mktemp)"
motos="$(mktemp)"
file6="$(mktemp)"
tenis="$(mktemp)"
file7="$(mktemp)"
file8="$(mktemp)"
mma1="$(mktemp)"
mma2="$(mktemp)"
boxeo1="$(mktemp)"
boxeo2="$(mktemp)"
ciclismo1="$(mktemp)"
ciclismo2="$(mktemp)"
padel1="$(mktemp)"
padel2="$(mktemp)"
sala1="$(mktemp)"
sala2="$(mktemp)"
filecanales="$(mktemp)"
date=$(date +"%d-%m-%Y")
hora=[0-9]*:[0-9]*

#############################################################Cuerpo del script##################################################################################

cd $(dirname $0)

#Borramos anteriores archivos generados
rm -f date*.txt
rm -f eventos_sin_enlace.txt

## Descarga del fichero de enlaces y formateado de texto ##
#curl -m 20 -s --socks5-hostname localhost:9050 --retry 5 --retry-delay 5 https://elcano.top > $file1

#Obtiene los ids y genera un archivo llamado ace_ids.txt
#python ./getElcanoWeb.py #se ejecuta en el main.yml porque aqui da problemas

# Organizador de enlaces
canales_mliga="$(mktemp)"; grep -A1 -i -e "M\. *LaLiga *1080" -e "M\. *LaLiga *720" -e "M\..*Laliga *HD" ace_ids.txt > $canales_mliga
canales_mliga2="$(mktemp)"; grep -A1 -i -e 'M\. *LaLiga *2' ace_ids.txt > $canales_mliga2
canales_movistar="$(mktemp)"; grep -A1 -i 'm\.plus' ace_ids.txt > $canales_movistar
canales_daznliga="$(mktemp)"; grep -A1 -i -e "dazn *laliga *1080" -e "dazn *laliga *720" ace_ids.txt > $canales_daznliga
canales_daznliga2="$(mktemp)"; grep -A1 -i -e 'dazn *laliga *2' ace_ids.txt > $canales_daznliga2
canales_liga_segunda="$(mktemp)"; grep -A1 -i -e 'smartbank 1080' -e 'smartbank 720' ace_ids.txt > $canales_liga_segunda
canales_liga_segunda2="$(mktemp)"; grep -A1 -i 'smartbank 2' ace_ids.txt > $canales_liga_segunda2
canales_liga_segunda3="$(mktemp)"; grep -A1 -i 'smartbank 3' ace_ids.txt > $canales_liga_segunda3
canales_dazn="$(mktemp)"; grep -A1 -i -e 'dazn *1' ace_ids.txt > $canales_dazn
canales_dazn2="$(mktemp)"; grep -A1 -i -e 'DAZN *2' ace_ids.txt > $canales_dazn2
canales_dazn3="$(mktemp)"; grep -A1 -i -e 'DAZN *3' ace_ids.txt > $canales_dazn3
canales_dazn4="$(mktemp)"; grep -A1 -i -e 'DAZN *4' ace_ids.txt > $canales_dazn4
canales_daznF1="$(mktemp)" ; grep -A1 -i -e 'DAZN *F1' ace_ids.txt > $canales_daznF1
canales_tvbar="$(mktemp)"; grep -A1 -i -e 'laliga *tv' ace_ids.txt > $canales_tvbar
canales_deportes="$(mktemp)" ; grep -A1 -i -e "m\. *deportes *1080" -e "m\. *deportes *720" ace_ids.txt > $canales_deportes
canales_deportes2="$(mktemp)" ; grep -A1 -i -e 'm\. *deportes *2' ace_ids.txt > $canales_deportes2
canales_deportes3="$(mktemp)" ; grep -A1 -i -e 'm\. *deportes *3' ace_ids.txt > $canales_deportes3
canales_deportes4="$(mktemp)" ; grep -A1 -i -e 'm\. *deportes *4' ace_ids.txt > $canales_deportes4
canales_deportes5="$(mktemp)" ; grep -A1 -i -e 'm\. *deportes *5' ace_ids.txt > $canales_deportes5
canales_deportes6="$(mktemp)" ; grep -A1 -i -e 'm\. *deportes *6' ace_ids.txt > $canales_deportes6
canales_deportes7="$(mktemp)" ; grep -A1 -i -e 'm\. *deportes *7' ace_ids.txt > $canales_deportes7
canales_campeones="$(mktemp)" ; grep -A1 -i -e "campeones *1080" -e "campeones *720" ace_ids.txt > $canales_campeones
canales_campeones2="$(mktemp)" ; grep -A1 -i -e "campeones *2" ace_ids.txt > $canales_campeones2
canales_campeones3="$(mktemp)" ; grep -A1 -i -e "campeones *3" ace_ids.txt > $canales_campeones3
canales_campeones4="$(mktemp)" ; grep -A1 -i -e "campeones *4" ace_ids.txt > $canales_campeones4
canales_campeones5="$(mktemp)" ; grep -A1 -i -e "campeones *5" ace_ids.txt > $canales_campeones5
canales_campeones6="$(mktemp)" ; grep -A1 -i -e "campeones *6" ace_ids.txt > $canales_campeones6
canales_campeones7="$(mktemp)" ; grep -A1 -i -e "campeones *7" ace_ids.txt > $canales_campeones7
canales_supercopa="$(mktemp)" ; grep -A1 -e 'SuperCopa' ace_ids.txt > $canales_supercopa
canales_vamos="$(mktemp)" ; grep -A1 -e 'Vamos' ace_ids.txt > $canales_vamos
canales_eurosport1="$(mktemp)" ; grep -A1 -i -e 'eurosport *1' ace_ids.txt > $canales_eurosport1
canales_eurosport2="$(mktemp)" ; grep -A1 -i -e 'eurosport *2' ace_ids.txt > $canales_eurosport2


##Descarga del fichero de horarios y formateado##
curl -s --max-time 5 https://www.futbolenlatv.es/competicion/la-liga | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol > $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/segunda-division-espana | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/copa-del-rey | pandoc -f html > $futbol 
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/supercopa-espana | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/liga-campeones | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/europa-league | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/supercopa-europa | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/competicion/premier-league | pandoc -f html > $futbol
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $futbol > $canales_futbol; cat $canales_futbol | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $futbol
cat $futbol >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/baloncesto | pandoc -f html > $file3 
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $file3 > $basket; cat $basket | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $file3
cat $file3 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/automovilismo | pandoc -f html > $file4
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $file4 > $formula; cat $formula | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $file4
cat $file4 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/motociclismo | pandoc -f html > $file5 
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $file5 > $motos; cat $motos | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $file5
cat $file5 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/tenis | pandoc -f html > $file6
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $file6 > $tenis; cat $tenis | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $file6
cat $file6 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/mma | pandoc -f html > $mma1
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $mma1 > $mma2; cat $mma2 | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $mma1
cat $mma1 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/boxeo | pandoc -f html > $boxeo1
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $boxeo1 > $boxeo2; cat $boxeo2 | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $boxeo1
cat $boxeo1 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/ciclismo | pandoc -f html > $ciclismo1
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $ciclismo1 > $ciclismo2; cat $ciclismo2 | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $ciclismo1
cat $ciclismo1 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/padel | pandoc -f html > $padel1
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $padel1 > $padel2; cat $padel2 | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $padel1
cat $padel1 >> $filecanales

curl -s --max-time 5 https://www.futbolenlatv.es/deporte/futbol-sala | pandoc -f html > $sala1
sed -n '/Partidos de hoy/,/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]/p' $sala1 > $sala2; cat $sala2 | head -n -1 | tail -n +2 | sed 's/<[^>]*>//g' > $sala1
cat $sala1 >> $filecanales


# Elimina las lineas vacías, Quita los  guiones + espacio y las que empiezan por tabulador. Junta todas las lineas.
sed -i '/^ *$/d' $filecanales ; sed -i 's/^- //g' $filecanales; sed -i 's/^[ \t]*//' $filecanales

# Separamos los eventos y el patrón es que cada evento comienza siempre por la hora (07:00 por ejemplo).
# Entonces, si encuentra una linea que comience con una hora, le mete un @ delante para luego separar los eventos

while read line
do
	if [[ $line == $hora ]]
	then
		echo "@"$line";" >> $file7
	else
		echo $line";" >> $file7
	fi
done < $filecanales

# Quitamos los saltos de linea con tr, esto hará que absolutamente todo se concentre en 1 linea

tr -d '\n' < $file7 > $file8
sed -i 's/@/\n/g' $file8 # Volvemos a separar la linea por cada @ que encuentre y mete un salto de linea
sed -i '/LEB/d' $file8 # Quitamos los partidos de baloncesto de 2ª
sed -i '/Femenina/d' $file8 # Quitamos los partidos de baloncesto femeninos que no le importan a nadie
sort $file8 > date_$date.txt # Ordena automaticamente de menor a mayor por la hora


# Variables para FOR
en=ace_ids.txt
can=date_$date.txt
sed -i '/^ *$/d' $can # Eliminamos de nuevo lineas en blanco porque a veces por alguna razón todavía existe o se genera alguna magicamente

#Generar plantilla html INICIO
echo "<!DOCTYPE html>" > index.html
echo "<html lang="es">" >> index.html
echo "<center>" >> index.html
echo "<head>" >> index.html
echo "<meta charset="utf-8">" >> index.html
echo "<title>HTML</title>" >> index.html
echo "<meta name="viewport" content="width=device-width, initial-scale=1.0">" >> index.html
echo "<link rel="stylesheet" href="estilo.css">" >> index.html
echo "</head>" >> index.html
echo "<body>" >> index.html
echo "<div class="container">" >> index.html
echo "<h1 style="font-family:sans-serif">EVENTOS DEL ${date}</h1>" >> index.html
echo "<table class="styled-table">" >> index.html
echo "<thead>" >> index.html
echo "<tr>" >> index.html
echo "<td>Hora del evento</td>" >> index.html
echo "<td>Evento</th>" >> index.html
echo "<td colspan=2>Equipos/Deportistas</td>" >> index.html
echo "<td colspan=4>Enlaces Acestream</td>" >> index.html
echo "</tr>" >> index.html
echo "</thead>" >> index.html

IFS=$'\n'
for LINEA in $(cat $can)
do
        canales="$(mktemp)"
	canal_sin_enlace=true

	# Creo que es mas eficiente reutilizar el archivo temporal que echo $LINEA | grep en los IF
	echo $LINEA > $file1


        if [[ $(grep -i -e "M+ *LaLiga" -e "M+ *LaLiga *UHD" $file1) ]]
        then
               cat $canales_mliga >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "M+.*Liga *2" $file1) ]]
        then
               cat $canales_mliga2 >> $canales
	       canal_sin_enlace=false
	fi

 	if [[ $(grep -i "movistar plus+" $file1) ]]
        then
               cat $canales_movistar >> $canales
               canal_sin_enlace=false
        fi

	if [[ $(grep -i 'tv hypermotion [[:punct:]]' $file1) ]]
        then
               cat $canales_liga_segunda >> $canales
               canal_sin_enlace=false
        fi
	
	if [[ $(grep -i 'tv hypermotion 2' $file1) ]]
        then
               cat $canales_liga_segunda2 >> $canales
               canal_sin_enlace=false
        fi

	if [[ $(grep -i 'tv hypermotion 3' $file1) ]]
        then
               cat $canales_liga_segunda3 >> $canales
               canal_sin_enlace=false
        fi


 	if [[ $(grep -i -e "dazn *1 *[[:punct:]]" -e "dazn *1 *[[:punct:]]" $file1) ]]
        then
               cat $canales_dazn >> $canales
	       canal_sin_enlace=false
	fi
 	
        if [[ $(grep -i "DAZN *2" $file1) ]]
        then
               cat $canales_dazn2 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "dazn *3 *[[:punct:]]" $file1) ]]
        then
               cat $canales_dazn3 >> $canales
	       canal_sin_enlace=false
	fi
	
	if [[ $(grep -i "dazn *4 *[[:punct:]]" $file1) ]]
        then
               cat $canales_dazn4 >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "dazn.*liga *[[:punct:]]" $file1) ]]
        then
               cat $canales_daznliga >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "dazn *laliga *2" $file1) ]]
        then
               cat $canales_daznliga2 >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "DAZN *F1" $file1) ]]
        then
               cat $canales_daznF1 >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "Tv *Bar *" $file1) ]]
        then
               cat $canales_tvbar >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i -e "m+ *deportes *[[:punct:]]" -e "Movistar *+" $file1) ]]
        then
               cat $canales_deportes >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "m+ *deportes *2" $file1) ]]
        then
               cat $canales_deportes2 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+ *deportes *3" $file1) ]]
        then
               cat $canales_deportes3 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+ *deportes *4" $file1) ]]
        then
               cat $canales_deportes4 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+ *deportes *5" $file1) ]]
        then
               cat $canales_deportes5 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+ *deportes *6" $file1) ]]
        then
               cat $canales_deportes6 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+ *deportes *7" $file1) ]]
        then
               cat $canales_deportes7 >> $canales
	       canal_sin_enlace=false
	fi
	
	if [[ $(grep -i "liga.*campeones *[[:punct:]]" $file1) ]]
        then
               cat $canales_campeones >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "m+.*liga.*campeones *2" $file1) ]]
        then
               cat $canales_campeones2 >> $canales
	       canal_sin_enlace=false
	fi

      	if [[ $(grep -i "m+.*liga.*campeones *3" $file1) ]]
	then
		cat $canales_campeones3 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+.*liga.*campeones *4" $file1) ]]
        then
		cat $canales_campeones4 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+.*liga.*campeones *5" $file1) ]]
	then
		cat $canales_campeones5 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "m+.*liga.*campeones *6" $file1) ]]
	then
		cat $canales_campeones6 >> $canales
	       canal_sin_enlace=false
	fi
	
	if [[ $(grep -i "m+.*liga.*campeones *7" $file1) ]]
	then
		cat $canales_campeones7 >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "supercopa.*espa[nñ]a" $file1) ]]
        then
               cat $canales_supercopa >> $canales
	       canal_sin_enlace=false
	fi

        if [[ $(grep -i "m+ *[#]vamos" $file1) ]]
        then
               cat $canales_vamos >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "Eurosport *1" $file1) ]]
        then
               cat $canales_eurosport1 >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "Eurosport *2" $file1) ]]
        then
               cat $canales_eurosport2 >> $canales
	       canal_sin_enlace=false
	fi
	
	if [[ $(grep -i "teledeporte" $file1) ]]
        then
               echo "Teledeporte RTVE" >> $canales
	       echo "https://tdtchannels.com/television/Teledeporte" >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $(grep -i "gol play" $file1) ]]
	then
		echo "Gol Play" >> $canales
		echo "https://www.goltelevision.com/en-directo" >> $canales
	       canal_sin_enlace=false
	fi

	if [[ $canal_sin_enlace == true ]]
	then
		echo $LINEA >> eventos_sin_enlace.txt
	
	else	
		
		# El evento, al no estar vacío de enlaces acestream, queremos que salga en la web
		cat $canales > canal_html.txt
		source generador_html.sh
	fi

        rm -f $canales # Eliminamos el archivo en cada bucle para que no se agregue lo anterior


done


# Generar plantilla html FINAL y copiarla al directorio de apache (opcional)
echo "</table>" >> index.html
echo "</div>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
#cp -f index.html /var/www/html # Pon la ruta que quieras si quieres copiar o mover el archivo html y elimina el primer # de la linea

