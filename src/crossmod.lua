local basecrossmod = {
	next(SMODS.find_mod('Cryptid')) and 'cryptid.lua',
}

if not next(basecrossmod) then 
	sendInfoMessage("No eligible mods found, aborting...", "Willatro");
	return
end

sendInfoMessage("Loading Cross-Mod content...", "Willatro")
for _, file in pairs(basecrossmod) do
	sendDebugMessage("Executing src/crossmod/"..file, "Willatro - Crossmod")
	assert(SMODS.load_file("src/crossmod/"..file))()
end