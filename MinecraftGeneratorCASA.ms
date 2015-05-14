
casa=#(#())
tejado=#(#())

	
try (closeRolloutFloater RolloutNuevoTemplate) catch()


rollout scriptFinal "Minecraft Map Generator (MMP)" width:270 height:525
(

	label lbl1 "Dimensión X" pos:[50,166] width:68 height:17
	label lbl2 "Dimensión Y" pos:[48,189] width:65 height:18
	label lbl18 "Altura pared" pos:[50,212] width:61 height:14
	GroupBox grp2 "Casa" pos:[31,106] width:225 height:165
	button btn6 "Button" pos:[20,283] width:239 height:46
	spinner spinerTama "Cantidad de casas" pos:[57,134] width:169 height:16 type:#integer
	spinner spinerX "" pos:[126,162] width:111 height:16 range:[0,1000,10] type:#integer
	spinner spinerY "" pos:[126,186] width:109 height:16 range:[0,1000,10] type:#integer
	GroupBox grp27 "Bloques" pos:[30,38] width:225 height:41
	spinner spn84 "Tamaño de los cubos" pos:[58,54] width:169 height:16 type:#integer
	spinner spinnerAltura "" pos:[130,213] width:111 height:16 type:#integer
	
	
	on btn6 pressed do
	(
		delete objects
	casa=#(#())
		crearCasa spinerX.value spinerY.value spn84.value spinnerAltura.value
	)
)


RolloutNuevoTemplate = newrolloutfloater "Minecraft Map Generator (MMP)" 270 550
addrollout scriptFinal RolloutNuevoTemplate

fn crearCasa X Y tama Z=(
	
	posX=0
	posY=0
	posZ=0
	limiteX=X
	limiteY=Y
	
	
	--casa sin tejado:
for w=1 to Z do(
	for i=1 to X do(
		if i!=1 then(
		  append casa #()
		)
		for j=1 to Y do(
				if (i==1 or i==limiteX) or (j==1 or j==limiteY) then(
					
				casa[i][j]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:tama pos:[posX,posY,posZ] mapcoords:on 
				
			)

				posX=posX+tama
				
		)
	
		posX=0
		posY=posY+tama
	)
	
	posX=0
	posY=0
	posZ=posZ+tama
)
--tejado:
mayor=0
if X > Y then (mayor=X)
else (mayor=Y)

min=1
for g=1 to mayor do(
	for d=1 to X do(
		if d!=1 then (append tejado #())
		for a=1 to Y do(
			
			if limiteX > d  and  d > min then(
				if limiteY > a and a > min then(
				tejado[d][a]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:tama pos:[posX,posY,posZ]  mapcoords:on 
				)
			)
			
			posX=posX+tama
		)
		posX=0
		posY=posY+tama
	)
	limiteX=limiteX-1
	limiteY=limiteY-1
	posX=0
	posY=0
	posZ=posZ+tama
	min=min+1
	
)


 
)
	
