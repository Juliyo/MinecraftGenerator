
pata=#(#())
tejado=#(#())
gallina=#(#(#()))
	
try (closeRolloutFloater RolloutNuevoTemplate) catch()


rollout scriptFinal "Minecraft Map Generator (MMP)" width:270 height:525
(
	button btn6 "Button" pos:[20,283] width:239 height:46
	
	GroupBox grp27 "Bloques" pos:[30,38] width:225 height:41
	spinner spn84 "Tamaño de los cubos" pos:[58,54] width:169 height:16 type:#integer  range:[0,1000,10]
	
	
	
	on btn6 pressed do
	(
		
	pata=#(#())
		gallina=#(#(#()))
		crearCasa spn84.value
	)
)


RolloutNuevoTemplate = newrolloutfloater "Minecraft Map Generator (MMP)" 270 550
addrollout scriptFinal RolloutNuevoTemplate

fn crearCasa tama=(
	
	posX=0
	posY=0
	posZ=0
	
	posXinicial=posX
	posYinicial=posY
    
	posX2=0
	posY2=0
	for w=1 to 4 do(
		if w!=1 then(
		  append pata #()
		)
		for i=1 to 6 do(
			
		  if(w < 4) then(
			if(w==2 or w==3) then(
				pata[w][i]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:5 pos:[posX,posY,posZ] mapcoords:on 
			)
			else(
				if(i==2 or i==5) then(
				pata[w][i]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:5 pos:[posX,posY,posZ] mapcoords:on 
				)
			)
			
		  )
		  else(
			  
			  if(i==2 or i==5) then(
				
				 pata[w][i]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:5 pos:[posX,posY,posZ+(tama/2)] mapcoords:on 
					  pata[w][i].rotation.x_rotation=90
				  posX2=posX
				  posY2=posY
			  )
			  
		  )
			
			posX=posX+tama
		)
			posX=0
			posY=posY+tama
	)
		
	for z=1 to 4 do(
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:5 pos:[posX2,posY2,posZ+(tama/2)+tama] mapcoords:on
	gallina[1][1][1].rotation.x_rotation=90
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:tama width:tama height:5 pos:[posX2-(tama*3),posY2,posZ+(tama/2)+tama] mapcoords:on
	gallina[1][1][1].rotation.x_rotation=90
		posZ=posZ+tama
	)
	l=tama*6
	w=tama*6
	h=tama*5
	fff=tama*2
	h2=h-fff
	w2=w-fff
	w3=tama*4
	l3=tama*3
	h3=tama*6
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:l width:w height:h pos:[posX2-(tama+tama/2),posY2,posZ+tama] mapcoords:on
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:w2 width:tama height:h2 pos:[posX2+(tama*2),posY2,posZ+tama*3] mapcoords:on
  
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:w2 width:tama height:h2 pos:[posX2-(tama*5),posY2,posZ+tama*3] mapcoords:on
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:l3 width:w3 height:h3 pos:[posX2-tama*2+tama/2,posY2-tama*5+tama/2,posZ+tama*4] mapcoords:on
		
	h4=tama*2
	l4=tama*2
	w4=l4
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:w4 width:l4 height:h4 pos:[posX2-tama*2+tama/2,posY2-tama*6,posZ+tama*4] mapcoords:on
	
	h5=fff
	w5=tama*4
	l5=tama*2
	
	gallina[1][1][1]=Box lengthsegs:1 widthsegs:1 heighsegs:1 length:l5 width:w5 height:h5 pos:[posX2-tama*2+tama/2,posY2-tama*7,posZ+tama*6] mapcoords:on
	
	
	
	
	
	
)
	
