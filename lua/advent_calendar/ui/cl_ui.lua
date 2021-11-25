local basicallyBlack = Color(10, 10, 10)
local grey = Color(40, 40, 40)
local ligheterGrey = Color(80, 80, 80)
local gold = Color(218, 165, 32)
local pink = Color(246, 70, 99)
local scrW, scrH = ScrW(), ScrH()

function AdventCalendar.Core.UI()
	local frame = vgui.Create("DFrame")
	frame:SetSize(scrH*0.9, (scrH*0.9) + 30 )
	frame:Center()
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame:SetDraggable(false)
	frame:SetTitle("")
	frame:DockPadding(0, 0, 0, 0)
	function frame:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, basicallyBlack)
	end

	local nav = vgui.Create("DPanel", frame)
	nav:Dock(TOP)
	nav:SetTall(30)
	nav:DockPadding(5, 5, 5, 5)
	function nav:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, grey)
		draw.SimpleText(AdventCalendar.Config.Title, "advent_calendar_25", 5, h/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

		local close = vgui.Create("DButton", nav)
		close:Dock(RIGHT)
		close:SetWide(nav:GetTall() - 10)
		close:SetText("")
		function close:DoClick()
			frame:Close()
		end
		function close:Paint(w, h)
			draw.RoundedBox(5, 0, 0, w, h, pink)
			draw.SimpleText("X", "advent_calendar_25", w/2, h/2, self:IsHovered() and grey or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

	local grid = vgui.Create("ThreeGrid", frame)
	grid:Dock(FILL)
	grid:InvalidateParent(true)
	grid:SetColumns(5)
	grid:SetHorizontalMargin(0)
	grid:SetVerticalMargin(0)

	for _, i in pairs(AdventCalendar.Config.DoorOrder) do
		local door = vgui.Create("DButton")
		door:SetText("")
		door:SetTall(grid:GetTall()/5)
		door.Paint = function(self, w, h)
			if AdventCalendar.OpenedDoors[i] then
				--Door is open
				draw.RoundedBox(0, 5, 5, w-10, h-10, grey)
				draw.RoundedBox(0, w-15, 5, 10, h-10, (i == AdventCalendar.CurrentDay) and gold or pink)
			else
				--Door is closed
				draw.RoundedBox(0, 5, 5, w-10, h-10, (i == AdventCalendar.CurrentDay) and gold or pink)
				draw.RoundedBox(0, 10, h/2-20, 15, 40, ligheterGrey)
			end


			draw.SimpleText(i, "advent_calendar_50", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		door.DoClick = function()
			if AdventCalendar.OpenedDoors[i] then return end
			if not (i == AdventCalendar.CurrentDay) then return end

			net.Start("AdventCalendar:OpenToday")
			net.SendToServer()

			AdventCalendar.OpenedDoors[i] = true
		end
		grid:AddCell(door)
	end
end