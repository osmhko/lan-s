local B, C
if IsAddOnLoaded("Beauty") then 
	B, C = unpack(Beauty)
else
	B, C = unpack(select(2, ...))
end

C["actionbar"]={
	bar3mode = 3,							-- 1:3 3123   2:123   3:1233
	
	barinset = -1,	
	buttonsize   = 26,
	buttonspacing   = 5,
	barscale = 1,
	petbarscale = 1,
	stancebuttonsize =26,
	petbuttonsize = 26,
	macroname = false,
	itemcount = true,
	hotkeys = true,
	showgrid = true,
	
	bar1mouseover = false,
	bar1fade = false,
	
	bar2mouseover = false,
	bar2fade = false,
	
	bar3_1mouseover = false,
	bar3_1fade = false,
	bar3_2mouseover = false,
	bar3_2fade = false,


	
	bar4mouseover = false,
	bar4fade = false,
	
	bar5mouseover = false,
	bar5fade = false,
	
	stancebarmouseover = false,
	stancebarfade = false,
	
	petbarmouseover = false,
	petbarfade = false,
	
	cooldownalpha = false,
	cdalpha = .8,
	readyalpha = 1,
	stancealpha = false,
}