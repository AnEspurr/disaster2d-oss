function net_identity()
{
	var _pak = cpacket_tcp(PacketType.IDENTITY, false);
	var _os_info = os_get_info();
	
	buffer_write(_pak, buffer_u16, BUILD_VER);
	buffer_write(_pak, buffer_s32, obj_netclient.want_lobby);
	buffer_write(_pak, buffer_string, global.nickname);
	
	if(os_type != os_android)
	{
		buffer_write(_pak, buffer_string, $"mod-{_os_info[? "udid"]}");
	}
	else
	{
		var _udid = $"{_os_info[? "VERSION"]}";
		_udid += _os_info[? "CPU_ABI"];
		_udid += _os_info[? "RELEASE"];
		_udid += _os_info[? "MODEL"];
		_udid += _os_info[? "DEVICE"];
		_udid += _os_info[? "MANUFACTURER"];
		_udid += _os_info[? "BOOTLOADER"];
	
		buffer_write(_pak, buffer_string, $"mod-{_udid}");
	}
	
	buffer_write(_pak, buffer_s8, obj_unlockables.lobbyIcon);
	buffer_write(_pak, buffer_s8, obj_unlockables.pet);
	buffer_write(_pak, buffer_u64, 0);
	buffer_write(_pak, buffer_u64, 0);
	
	send_server_tcp(_pak);
}