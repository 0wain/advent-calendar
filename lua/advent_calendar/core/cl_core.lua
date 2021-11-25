-- We network it to the player to account for timezones
net.Receive("AdventCalendar:CurrentDay", function()
	AdventCalendar.CurrentDay = net.ReadInt(32)
	AdventCalendar.OpenedDoors = net.ReadTable()

	AdventCalendar.Core.UI()
end)



surface.CreateFont("advent_calendar_50", {
	font = "Calibri",
	size = 50,
	weight = 100
})
surface.CreateFont("advent_calendar_25", {
	font = "Calibri",
	size = 25,
	weight = 100
})