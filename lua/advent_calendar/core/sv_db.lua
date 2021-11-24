function AdventCalendar.Core.CreateTable()
    if sql.TableExists('advent_doors') then return end

    sql.Query([[
CREATE TABLE `advent_doors` (
    `userid` varchar(32) NOT NULL,
    `door` int(11) DEFAULT NULL,
    `reward` varchar(32) NOT NULL
)]])
end

hook.Add("Initialize", "AdventCalendar:Load:Database", AdventCalendar.Core.CreateTable)

function AdventCalendar.Core.RegisterDoorOpening(ply, reward)
	sql.Query(string.format("INSERT INTO advent_doors(userid, door, reward) VALUES('%s', '%s', '%s')", ply:SteamID64(), AdventCalendar.CurrentDay, sql.SQLStr(reward, true)))
end

function AdventCalendar.Core.GetOpenedDoors(ply, callback)
    local data = sql.Query(string.format("SELECT door FROM advent_doors WHERE userid='%s'", ply:SteamID64()))

    callback(data)
end