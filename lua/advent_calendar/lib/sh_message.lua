-- server
if SERVER then
	util.AddNetworkString("AdventCalendar:ChatMessage")
elseif CLIENT then
	net.Receive("AdventCalendar:ChatMessage", function()
		AdventCalendar.Msg(net.ReadString(), net.ReadColor(), net.ReadString())
	end)
end

function AdventCalendar.Msg(tag, clr, msg, ply)
	if SERVER then
		net.Start("AdventCalendar:ChatMessage")
			net.WriteString(tag)
			net.WriteColor(clr)
			net.WriteString(msg)
		if not ply then
			net.Broadcast()
		else
			net.Send(ply)
		end
	elseif CLIENT then
		chat.AddText(clr, tag.." | ", color_white, msg)
	end
end