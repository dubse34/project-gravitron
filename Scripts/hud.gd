extends CanvasLayer

func update_ammo(count): #function for updating ammo count in HUD
	$Ammo.text = str(count)
