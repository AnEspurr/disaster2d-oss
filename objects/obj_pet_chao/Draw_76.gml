if(!instance_exists(target))
{
	instance_destroy();
	return;
}

image_xscale = target.image_xscale;

if(target == global.player)
{
	image_alpha = target.isHiding ? 0.5 : 1;
	image_index = target.revivalTimes >= 2 || global.character == CHARACTER_EXE;
}
else
{
	image_alpha = target.isHiding ? 0 : 1;
	image_index = target.revivalTimes >= 2 || target.character == CHARACTER_EXE;
}

if(distance_to_object(target) > 200)
{
	x = target.x - image_xscale * 32;
	y = target.y - 10;
}

x = lerp(x, target.x - image_xscale * (target.isHiding ? 16 : 32), 0.22);
y = lerp(y, target.y - 10 + sin(current_time / 500) * 4, 0.22);