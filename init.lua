core.register_chatcommand("ritem",{
  description = "Remove certain item in player's inventory",
  privs = {server=true},
  params = "<playername> <item(RegExp)> [invlistname]",
  func = function(name,param)
	local params = param:split(" ")
	if not params or #params < 2 then
		return false, "Invalid params"
	end
	local listname = params[3] or "main"
	local inv = core.get_inventory({type="player",name=params[1]})
	if not inv then
		return false, "Invalid player"
	end
	local list = inv:get_list(listname)
	if not list then
		return false, "InvList doesnt exist"
	end
	local cleared = 0
	for _,stack in ipairs(list) do
		local sname = stack:get_name()
		if sname and sname:match(params[2]) then
			inv:remove_item(listname,stack)
			cleared = cleared + 1
		end
	end
	return true, "Removed "..tostring(cleared).." items matching '"..params[2].."'"
end})
