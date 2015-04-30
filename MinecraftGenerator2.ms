--dotnet.loadAssembly (sysInfo.currentdir + "\SimplexNoise.dll")
dotnet.loadAssembly (sysInfo.currentdir +"\PerlinNoiseV2.dll")

 --print(script.GetRandomHeight 0 1 100 1 1 1 2 )
/*VARIABLES*/

terreno=#(#())




try (closeRolloutFloater RolloutNuevoTemplate) catch()


rollout scriptFinal "Minecraft Map Generator (MMP)" width:270 height:501
(


	GroupBox GrupoTerreno "Terreno" pos:[17,78] width:229 height:200
	label lbl1 "Dimensión X" pos:[37,100] width:68 height:17
	label lbl2 "Dimensión Y" pos:[35,123] width:65 height:18
	GroupBox grp2 "Bloques" pos:[20,28] width:225 height:41
	button btn6 "Button" pos:[16,390] width:239 height:46
	spinner spinerTama "Tamaño de los cubos" pos:[48,44] width:169 height:16 type:#integer
	spinner spinerX "" pos:[113,96] width:111 height:16 range:[0,1000,10] type:#integer
	spinner spinerY "" pos:[113,120] width:109 height:16 range:[0,1000,10] type:#integer
	label lbl18 "Altura" pos:[36,146] width:61 height:14
	spinner spinnerAltura "" pos:[111,144] width:111 height:16 range:[0,1000,5] type:#integer
	label label "Suavizado" pos:[34,173] width:63 height:15
	spinner spinnerFreq "" pos:[112,172] width:107 height:16 range:[0,100,10] type:#integer scale:1
	on btn6 pressed do
	(
		delete objects
		terreno=#(#())
		crearTerreno spinerX.value spinerY.value spinerTama.value spinnerAltura.value spinnerFreq.value
	)
)

RolloutNuevoTemplate = newrolloutfloater "Minecraft Map Generator (MMP)" 270 550
addrollout scriptFinal RolloutNuevoTemplate

fn crearTerreno X Y tama altura frecuencia=  (
	semilla=random 5000 5300
	script = dotNetObject "PerlinNoiseV2.Perlin" (semilla) (frecuencia)
	--simplexNoise = dotNetObject "SimplexNoise.Noise"
	posX = 0
	posY = 0
	ruido = 0.0
	ruidomax=0.0
	ruidomin=0.0
	mm = multimaterial numsubs:6
	bitmapLados = bitmaptexture filename:"c:\lado.jpg"
	bitmapTop = bitmaptexture filename:"c:\arriba.jpg"
	mm[1].diffusemap = bitmapTop
	mm[1].showInViewport = on
	mm[2].diffusemap = bitmapLados
	mm[2].showInViewport = on
	mm[3].diffusemap = bitmapLados
	mm[3].showInViewport = on
	mm[4].diffusemap = bitmapLados
	mm[4].showInViewport = on
	mm[5].diffusemap = bitmapLados
	mm[5].showInViewport = on
	mm[6].diffusemap = bitmapLados
	mm[6].showInViewport = on
	
	for i=1 to X do(
		if i!=1 then(
		  append terreno #()
		)
		for j=1 to Y do(

				-- script2 = dotNetObject "PerlinNoiseV2.Perlin" (10*(sqrt 5330)) (5)
				-- script3 = dotNetObject "PerlinNoiseV2.Perlin" (5330*5330) (20)
				-- print((12*(script.getNoiseLevelAtPosition i j))+(6*(script2.getNoiseLevelAtPosition i j))+(24*(script3.getNoiseLevelAtPosition i j)))
				-- ruido = (12*(script.getNoiseLevelAtPosition i j))+(6*(script2.getNoiseLevelAtPosition i j))+(24*(script3.getNoiseLevelAtPosition i j))
			
				ruido = 	script.getNoiseLevelAtPosition i j
				if i==1 and j==1 then(
					terreno[i][j]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:tama pos:[posX ,posY,ruido]  mapcoords:on  material:mm
				)else(
					terreno[i][j]=instance terreno[1][1]
					terreno[i][j].pos.x=posX
					terreno[i][j].pos.y=posY
					terreno[i][j].pos.z=ruido
					
				)
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
			
			/*for k=0 to escalon-1 do(
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
			/*for k=0 to escalon-1 do(
				relleno=instance terreno[1][1]
				relleno.pos.x=terreno[i][j].pos.x
				relleno.pos.y=terreno[i][j].pos.y
				relleno.pos.z=tama*k
			)*/
			terreno[i][j].pos.z=(int)escalon*tama
		)
	)

)
