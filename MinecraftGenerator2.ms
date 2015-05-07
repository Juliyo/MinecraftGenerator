dotnet.loadAssembly (sysInfo.currentdir +"\PerlinNoiseV2.dll")
/*VARIABLES*/
terreno=#(#())
tama = 10
tamaTerrenoX = 0
tamaTerrenoY = 0
tronco = #()
hojas = #(#())
	
matGrass = multimaterial numsubs:6
matTronco = multimaterial numsubs:6
matHojas = multimaterial numsubs:6
	
texturaLadosGrass = sysInfo.currentdir + "\\texturas\lado.jpg"
texturaTopGrass = sysInfo.currentdir + "\\texturas\arriba.jpg"
	
texturaHojas = sysInfo.currentdir + "\\texturas\arbolHojas.png"
texturaHojasAlpha = sysInfo.currentdir + "\\texturas\arbolHojasAlpha.jpg"
	
texturaLadoTronco = sysInfo.currentdir + "\\texturas\maderaLado.jpg"

bitmapHojas = bitmaptexture filename: texturaHojas
bitmapHojasAlpha = bitmaptexture filename: texturaHojasAlpha
bitmapLadoTronco = bitmaptexture filename: texturaLadoTronco
bitmapLadosGrass = bitmaptexture filename: texturaLadosGrass
bitmapTopGrass = bitmaptexture filename: texturaTopGrass
	
for i=1 to 6 do(
		if i==1 then (
			matGrass[i].diffusemap = bitmapTopGrass
			matGrass[i].showInViewport = on
				
			matHojas[i].diffusemap = bitmapHojas
			matHojas[i].opacitymap = bitmapHojasAlpha
			matHojas[i].showInViewport = on
			
			matTronco[i].diffusemap = bitmapLadoTronco
			matTronco[i].showInViewport = on
		)else(
			matHojas[i].diffusemap = bitmapHojas
			matHojas[i].opacitymap = bitmapHojasAlpha
			matHojas[i].showInViewport = on
			
			matTronco[i].diffusemap = bitmapLadoTronco
			matTronco[i].showInViewport = on
			
			matGrass[i].diffusemap = bitmapLadosGrass
			matGrass[i].showInViewport = on
		)
	)
	
try (closeRolloutFloater RolloutNuevoTemplate) catch()
fn rotaCuboAleatorio elemento i j = (
		rnd = random 0 3
		sumar = 0
		rotacion = eulerangles 0 0 0
		if rnd == 0 then (
			rotacion = eulerangles 0 0 90
		)else(
			if rnd == 1 then(
				rotacion = eulerangles 0 0 180
			)else(
				if rnd == 2 then(
					rotacion = eulerangles 0 0 270
					sumar = 1
				)else(
					if rnd == 3 then(
						rotacion = eulerangles 0 0 360
						sumar = 1
					)
			)
		)
		if elemento == "terreno" then(
			if sumar == 1 then(
				--terreno[i][j].pos.z = terreno[i][j].pos.z + tama
			)
			rotate terreno[i][j] rotacion
		)else(
			if elemento == "hojas" then(
				if sumar == 1 then(
				hojas[i][j].pos.z = hojas[i][j].pos.z + tama
			)				
			rotate hojas[i][j] rotacion
			)else(
				
			)
		)
		
	)
)


fn creaArbol posX posY posZ tamaTronco tamaHojas = (
	altura = posZ + tama
	tronco
	hojas
	i=1
	
	-- Se crea el tronco
	for i=1 to tamaTronco do(
		tronco[i] = instance terreno[1][1]
		tronco[i].pos.x = posX
		tronco[i].pos.y = posY
		tronco[i].pos.z = altura
		tronco[i].material = matTronco
		altura = altura + tama
		
	)
	posXhojas = 0
	posXhojas = (posX) +(2*tama)
	posYhojas = (posY) +(2*tama)
	posZhojas = (altura)
	-- Se crean las hojas inferiores
	for w=1 to tamaHojas do(
		if w > 1 then(
			posZhojas = posZHojas + tama
		)
		for i=1 to 5 do(
			if i!=1 then(
				append hojas#()
			)
			for j=1 to 5 do(
				if (i==1 or j==5)  then(
					ale = random 0 2
					if ale == 0 or ale == 2 then(
						hojas[i][j] = instance terreno[1][1]
						hojas[i][j].pos.x = posXhojas
						hojas[i][j].pos.y = posYhojas
						hojas[i][j].pos.z = posZhojas
						hojas[i][j].material = matHojas
						rotaCuboAleatorio "hojas" i j
					)
				)else(
					hojas[i][j] = instance terreno[1][1]
					hojas[i][j].pos.x = posXhojas
					hojas[i][j].pos.y = posYhojas
					hojas[i][j].pos.z = posZhojas
					hojas[i][j].material = matHojas
					rotaCuboAleatorio "hojas" i j
				)
				
				posYhojas = posYhojas - (tama)
			)
			posXhojas = posXhojas - (tama)
			posYhojas = (posY) +(2*tama)
			
		)
		posYhojas = (posY) +(2*tama)
		posXhojas = (posX) +(2*tama)
	)
	-- Se crean las hojas superiores
	posXhojas = (posX) +(tama)
	posYhojas = (posY) +(tama)
	posZhojas = posZhojas + tama
	for w=1 to 2 do(
		if w > 1 then(
			posZhojas = posZHojas + tama
		)
		for i=1 to 3 do(
			for j=1 to 3 do(
				if w>1 then (
					ale = random 0 6
				)else(
					ale = random 0 2
				)
				if ale == 0 or ale == 1 then(
					hojas[i][j] = instance terreno[1][1]
					hojas[i][j].pos.x = posXhojas
					hojas[i][j].pos.y = posYhojas
					hojas[i][j].pos.z = posZhojas
					hojas[i][j].material = matHojas
					rotaCuboAleatorio "hojas" i j
				)
				posYhojas = posYhojas - (tama)
			)
			posXhojas = posXhojas - (tama)
			posYhojas = (posY) +(tama)
		)
		posXhojas = (posX) +(tama)
		posYhojas = (posY) +(tama)
	)
)

fn generaArboles numArboles tamaTronco tamaHojas = (
	contador = 0
	aleatorio = 0
	for i=0 to numArboles do(
		ale1 = random 1 tamaTerrenoX
		ale2 = random 1 tamaTerrenoY
		creaArbol terreno[ale1][ale2].pos.x terreno[ale1][ale2].pos.y terreno[ale1][ale2].pos.z tamaTronco tamaHojas
	)
	
	/*for i = 1 to tamaTerrenoX do(
		for j = 1 to tamaTerrenoY do(
			if contador < (int)numArboles then(
				aleatorio = random 0 10
				if aleatorio == 5 then (
					creaArbol terreno[i][j].pos.x terreno[i][j].pos.y terreno[i][j].pos.z tamaTronco tamaHojas
					contador = contador + 1
				)
			)
		)
	)*/
)

fn crearTerreno X Y tama altura frecuencia=  (
	
	semilla=random 5000 5300
	script = dotNetObject "PerlinNoiseV2.Perlin" (semilla) (frecuencia)
	posX = 0
	posY = 0
	ruido = 0.0
	ruidomax=0.0
	ruidomin=0.0
	for i=1 to X do(
		if i!=1 then(
		  append terreno #()
		)
		for j=1 to Y do(

				 script2 = dotNetObject "PerlinNoiseV2.Perlin" (10*(sqrt 5330)) (5)
				 script3 = dotNetObject "PerlinNoiseV2.Perlin" (5330*5330) (20)
				 --print((12*(script.getNoiseLevelAtPosition i j))+(6*(script2.getNoiseLevelAtPosition i j))+(24*(script3.getNoiseLevelAtPosition i j)))
				 ruido = (12*(script.getNoiseLevelAtPosition i j))+(6*(script2.getNoiseLevelAtPosition i j))+(24*(script3.getNoiseLevelAtPosition i j))
			
				--ruido = 	script.getNoiseLevelAtPosition i j
				if i==1 and j==1 then(
					terreno[i][j]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:tama pos:[posX ,posY,ruido]  mapcoords:on  material:matGrass
				)else(
					terreno[i][j]=instance terreno[1][1]
					terreno[i][j].pos.x=posX
					terreno[i][j].pos.y=posY
					terreno[i][j].pos.z=ruido
					
				)
				rotaCuboAleatorio "terreno" i j
			     posY = posY + tama
		)
		posX = posX + tama
		posY = 0
	)
	--intervalo=1.0/altura
	
		for i=1 to X do(
		for j=1 to Y do(
			if i==1 and j==1 do(
				ruidomin=terreno[i][j].pos.z
				ruidomax=terreno[i][j].pos.z
			)
			if terreno[i][j].pos.z>ruidomax then(
				ruidomax=terreno[i][j].pos.z
			)
			if terreno[i][j].pos.z<ruidomin then(
				ruidomin=terreno[i][j].pos.z
			)
			
			/*for k = 0 to (escalon - 1) do(
				relleno=instance terreno[1][1]
				relleno.pos.x=terreno[i][j].pos.x
				relleno.pos.y=terreno[i][j].pos.y
				relleno.pos.z=tama*k
			)*/
			
		)
	)
	pos= ruidomax - ruidomin
	intervalo=(pos)/altura
	for i=1 to X do(
		for j=1 to Y do(
			/*if i==1 and j==1 do(
				ruidomin=terreno[i][j].pos.z
				ruidomax=terreno[i][j].pos.z
			)
			if terreno[i][j].pos.z>ruidomax then(
				ruidomax=terreno[i][j].pos.z
			)
			if terreno[i][j].pos.z<ruidomin then(
				ruidomin=terreno[i][j].pos.z
			)*/
			escalon=(terreno[i][j].pos.z)/intervalo
			
			terreno[i][j].pos.z=(int)escalon*tama
			relleno=instance terreno[1][1]
			relleno.pos.x=terreno[i][j].pos.x
			relleno.pos.y=terreno[i][j].pos.y
			relleno.pos.z=terreno[i][j].pos.z - tama
		)
	)

)
texturaIconoTerreno = sysInfo.currentdir + "\\iconos\icoTerreno.png"
rollout scriptFinal "Terreno" width:270 height:304
(

	GroupBox GrupoTerreno "Terreno" pos:[18,74] width:229 height:129
	label lbl1 "Dimensión X" pos:[38,96] width:68 height:17
	label lbl2 "Dimensión Y" pos:[36,119] width:65 height:18
	GroupBox grp2 "Bloques" pos:[21,24] width:225 height:41
	button btn6 "Generar terreno" pos:[26,224] width:208 height:29
	spinner spinerTama "Tamaño de los cubos" pos:[49,40] width:169 height:16 type:#integer
	spinner spinerX "" pos:[114,92] width:111 height:16 range:[0,1000,10] type:#integer
	spinner spinerY "" pos:[114,116] width:109 height:16 range:[0,1000,10] type:#integer
	label lbl18 "Altura" pos:[37,142] width:61 height:14
	spinner spinnerAltura "" pos:[112,140] width:111 height:16 range:[0,1000,5] type:#integer
	label label "Suavizado" pos:[35,169] width:63 height:15
	spinner spinnerFreq "" pos:[113,168] width:107 height:16 range:[0,100,10] type:#integer scale:1
	
	on btn6 pressed do
	(
		delete objects
		terreno=#(#())
		tama = spinerTama.value
		tamaTerrenoX = spinerX.value
		tamaTerrenoY = spinerY.value
		crearTerreno spinerX.value spinerY.value spinerTama.value spinnerAltura.value spinnerFreq.value
	)
)

rollout arboles "Árboles" width:270 height:276
(
	GroupBox grp3 "Tronco" pos:[28,57] width:218 height:65
	GroupBox grp4 "Hojas" pos:[25,128] width:216 height:80
	spinner spinerTronco "Tamaño del tronco  " pos:[47,87] width:179 height:16 type:#integer
	spinner spinerHojas     "Capas de hojas      " pos:[45,164] width:176 height:16 type:#integer
	button btn2 "Generar árboles" pos:[30,229] width:217 height:29
	spinner spn8 "Número de árboles      " pos:[44,23] width:196 height:16 type:#integer
	
	on btn2 pressed do(
		print("Hey")
		generaArboles spn8.value spinerTronco.value spinerHojas.value
	)
)

RolloutNuevoTemplate = newrolloutfloater "Minecraft Map Generator (MMP)" 270 550
addrollout scriptFinal RolloutNuevoTemplate
addrollout arboles RolloutNuevoTemplate