global.tcp_buffer = buffer_create(256, buffer_fixed, 1);
global.udp_buffer = buffer_create(256, buffer_fixed, 1);

function cpacket_tcp(_type, _passtrough = false)
{
	buffer_seek(global.tcp_buffer, buffer_seek_start, 0);
	buffer_write(global.tcp_buffer, buffer_u8, _passtrough);
	buffer_write(global.tcp_buffer, buffer_u8, real(_type));
	
	return global.tcp_buffer;
}

function cpacket_udp(_type, _passtrough = false)
{
	buffer_seek(global.udp_buffer, buffer_seek_start, 0);
	buffer_write(global.udp_buffer, buffer_u8, _passtrough);
	buffer_write(global.udp_buffer, buffer_u8, real(_type));
		
	return global.udp_buffer;	
}

function send_server_tcp(_buffer)
{		
	with(obj_netclient)
	{		
		var _size = buffer_tell(_buffer);
		disnet_send(buffer_get_address(_buffer), _size, true);
	}
}

function send_server_udp(_buffer)
{
	with(obj_netclient)
	{
		var _size = buffer_tell(_buffer);
		disnet_send(buffer_get_address(_buffer), _size, false);
	}
}

function buffer_read_s(_buffer, _type)
{
	var _sz = buffer_sizeof(_type);
	if(buffer_tell(_buffer) + _sz > buffer_get_size(_buffer))
	{		
		return -1;
	}
	
	return buffer_read(_buffer, _type);
}
