-- ZenWare X (fixed build)
-- Changes: welcome splash no longer blocks clicks and always auto-hides,
-- splash animation is wrapped in pcall, and the menu opens even if the splash fails.

local P,RS,UIS,TS,HS,Lt,MP=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService"),game:GetService("TweenService"),game:GetService("HttpService"),game:GetService("Lighting"),game:GetService("MarketplaceService")
local TXS,VIM=game:GetService("TextService"),game:GetService("VirtualInputManager")
local LP,G=P.LocalPlayer,(getgenv and getgenv()) or _G
local function gp() local r=LP:WaitForChild("PlayerGui") pcall(function() r=(gethui and gethui()) or game:GetService("CoreGui") end) return r end
pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="ZenMenu",Text="Loading..."}) end)
local function boot(force)
local ok,e=pcall(function()
if G.ZW then pcall(G.ZW) end
local par=gp()
for _,g in ipairs(par:GetChildren()) do if g.Name=="ZenwareGui" then g:Destroy() end end
local rgb=Color3.fromRGB
local WH,BLK=Color3.new(1,1,1),Color3.new(0,0,0)
local function kp(t,c) return ColorSequenceKeypoint.new(t,c) end
local function AV(id) return "rbxthumb://type=AvatarHeadShot&id="..tostring(id).."&w=150&h=150" end
local T,TH,PK,Th,X,PG,REP,ST={}, {}, {}, {}, {}, {}, {}, {theme="Black",pack="Zen",corner="Round",hue=.6,opac=1}
-- ===== THEMES / FONTS =====
local function mk(bg,ac,oa,lt)
	local m=lt and BLK or WH
	return {BG=bg,RW=bg:Lerp(m,lt and .05 or .06),RB=bg:Lerp(m,lt and .12 or .14),OF=bg:Lerp(m,.22),TR=bg:Lerp(m,lt and .17 or .18),
		TX=lt and rgb(20,20,24) or rgb(240,240,240),DIM=lt and rgb(110,110,120) or rgb(150,150,160),AC=ac,OA=oa}
end
TH.Black=mk(rgb(8,8,8),rgb(255,255,255),rgb(0,0,0))
TH.White=mk(rgb(246,246,248),rgb(40,40,48),rgb(255,255,255),true)
TH.Rainbow=mk(rgb(8,8,8),rgb(255,255,255),rgb(0,0,0))
TH.Midnight=mk(rgb(8,10,24),rgb(80,140,255),rgb(255,255,255))
TH.Crimson=mk(rgb(16,6,8),rgb(235,50,70),rgb(255,255,255))
TH.Emerald=mk(rgb(5,16,10),rgb(40,215,120),rgb(0,0,0))
TH.Amethyst=mk(rgb(14,8,22),rgb(170,100,255),rgb(255,255,255))
TH.Ocean=mk(rgb(5,14,20),rgb(40,200,230),rgb(0,0,0))
TH.Sunset=mk(rgb(20,8,10),rgb(255,130,60),rgb(0,0,0))
TH.Rose=mk(rgb(20,8,14),rgb(255,100,170),rgb(0,0,0))
TH.Gold=mk(rgb(14,12,6),rgb(240,195,60),rgb(0,0,0))
Th.names={"Black","White","Rainbow","Midnight","Crimson","Emerald","Amethyst","Ocean","Sunset","Rose","Gold","Custom"}
PK.Zen={"Michroma","GothamMedium"} PK.Clean={"GothamBlack","Gotham"} PK.Terminal={"Code","RobotoMono"} PK.SciFi={"SciFi","Jura"}
PK.Arcade={"Arcade","SourceSans"} PK.Fantasy={"Fantasy","Merriweather"} PK.Bold={"Bangers","Oswald"} PK.Soft={"Nunito","Ubuntu"}
Th.pnames={"Zen","Clean","Terminal","SciFi","Arcade","Fantasy","Bold","Soft"}
Th.csc={Sharp=0,Soft=.5,Round=1,Pill=1.8}
Th.RBSEQ=ColorSequence.new({kp(0,rgb(255,60,60)),kp(.17,rgb(255,200,50)),kp(.34,rgb(80,255,100)),kp(.5,rgb(60,220,255)),kp(.67,rgb(90,110,255)),kp(.84,rgb(230,80,255)),kp(1,rgb(255,60,60))})
function Th.custom() TH.Custom=mk(rgb(10,10,12),Color3.fromHSV(math.clamp(tonumber(ST.hue) or .6,0,1),.75,1),rgb(0,0,0)) end
function Th.cr(r) if r>=50 then return r end return math.floor(r*Th.csc[ST.corner]+.5) end
function Th.fnt(n) local o,v=pcall(function() return Enum.Font[n] end) return o and v or Enum.Font.GothamMedium end
function Th.use(n) local t=TH[n] or TH.Black T.cur=t for k,v in pairs(t) do T[k]=v end end
function Th.usepack(n) T.HF=Th.fnt(PK[n][1]) T.BF=Th.fnt(PK[n][2]) end
function Th.glow() return ColorSequence.new({kp(0,T.AC),kp(.5,T.AC:Lerp(T.BG,.75)),kp(1,T.AC)}) end
do local o,d=pcall(function() return HS:JSONDecode(readfile("ZenMenu_Style.json")) end) if o and type(d)=="table" then for k,v in pairs(d) do ST[k]=v end end end
Th.custom()
if not TH[ST.theme] then ST.theme="Black" end if not PK[ST.pack] then ST.pack="Zen" end if not Th.csc[ST.corner] then ST.corner="Round" end
Th.use(ST.theme) Th.usepack(ST.pack)
local C,TG,SL,oc={}, {}, {},0
local F={auto=false,spd=120,stay=1,cruise=40,back=true,tpb=false,rspd=600,runS=70,runB=90,bsafe=0,alert=true,snd=true,eesp=true,etr=false,fly=false,walk=false,walkS=32,noclip=false,inf=false,afk=false,arj=false,pesp=false,pbox=false,phb=false,ptr=false,chams=false,edist=2000,aim=false,sticky=true,team=false,wall=false,cross=false,face=true,trig=false,tdel=.05,pred=.1,afov=200,smooth=0,jp=false,jpv=100,gravOn=false,grav=196,ctp=false,instp=false,fovOn=false,fovV=70,fpsb=false,mlfarm=false,mlrate=10,mlreb=false,mlcry=false,mlcnt=10,mlcdel=.4,mlmin=0,mlka=false,mlkr=20,mlkall=false,mlktp=false,mlfr=true,mmesp=false,mmcoin=false,mmr=200,bffesp=false,bfcesp=false,drpesp=false,drauto=false,drr=12,drd=120,dral=true,bbp=false,bbt=.35,bbs=false,fbeast=true,fcomp=false,fexit=false,fpod=false,fb=false,fps=false,glow=true,blur=true,part=true,splash=true,asave=true,uiS=1,hue=ST.hue,opac=ST.opac}
local NS={auto=1,fly=1,aim=1,trig=1,mlfarm=1,mlcry=1,mlka=1,mlreb=1,mlkall=1,mlktp=1,mmcoin=1,drauto=1,bbp=1,bbs=1,ctp=1,hue=1,opac=1}
local nop=function() end
local main,ms,gui
local function cn(c) C[#C+1]=c return c end
local function new(c,p,pr)
	local o=Instance.new(c)
	if o:IsA("GuiObject") then oc=oc+1 o.BorderSizePixel=0 o.LayoutOrder=oc o.BackgroundColor3=T.RW end
	if c=="TextLabel" or c=="TextButton" or c=="TextBox" then o.Font=T.BF o.TextSize=13 o.TextColor3=T.TX end
	if c=="TextLabel" then o.BackgroundTransparency=1 end
	for k,v in pairs(p) do o[k]=v end
	o.Parent=pr return o
end
local function rd(o,r) r=r or 8 local c=new("UICorner",{CornerRadius=UDim.new(0,Th.cr(r))},o) c:SetAttribute("R",r) end
local function tw(o,t,p,s,d) TS:Create(o,TweenInfo.new(t,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p):Play() end
local function press(b)
	local u=new("UIScale",{},b)
	b.ClipsDescendants=true
	b.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			tw(u,.08,{Scale=.95})
			pcall(function()
				local sc=(ms and main and b:IsDescendantOf(main)) and ms.Scale or 1
				if sc<=0 then sc=1 end
				local ab,as=b.AbsolutePosition,b.AbsoluteSize
				local rp=new("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromOffset((i.Position.X-ab.X)/sc,(i.Position.Y-ab.Y)/sc),Size=UDim2.fromOffset(0,0),BackgroundColor3=T.TX,BackgroundTransparency=.78,ZIndex=5},b)
				rd(rp,99)
				local m=math.max(as.X,as.Y)/sc*2.3
				tw(rp,.55,{Size=UDim2.fromOffset(m,m),BackgroundTransparency=1})
				task.delay(.6,function() rp:Destroy() end)
			end)
		end
	end)
	b.InputEnded:Connect(function() tw(u,.25,{Scale=1},Enum.EasingStyle.Back) end)
end
local function drag(h,f)
	local d,s,p0
	h.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			d,s,p0=true,i.Position,f.Position
			i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then d=false end end)
		end
	end)
	cn(UIS.InputChanged:Connect(function(i)
		if d and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local v=i.Position-s f.Position=UDim2.new(p0.X.Scale,p0.X.Offset+v.X,p0.Y.Scale,p0.Y.Offset+v.Y)
		end
	end))
end
local function hum() local c=LP.Character return c and c:FindFirstChildOfClass("Humanoid") end
local function root() local c=LP.Character return c and c:FindFirstChild("HumanoidRootPart") end
gui=new("ScreenGui",{Name="ZenwareGui",ResetOnSpawn=false,IgnoreGuiInset=true},par)
local EL=new("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1},gui)
-- ===== ZENMENU (game picker) =====
local GM={
{k="pet",n="Ride a Pet",u=10035204815,d="Egg farming with auto fly.",f="Auto fly to eggs (noclip)\nRarity + egg filters\nBlacklist tab\nReturn to base\nEgg + player ESP"},
{k="egg",n="Steal an Egg",u=10563114921,p=107778070777162,d="Autofarm eggs by running.",f="Autofarm: runs to the egg, runs back\nEgg ESP with area + rarity\nFilter by area / rarity\nBlacklist tab\nRuns instead of flying"},
{k="riv",n="Rivals",u=6035872082,p=17625359962,d="Aimbot + ESP menu.",f="Sticky aimbot + face target\nTriggerbot + FOV circle\nBox ESP + health bars\nTracers + chams"},
{k="ars",n="Arsenal",p=286090429,d="FPS aimbot, triggerbot, ESP.",f="Sticky aimbot + FOV circle\nTriggerbot\nBox ESP + health + tracers\nPlayers tab with avatars"},
{k="pf",n="Phantom Forces",p=292439477,d="FPS aimbot, triggerbot, ESP.",f="Sticky aimbot + FOV circle\nTriggerbot\nBox ESP + health + tracers\nPlayers tab with avatars"},
{k="cb",n="Counter Blox",p=301549746,d="FPS aimbot, triggerbot, ESP.",f="Sticky aimbot + FOV circle\nTriggerbot\nBox ESP + health + tracers\nPlayers tab with avatars"},
{k="mm2",n="Murder Mystery 2",p=142823291,d="Role ESP and coin collect.",f="Murderer / sheriff / innocent ESP\nAuto collect coins\nTeleport to dropped gun\nPlayers tab with avatars"},
{k="flee",n="Flee the Facility",p=893973440,d="Beast + map ESP.",f="Beast ESP\nComputer / exit / pod ESP\nTeleport to computers\nPlayers tab with avatars"},
{k="bf",n="Blox Fruits",ps={2753915549,4442272183,7449423635},p=2753915549,d="Fruit and chest finder.",f="Fruit ESP + teleport\nChest ESP + teleport\nPlayer ESP\nPlayers tab with avatars"},
{k="doors",n="Doors",ps={6516141723,6839171747},p=6839171747,d="Prompt ESP and auto interact.",f="Item / door prompt ESP\nAuto interact (skips hiding)\nEntity alerts\nFullbright, speed"},
{k="ball",n="Blade Ball",p=13772394625,d="Auto parry helper.",f="Auto parry (ETA based)\nSpam parry\nAdjustable reaction time\nSpeed, jump"},
{k="nds",n="Natural Disaster",p=189707,d="Survival helpers.",f="Sky platform safe spot\nReturn to ground\nFly, noclip, speed\nInfinite jump"},
{k="brk",n="Brookhaven",p=4924922222,d="Teleports and utilities.",f="Players tab with avatars + view\nPlayer ESP\nFly, noclip, speed\nClick teleport"},
{k="prl",n="Prison Life",p=155615604,d="Teleports and ESP.",f="Players tab with avatars + view\nPlayer ESP\nFly, noclip, speed\nClick teleport"},
{k="ml",n="Muscle Legends",p=3623096087,d="Farm, crystals and combat.",f="Auto farm + auto rebirth\nCrystal opener + gem cost\nKill aura (any range option)\nPlayers tab + ESP"},
{k="uni",n="Universal",u=9271746647,p=123974602339071,d="Works in any game.",f="Aimbot + triggerbot + ESP\nFly, noclip, speed\nPlayers tab with avatars\nFullbright, FPS counter"}}
local choice,det
do
	local pn="" pcall(function() pn=MP:GetProductInfo(game.PlaceId).Name:lower() end)
	local KN={pet="ride a pet",riv="rivals",ml="muscle legends",ars="arsenal",pf="phantom forces",cb="counter blox",mm2="murder mystery",flee="flee the facility",bf="blox fruits",doors="doors",ball="blade ball",nds="natural disaster",brk="brookhaven",prl="prison life"}
	for _,g in ipairs(GM) do
		if (g.u and game.GameId==g.u) or (g.p and game.PlaceId==g.p) then det=g end
		if g.ps then for _,id in ipairs(g.ps) do if game.PlaceId==id then det=g end end end
	end
	if not det then for _,g in ipairs(GM) do if KN[g.k] and pn:find(KN[g.k],1,true) then det=g end end end
	local function rf(f) local o,v=pcall(readfile,f) return o and v or nil end
	local lastK,autoOn=rf("ZenMenu_Last.txt"),rf("ZenMenu_Auto.txt")=="1"
	if autoOn and not force then for _,g in ipairs(GM) do if g.k==lastK then choice=g.k end end end
	if not choice then
		local hub=new("CanvasGroup",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,0),Size=UDim2.fromOffset(450,300),BackgroundColor3=T.BG,GroupTransparency=1},gui) rd(hub,14)
		local hs=new("UIScale",{Scale=.85},hub) new("UIStroke",{Color=T.AC,Transparency=.6,Thickness=1.5},hub)
		local hav=new("ImageLabel",{Size=UDim2.fromOffset(26,26),Position=UDim2.fromOffset(12,10),BackgroundColor3=T.RB,Image=AV(LP.UserId)},hub) rd(hav,99)
		new("UIStroke",{Color=T.AC,Thickness=1.5,Transparency=.3},hav)
		new("TextLabel",{Size=UDim2.fromOffset(112,26),Position=UDim2.fromOffset(44,10),Text="Welcome, "..LP.DisplayName,TextSize=10,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},hub)
		new("TextLabel",{Size=UDim2.new(1,0,0,30),Position=UDim2.fromOffset(0,8),Text="Z E N M E N U",Font=T.HF,TextSize=15},hub)
		new("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.fromOffset(0,36),Text="SELECT YOUR GAME",Font=T.HF,TextSize=8,TextColor3=T.DIM},hub)
		local hx=new("TextButton",{Size=UDim2.fromOffset(24,22),Position=UDim2.new(1,-34,0,10),Text="X",BackgroundColor3=T.RB},hub) rd(hx,6) press(hx) hx.Activated:Connect(function() gui:Destroy() end)
		local list=new("ScrollingFrame",{Size=UDim2.fromOffset(150,236),Position=UDim2.fromOffset(12,54),BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},hub)
		new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},list)
		local rp=new("Frame",{Size=UDim2.fromOffset(264,236),Position=UDim2.fromOffset(174,54)},hub) rd(rp,12) new("UIStroke",{Color=T.TX,Transparency=.92},rp)
		local bi=new("ImageLabel",{Size=UDim2.fromOffset(80,80),Position=UDim2.fromOffset(14,14),BackgroundColor3=T.RB,ScaleType=Enum.ScaleType.Crop},rp) rd(bi,12)
		local bn=new("TextLabel",{Size=UDim2.fromOffset(146,40),Position=UDim2.fromOffset(104,14),Font=T.HF,TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},rp)
		local bd=new("TextLabel",{Size=UDim2.fromOffset(146,44),Position=UDim2.fromOffset(104,56),TextSize=11,TextColor3=T.DIM,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top},rp)
		local bf=new("TextLabel",{Size=UDim2.fromOffset(236,66),Position=UDim2.fromOffset(14,106),TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top},rp)
		local ab=new("TextButton",{Size=UDim2.fromOffset(236,22),Position=UDim2.fromOffset(14,176),TextSize=10,BackgroundColor3=T.RB},rp) rd(ab,6) press(ab)
		local function abt() ab.Text="Auto-launch this game next time: "..(autoOn and "ON" or "OFF") end abt()
		ab.Activated:Connect(function() autoOn=not autoOn abt() end)
		local go=new("TextButton",{Size=UDim2.fromOffset(236,26),Position=UDim2.fromOffset(14,202),Text="LAUNCH",Font=T.HF,TextSize=11,BackgroundColor3=T.AC,TextColor3=T.OA},rp) rd(go,8) press(go)
		local cards,sel={}, nil
		local function setSel(g)
			sel=g bn.Text=g.n:upper() bd.Text=g.d bf.Text=g.f bi.Image=cards[g.k].im.Image
			for k,c in pairs(cards) do tw(c.st,.25,{Transparency=k==g.k and 0 or .88}) end
		end
		for _,g in ipairs(GM) do
			local c=new("TextButton",{Size=UDim2.new(1,-4,0,56),Text="",AutoButtonColor=false},list) rd(c,10) press(c)
			local st=new("UIStroke",{Color=T.AC,Transparency=.88},c)
			local im=new("ImageLabel",{Size=UDim2.fromOffset(44,44),Position=UDim2.fromOffset(6,6),BackgroundColor3=T.RB,ScaleType=Enum.ScaleType.Crop},c) rd(im,8)
			new("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.fromOffset(56,0),Text=g.n..(det==g and "\nDETECTED" or ""),TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},c)
			cards[g.k]={st=st,im=im} c.Activated:Connect(function() setSel(g) end)
			task.spawn(function()
				local img
				if g.p then local o,i=pcall(function() return MP:GetProductInfo(g.p) end) if o and i and i.IconImageAssetId and i.IconImageAssetId~=0 then img="rbxassetid://"..i.IconImageAssetId end end
				if not img then local id=(det==g) and game.GameId or g.u if id then img="rbxthumb://type=GameIcon&id="..id.."&w=150&h=150" end end
				if img then im.Image=img if sel==g then bi.Image=img end end
			end)
		end
		go.Activated:Connect(function() if sel then pcall(writefile,"ZenMenu_Last.txt",sel.k) pcall(writefile,"ZenMenu_Auto.txt",autoOn and "1" or "0") choice=sel.k end end)
		local pre=det for _,g in ipairs(GM) do if not pre and g.k==lastK then pre=g end end
		setSel(pre or GM[1])
		tw(hub,.4,{GroupTransparency=0}) tw(hs,.55,{Scale=1},Enum.EasingStyle.Back)
		repeat task.wait(.1) until choice or not gui.Parent
		if gui.Parent then tw(hub,.3,{GroupTransparency=1}) tw(hs,.3,{Scale=1.1}) task.wait(.32) hub:Destroy() end
	end
end
if not gui.Parent then return end
local GN="" for _,g in ipairs(GM) do if g.k==choice then GN=g.n end end
-- ===== LOADER (lightning Z) =====
local step,endLoad
do
	local ld=new("CanvasGroup",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,0),Size=UDim2.fromOffset(270,210),BackgroundColor3=T.BG,GroupTransparency=1,ZIndex=50},gui) rd(ld,14)
	local lds=new("UIScale",{Scale=.8},ld) new("UIStroke",{Color=T.TX,Transparency=.75},ld)
	local fx=new("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=T.AC,BackgroundTransparency=1,ZIndex=60},gui)
	local bolt=new("Frame",{Size=UDim2.fromOffset(64,72),Position=UDim2.new(.5,-32,0,14),BackgroundTransparency=1},ld)
	local bz={}
	for i,s in ipairs({{8,8,56,4},{56,4,30,34},{36,30,8,68},{8,68,58,64}}) do
		local a,b=Vector2.new(s[1],s[2]),Vector2.new(s[3],s[4]) local d=b-a
		bz[i]=new("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromOffset((a.X+b.X)/2,(a.Y+b.Y)/2),Size=UDim2.fromOffset(d.Magnitude+4,7),Rotation=math.deg(math.atan2(d.Y,d.X)),BackgroundTransparency=1,BackgroundColor3=T.AC},bolt) rd(bz[i],3) new("UIStroke",{Color=T.AC,Thickness=2,Transparency=.75},bz[i])
	end
	new("TextLabel",{Size=UDim2.new(1,0,0,20),Position=UDim2.fromOffset(0,96),Text="Z E N W A R E",Font=T.HF,TextSize=14},ld)
	new("TextLabel",{Size=UDim2.fromOffset(20,30),Position=UDim2.fromOffset(32,128),Text="(",Font=T.HF,TextSize=20},ld)
	new("TextLabel",{Size=UDim2.fromOffset(20,30),Position=UDim2.fromOffset(218,128),Text=")",Font=T.HF,TextSize=20},ld)
	local lbk=new("Frame",{Size=UDim2.fromOffset(160,3),Position=UDim2.fromOffset(55,141),BackgroundColor3=T.TR},ld) rd(lbk,99)
	local lbf=new("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=T.AC},lbk) rd(lbf,99)
	local lpc=new("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.fromOffset(0,158),Text="0%",TextSize=10,TextColor3=T.DIM},ld)
	local lst=new("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.fromOffset(0,176),Text="",TextSize=11,TextColor3=T.DIM},ld)
	step=function(p,t) lst.Text=t lpc.Text=math.floor(p*100).."%" tw(lbf,.25,{Size=UDim2.new(p,0,1,0)}) task.wait(.22) end
	endLoad=function() tw(ld,.45,{GroupTransparency=1}) tw(lds,.45,{Scale=1.15}) task.wait(.4) ld:Destroy() fx:Destroy() end
	tw(ld,.4,{GroupTransparency=0}) tw(lds,.5,{Scale=1},Enum.EasingStyle.Back)
	task.spawn(function()
		task.wait(.3)
		for _,f in ipairs(bz) do tw(f,.12,{BackgroundTransparency=0}) task.wait(.09) end
		fx.BackgroundTransparency=.82 tw(fx,.5,{BackgroundTransparency=1})
		while ld.Parent do for _,f in ipairs(bz) do tw(f,.1,{BackgroundTransparency=math.random()*.55}) end task.wait(.12+math.random()*.2) end
	end)
end
step(.12,"Building "..GN.." menu")
-- ===== ZENWARE WINDOW =====
main=new("CanvasGroup",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,0),Size=UDim2.fromOffset(500,380),BackgroundColor3=T.BG,Active=true,Visible=false},gui) rd(main,14)
ms=new("UIScale",{Scale=0},main)
local stk=new("UIStroke",{Color=T.AC,Transparency=.55,Thickness=1.5},main)
local stg=new("UIGradient",{Color=Th.glow()},stk)
-- floating particles (behind everything)
X.dots={}
do
	local pl=new("Frame",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1},main)
	for i=1,24 do
		local s=math.random(2,4)
		local f=new("Frame",{Size=UDim2.fromOffset(s,s),BackgroundColor3=T.AC,BackgroundTransparency=.85,Position=UDim2.fromScale(math.random(),math.random())},pl) rd(f,99)
		X.dots[i]={f=f,x=math.random(),y=math.random(),s=.02+math.random()*.05,p=math.random()*6,w=.4+math.random()}
	end
end
local tb=new("Frame",{Size=UDim2.new(1,0,0,40),BackgroundTransparency=1},main) drag(tb,main)
local avc=new("ImageLabel",{Size=UDim2.fromOffset(28,28),Position=UDim2.fromOffset(10,6),BackgroundColor3=T.RB,Image=AV(LP.UserId)},tb) rd(avc,99)
new("UIStroke",{Color=T.AC,Thickness=1.5,Transparency=.3},avc)
new("TextLabel",{Name="ZTitle",Size=UDim2.fromOffset(150,18),Position=UDim2.fromOffset(46,3),Text="Z E N W A R E",Font=T.HF,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left},tb)
new("TextLabel",{Size=UDim2.fromOffset(250,14),Position=UDim2.fromOffset(46,22),Text="Welcome, "..LP.DisplayName.."  •  "..GN,TextSize=9,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},tb)
local shine=new("Frame",{Size=UDim2.new(1,-24,0,1),Position=UDim2.fromOffset(12,39),BackgroundColor3=T.AC:Lerp(WH,.2)},tb)
local shg=new("UIGradient",{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.5,0),NumberSequenceKeypoint.new(1,1)})},shine)
local lbx=new("TextButton",{Size=UDim2.fromOffset(42,42),Position=UDim2.fromOffset(20,100),Text="Z",Font=T.HF,TextSize=18,BackgroundColor3=T.AC,TextColor3=T.OA,Visible=false},gui) rd(lbx,10) drag(lbx,lbx)
local mb=new("TextButton",{Size=UDim2.fromOffset(26,22),Position=UDim2.new(1,-62,.5,-11),Text="-",BackgroundColor3=T.RB},tb) rd(mb,6) press(mb)
local xb=new("TextButton",{Size=UDim2.fromOffset(26,22),Position=UDim2.new(1,-32,.5,-11),Text="X",BackgroundColor3=T.RB},tb) rd(xb,6) press(xb)
-- welcome splash (NON-blocking: never eats clicks, always auto-hides)
local spl=new("CanvasGroup",{Size=UDim2.fromScale(1,1),BackgroundColor3=T.BG,ZIndex=30,Visible=false,Active=false},main) rd(spl,14)
local sAv=new("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,-46),Size=UDim2.fromOffset(0,0),BackgroundColor3=T.RB,Image=AV(LP.UserId)},spl) rd(sAv,99)
new("UIStroke",{Color=T.AC,Thickness=2.5},sAv)
local sT1=new("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,.5,6),Text="W E L C O M E",Font=T.HF,TextSize=10,TextColor3=T.AC,TextTransparency=1},spl)
local sT2=new("TextLabel",{Size=UDim2.new(1,0,0,30),Position=UDim2.new(0,0,.5,24),Text="",Font=T.HF,TextSize=22},spl)
local sT3=new("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,.5,58),Text="@"..LP.Name.."  •  "..GN,TextSize=10,TextColor3=T.DIM,TextTransparency=1},spl)
local function hideSplash()
	pcall(function() tw(spl,.5,{GroupTransparency=1}) end)
	task.delay(.55,function() spl.Visible=false end)
end
local function playSplash()
	if X.splashed or not F.splash then return end
	X.splashed=true
	spl.Visible=true spl.GroupTransparency=0
	tw(sAv,.7,{Size=UDim2.fromOffset(78,78)},Enum.EasingStyle.Back)
	task.delay(.25,function() tw(sT1,.4,{TextTransparency=0}) end)
	-- hard timeout: the splash can never stay on screen longer than ~4 seconds
	task.delay(4,hideSplash)
	task.spawn(function()
		pcall(function()
			task.wait(.35)
			local nm=LP.DisplayName
			local n=utf8.len(nm) or #nm
			for i=1,n do
				local pos=utf8.offset(nm,i+1) or (#nm+1)
				sT2.Text=nm:sub(1,pos-1) task.wait(.04)
			end
			tw(sT3,.4,{TextTransparency=0})
			task.wait(.9)
			hideSplash()
		end)
		-- if anything above failed, make sure the splash is gone
		spl.Visible=false
	end)
end
X.blur=Instance.new("BlurEffect") X.blur.Size=0 X.blur.Parent=Lt
local lastPos=main.Position
local function hide()
	lastPos=main.Position
	tw(main,.25,{GroupTransparency=1,Position=lastPos+UDim2.fromOffset(0,14)}) tw(ms,.3,{Scale=.85},Enum.EasingStyle.Back,Enum.EasingDirection.In)
	tw(X.blur,.3,{Size=0})
	task.delay(.28,function() main.Visible=false lbx.Visible=true lbx.Size=UDim2.fromOffset(0,0) tw(lbx,.4,{Size=UDim2.fromOffset(42,42)},Enum.EasingStyle.Back) end)
end
local function showM()
	lbx.Visible=false main.Visible=true main.GroupTransparency=1 ms.Scale=.85
	main.Position=lastPos+UDim2.fromOffset(0,18)
	tw(main,.4,{GroupTransparency=1-F.opac,Position=lastPos}) tw(ms,.6,{Scale=F.uiS},Enum.EasingStyle.Back)
	if F.blur then tw(X.blur,.5,{Size=14}) end
	task.delay(.3,function() pcall(playSplash) end)
end
mb.Activated:Connect(hide) lbx.Activated:Connect(showM) xb.Activated:Connect(function() G.ZW() end)
cn(UIS.InputBegan:Connect(function(i,g) if not g and (i.KeyCode==Enum.KeyCode.RightShift or i.KeyCode==Enum.KeyCode.Minus) then if main.Visible then hide() else showM() end end end))
-- toast
local ts=new("Frame",{Size=UDim2.fromOffset(210,40),Position=UDim2.new(1,10,1,-56),BackgroundColor3=T.BG,ZIndex=10},gui) rd(ts,8) new("UIStroke",{Color=T.TX,Transparency=.7},ts)
local tsB=new("Frame",{Size=UDim2.new(0,3,1,-12),Position=UDim2.fromOffset(6,6),BackgroundColor3=T.AC},ts) rd(tsB,99)
local tsL=new("TextLabel",{Size=UDim2.new(1,-26,1,-6),Position=UDim2.fromOffset(18,0),Text="",TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},ts)
local tsP=new("Frame",{Size=UDim2.new(1,-16,0,2),Position=UDim2.new(0,8,1,-4),BackgroundColor3=T.AC,BackgroundTransparency=.4},ts) rd(tsP,99)
local tk=0
local function toast(m)
	tk=tk+1 local me=tk
	tsL.Text=m tsP.Size=UDim2.new(1,-16,0,2)
	tw(ts,.5,{Position=UDim2.new(1,-226,1,-56)},Enum.EasingStyle.Back)
	tw(tsP,2.6,{Size=UDim2.new(0,0,0,2)},Enum.EasingStyle.Linear)
	task.delay(2.6,function() if me==tk then tw(ts,.35,{Position=UDim2.new(1,10,1,-56)}) end end)
end
-- tabs
local pages,sfs,tbn,tbl,tcur,first={}, {}, {}, {}, "",nil
local tbar=new("ScrollingFrame",{Size=UDim2.new(1,-16,0,28),Position=UDim2.fromOffset(8,42),BackgroundTransparency=1,ScrollBarThickness=0,CanvasSize=UDim2.new(),ScrollingDirection=Enum.ScrollingDirection.X},main)
local pill=new("Frame",{Size=UDim2.fromOffset(60,26),Position=UDim2.fromOffset(0,1),BackgroundColor3=T.AC},tbar) rd(pill,13)
function Th.relayout()
	local x=0
	for _,n in ipairs(tbl) do
		local t=tbn[n] local w=TXS:GetTextSize(n:upper(),9,T.HF,Vector2.new(400,26)).X+24
		t[2],t[3]=x,w t[1].Position=UDim2.fromOffset(x,1) t[1].Size=UDim2.fromOffset(w,26) x=x+w+4
	end
	tbar.CanvasSize=UDim2.fromOffset(x,0)
	if tbn[tcur] then pill.Position=UDim2.fromOffset(tbn[tcur][2],1) pill.Size=UDim2.fromOffset(tbn[tcur][3],26) end
end
function X.stag(sf)
	local n=0
	for _,c in ipairs(sf:GetChildren()) do
		if c:IsA("GuiObject") then
			n=n+1 if n>14 then break end
			local dl=(n-1)*.035
			local list={c} for _,x in ipairs(c:GetDescendants()) do list[#list+1]=x end
			for _,o in ipairs(list) do
				local goal={}
				if o:IsA("GuiObject") and o.BackgroundTransparency<1 then goal.BackgroundTransparency=o.BackgroundTransparency end
				if (o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox")) and o.TextTransparency<1 then goal.TextTransparency=o.TextTransparency end
				if o:IsA("ImageLabel") and o.ImageTransparency<1 then goal.ImageTransparency=o.ImageTransparency end
				if o:IsA("UIStroke") then goal.Transparency=o.Transparency end
				if next(goal) then
					for k in pairs(goal) do o[k]=1 end
					task.delay(dl,function() if o.Parent then TS:Create(o,TweenInfo.new(.38,Enum.EasingStyle.Quint),goal):Play() end end)
				end
			end
		end
	end
end
local function show(n)
	tcur=n
	for k,p in pairs(pages) do
		if k==n then p.Visible=true p.GroupTransparency=1 p.Position=UDim2.fromOffset(30,76) tw(p,.32,{GroupTransparency=0,Position=UDim2.fromOffset(8,76)}) X.stag(sfs[k])
		elseif p.Visible then tw(p,.12,{GroupTransparency=1}) task.delay(.13,function() if tcur~=k then p.Visible=false end end) end
	end
	for k,t in pairs(tbn) do tw(t[1],.25,{TextColor3=k==n and T.OA or T.TX}) end
	tw(pill,.38,{Position=UDim2.fromOffset(tbn[n][2],1),Size=UDim2.fromOffset(tbn[n][3],26)},Enum.EasingStyle.Back)
end
local function tab(n)
	first=first or n
	local b=new("TextButton",{Size=UDim2.fromOffset(60,26),Position=UDim2.fromOffset(0,1),Text=n:upper(),Font=T.HF,TextSize=9,BackgroundTransparency=1,ZIndex=2},tbar)
	tbn[n]={b,0,60} tbl[#tbl+1]=n Th.relayout()
	local hd=new("CanvasGroup",{Size=UDim2.new(1,-16,1,-84),Position=UDim2.fromOffset(8,76),BackgroundTransparency=1,Visible=false},main)
	local p=new("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},hd)
	new("UIListLayout",{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},p)
	pages[n]=hd sfs[n]=p b.Activated:Connect(function() show(n) end) return p
end
-- widgets
local function row(pg,h)
	local f=new("Frame",{Size=UDim2.new(1,-6,0,h or 34)},pg) rd(f)
	local s=new("UIStroke",{Color=T.TX,Transparency=.93},f)
	f.MouseEnter:Connect(function() tw(s,.2,{Transparency=.55}) end)
	f.MouseLeave:Connect(function() tw(s,.25,{Transparency=.93}) end)
	return f
end
local function lbl(r,t,d,w)
	w=w or .72
	local l=new("TextLabel",{Size=d and UDim2.new(w,0,0,18) or UDim2.new(w,0,1,0),Position=UDim2.fromOffset(12,d and 5 or 0),Text=t,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},r)
	if d then new("TextLabel",{Size=UDim2.new(.78,0,0,12),Position=UDim2.fromOffset(12,23),Text=d,TextSize=9,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},r) end
	return l
end
local function sec(pg,t) new("TextLabel",{Size=UDim2.new(1,-6,0,20),Position=UDim2.fromOffset(4,0),Text=t,Font=T.HF,TextSize=9,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left},pg) end
local function note(pg,t,h) return new("TextLabel",{Size=UDim2.new(1,-6,0,h or 30),Text=t,TextSize=10,TextColor3=T.DIM,TextWrapped=true},pg) end
local function btn(pg,t,d,fn)
	local b=new("TextButton",{Size=UDim2.new(1,-6,0,d and 42 or 30),Text=t,TextSize=12,BackgroundColor3=T.RB},pg) rd(b,8) press(b)
	if d then
		b.TextYAlignment=Enum.TextYAlignment.Top
		new("UIPadding",{PaddingTop=UDim.new(0,7)},b)
		new("TextLabel",{Size=UDim2.new(1,-16,0,12),Position=UDim2.new(0,8,1,-18),Text=d,TextSize=9,TextColor3=T.DIM,TextTruncate=Enum.TextTruncate.AtEnd},b)
	end
	b.Activated:Connect(function() fn(b) end) return b
end
local function tog(pg,t,k,d,fn)
	local r=row(pg,d and 44 or 34) lbl(r,t,d)
	local b=new("TextButton",{Size=UDim2.fromOffset(38,20),Position=UDim2.new(1,-46,.5,-10),Text="",AutoButtonColor=false},r) rd(b,99)
	local kn=new("Frame",{Size=UDim2.fromOffset(14,14),Position=UDim2.fromOffset(3,3)},b) rd(kn,99)
	local function pn(a)
		local on=F[k] local c,kc,p=on and T.AC or T.OF,on and T.OA or T.TX,on and UDim2.fromOffset(21,3) or UDim2.fromOffset(3,3)
		if a then
			tw(b,.2,{BackgroundColor3=c}) tw(kn,.1,{Size=UDim2.fromOffset(20,14)})
			tw(kn,.3,{BackgroundColor3=kc,Position=p},Enum.EasingStyle.Back)
			task.delay(.1,function() tw(kn,.25,{Size=UDim2.fromOffset(14,14)},Enum.EasingStyle.Back) end)
		else b.BackgroundColor3=c kn.BackgroundColor3=kc kn.Position=p end
	end
	pn() REP[#REP+1]=function() pn() end
	TG[k]=function(v,q) F[k]=v pn(not q) if fn then fn(v) end end
	b.Activated:Connect(function() TG[k](not F[k]) end)
end
local function sld(pg,t,k,mn,mx,d,fn,stp)
	stp=stp or ((mx-mn)>=5 and 1 or .01)
	local dec=stp>=1 and 0 or (stp>=.1 and 1 or 2)
	local rh=d and 56 or 44
	local r=row(pg,rh) lbl(r,t,d,.6)
	local vl=new("TextLabel",{Size=UDim2.new(.4,-10,0,18),Position=UDim2.new(.6,0,0,5),TextSize=11,TextXAlignment=Enum.TextXAlignment.Right,TextColor3=T.DIM},r)
	local tkk=new("Frame",{Size=UDim2.new(1,-24,0,4),Position=UDim2.fromOffset(12,rh-12),BackgroundColor3=T.TR},r) rd(tkk,99)
	local fl2=new("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=T.AC},tkk) rd(fl2,99)
	local kn=new("Frame",{Size=UDim2.fromOffset(12,12),AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(0,0,.5,0),BackgroundColor3=T.AC},tkk) rd(kn,99)
	local fmt="%."..dec.."f"
	local function s(v)
		v=math.clamp(v,mn,mx)
		v=mn+math.floor((v-mn)/stp+.5)*stp
		v=math.clamp(tonumber(string.format(fmt,v)) or mn,mn,mx)
		F[k]=v
		local f=(v-mn)/(mx-mn) fl2.Size=UDim2.new(f,0,1,0) kn.Position=UDim2.new(f,0,.5,0)
		vl.Text=string.format(fmt,v)
		if fn then fn(v) end
	end
	SL[k]=s s(F[k])
	local dg,sf=false,nil
	local function set(x) s(mn+math.clamp((x-tkk.AbsolutePosition.X)/math.max(tkk.AbsoluteSize.X,1),0,1)*(mx-mn)) end
	r.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true sf=r:FindFirstAncestorWhichIsA("ScrollingFrame") if sf then sf.ScrollingEnabled=false end set(i.Position.X) end end)
	cn(UIS.InputChanged:Connect(function(i) if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then set(i.Position.X) end end))
	cn(UIS.InputEnded:Connect(function() if dg then dg=false if sf then sf.ScrollingEnabled=true end end end))
end
local function nbox(pg,t,k,d)
	local r=row(pg,d and 44 or 34) lbl(r,t,d)
	local b=new("TextBox",{Size=UDim2.fromOffset(110,24),Position=UDim2.new(1,-118,.5,-12),Text=tostring(F[k]),ClearTextOnFocus=false,TextSize=12,BackgroundColor3=T.RB},r) rd(b,6)
	SL[k]=function(v) F[k]=v b.Text=tostring(v) end
	b.FocusLost:Connect(function() local n=tonumber(b.Text) if n then F[k]=n else b.Text=tostring(F[k]) end end)
end
local function tbox(pg,ph,bt,fn)
	local r=row(pg,38)
	local b=new("TextBox",{Size=UDim2.new(1,-110,0,26),Position=UDim2.fromOffset(8,6),Text="",PlaceholderText=ph,ClearTextOnFocus=false,TextSize=12,BackgroundColor3=T.RB},r) rd(b,6)
	local a=new("TextButton",{Size=UDim2.fromOffset(88,26),Position=UDim2.new(1,-96,0,6),Text=bt,TextSize=11,BackgroundColor3=T.RB},r) rd(a,6) press(a)
	a.Activated:Connect(function() local n=b.Text:match("^%s*(.-)%s*$") if n~="" then fn(n) b.Text="" end end)
end
local function chips(pg,title,set,list,neg)
	local r=new("Frame",{Size=UDim2.new(1,-6,0,0),AutomaticSize=Enum.AutomaticSize.Y},pg) rd(r)
	new("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6),PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6)},r)
	new("UIListLayout",{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},r)
	new("TextLabel",{Size=UDim2.new(1,0,0,16),Text=title,TextSize=10,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left},r)
	local g=new("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1},r)
	new("UIGridLayout",{CellSize=UDim2.new(.5,-3,0,24),CellPadding=UDim2.fromOffset(5,5),SortOrder=Enum.SortOrder.LayoutOrder},g)
	local bs={}
	local function paint(n)
		local on=set[n] bs[n].Text=(neg and on) and ("[X] "..n) or n
		tw(bs[n],.2,{BackgroundColor3=on and (neg and rgb(100,28,28) or T.AC) or T.RB,TextColor3=(on and not neg) and T.OA or T.TX})
	end
	local function add(n)
		if bs[n] then return end
		bs[n]=new("TextButton",{Text=n,TextSize=11,BackgroundColor3=T.RB,TextTruncate=Enum.TextTruncate.AtEnd},g) rd(bs[n],6) press(bs[n])
		bs[n].Activated:Connect(function() set[n]=not set[n] or nil paint(n) end)
	end
	for _,n in ipairs(list) do add(n) end
	local function rp() for n in pairs(bs) do paint(n) end end
	REP[#REP+1]=rp
	return add,rp
end
function X.opts(pg,title,list,get,set)
	local r=new("Frame",{Size=UDim2.new(1,-6,0,0),AutomaticSize=Enum.AutomaticSize.Y},pg) rd(r)
	new("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6),PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6)},r)
	new("UIListLayout",{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},r)
	new("TextLabel",{Size=UDim2.new(1,0,0,16),Text=title,TextSize=10,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left},r)
	local g=new("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1},r)
	new("UIGridLayout",{CellSize=UDim2.new(.5,-3,0,24),CellPadding=UDim2.fromOffset(5,5),SortOrder=Enum.SortOrder.LayoutOrder},g)
	local bs={}
	local function paint() for n,b in pairs(bs) do local on=get()==n tw(b,.2,{BackgroundColor3=on and T.AC or T.RB,TextColor3=on and T.OA or T.TX}) end end
	for _,n in ipairs(list) do
		bs[n]=new("TextButton",{Text=n,TextSize=11,BackgroundColor3=T.RB,TextTruncate=Enum.TextTruncate.AtEnd},g) rd(bs[n],6) press(bs[n])
		bs[n].Activated:Connect(function() set(n) paint() end)
	end
	paint() REP[#REP+1]=paint
end
-- shared helpers
local function alive(p) local c=p.Character local h=c and c:FindFirstChildOfClass("Humanoid") return h~=nil and h.Health>0 and c:FindFirstChild("HumanoidRootPart")~=nil end
local function w2(v) local o=workspace.CurrentCamera:WorldToViewportPoint(v) return Vector2.new(o.X,o.Y),o.Z end
local function ln(f,p1,p2) local d=p2-p1 f.Position=UDim2.fromOffset((p1.X+p2.X)/2,(p1.Y+p2.Y)/2) f.Size=UDim2.fromOffset(d.Magnitude,1.5) f.Rotation=math.deg(math.atan2(d.Y,d.X)) f.Visible=true end
local function mkf() return new("Frame",{AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=WH,Visible=false,ZIndex=2},EL) end
-- spectate + player list with avatars
X.specP=nil
function X.spec(p)
	X.specP=p
	local cm=workspace.CurrentCamera
	if p then
		local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
		if h then cm.CameraSubject=h toast("Viewing "..p.DisplayName) end
	else local h=hum() if h then cm.CameraSubject=h end end
end
local function plist(pg,fn)
	local box=new("Frame",{Size=UDim2.new(1,-6,0,220)},pg) rd(box)
	local sb=new("TextBox",{Size=UDim2.new(1,-104,0,24),Position=UDim2.fromOffset(6,6),Text="",PlaceholderText="Search players...",ClearTextOnFocus=false,TextSize=11,BackgroundColor3=T.RB,TextXAlignment=Enum.TextXAlignment.Left},box) rd(sb,6)
	new("UIPadding",{PaddingLeft=UDim.new(0,8)},sb)
	local sv=new("TextButton",{Size=UDim2.fromOffset(88,24),Position=UDim2.new(1,-94,0,6),Text="Stop Viewing",TextSize=10,BackgroundColor3=T.RB},box) rd(sv,6) press(sv)
	sv.Activated:Connect(function() X.spec(nil) end)
	local sc=new("ScrollingFrame",{Size=UDim2.new(1,-8,1,-38),Position=UDim2.fromOffset(4,34),BackgroundTransparency=1,ScrollBarThickness=3,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y},box)
	new("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.Name},sc)
	local bs={}
	local function add(p)
		if p==LP or bs[p] then return end
		local f=new("Frame",{Size=UDim2.new(1,-6,0,40),Name=p.Name:lower()},sc) rd(f,8)
		f:SetAttribute("dn",p.DisplayName:lower())
		local im=new("ImageLabel",{Size=UDim2.fromOffset(32,32),Position=UDim2.fromOffset(6,4),BackgroundColor3=T.RB,Image=AV(p.UserId)},f) rd(im,99)
		new("TextLabel",{Size=UDim2.new(1,-152,0,16),Position=UDim2.fromOffset(46,4),Text=p.DisplayName,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
		local sub=new("TextLabel",{Size=UDim2.new(1,-152,0,12),Position=UDim2.fromOffset(46,22),Text="@"..p.Name,TextSize=9,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},f)
		local tpb=new("TextButton",{Size=UDim2.fromOffset(36,24),Position=UDim2.new(1,-92,.5,-12),Text="TP",TextSize=11,BackgroundColor3=T.RB},f) rd(tpb,6) press(tpb)
		tpb.Activated:Connect(function() fn(p) toast("Teleported to "..p.DisplayName) end)
		local vb=new("TextButton",{Size=UDim2.fromOffset(48,24),Position=UDim2.new(1,-52,.5,-12),Text="VIEW",TextSize=11,BackgroundColor3=T.RB},f) rd(vb,6) press(vb)
		vb.Activated:Connect(function() X.spec(p) end)
		bs[p]={f=f,sub=sub}
	end
	for _,p in ipairs(P:GetPlayers()) do add(p) end
	cn(P.PlayerAdded:Connect(add))
	cn(P.PlayerRemoving:Connect(function(p) if bs[p] then bs[p].f:Destroy() bs[p]=nil end if X.specP==p then X.spec(nil) end end))
	sb:GetPropertyChangedSignal("Text"):Connect(function()
		local q=sb.Text:lower()
		for _,v in pairs(bs) do v.f.Visible=(q=="") or (v.f.Name:find(q,1,true)~=nil) or ((v.f:GetAttribute("dn") or ""):find(q,1,true)~=nil) end
	end)
	task.spawn(function()
		while gui.Parent do
			task.wait(.7)
			local r=root()
			for p,v in pairs(bs) do
				local c=p.Character local h=c and c:FindFirstChildOfClass("Humanoid") local rt=c and c:FindFirstChild("HumanoidRootPart")
				v.sub.Text="@"..p.Name..((h and rt and r) and ("  •  "..math.floor((rt.Position-r.Position).Magnitude).."m  •  "..math.floor(h.Health).." HP") or "")
			end
		end
	end)
end
-- locked target card (avatar of who the aimbot is on)
function X.lockCard(pg)
	local r=row(pg,44)
	local im=new("ImageLabel",{Size=UDim2.fromOffset(32,32),Position=UDim2.fromOffset(8,6),BackgroundColor3=T.RB,Image=""},r) rd(im,99)
	local l1=new("TextLabel",{Size=UDim2.new(1,-56,0,18),Position=UDim2.fromOffset(48,5),Text="No lock",TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},r)
	local l2=new("TextLabel",{Size=UDim2.new(1,-56,0,12),Position=UDim2.fromOffset(48,24),Text="Your aimbot target shows here",TextSize=9,TextColor3=T.DIM,TextXAlignment=Enum.TextXAlignment.Left},r)
	local cur
	X.setLock=function(p)
		if p==cur then return end cur=p
		if p then im.Image=AV(p.UserId) l1.Text=p.DisplayName l2.Text="@"..p.Name.."  •  locked on"
		else im.Image="" l1.Text="No lock" l2.Text="Your aimbot target shows here" end
	end
end
-- world labels + watchers (eggs, MM2, Blox Fruits, Doors, Flee)
X.OV={} X.RH={} X.g0=workspace.Gravity
function X.dot(k,pos,txt,tr,col)
	local d=X.OV[k]
	if not d then d={tx=new("TextLabel",{AnchorPoint=Vector2.new(.5,1),Size=UDim2.fromOffset(220,28),TextSize=11,TextStrokeTransparency=.4,TextColor3=WH,Visible=false,ZIndex=2},EL),ln=mkf()} X.OV[k]=d end
	local cm=workspace.CurrentCamera local v=cm:WorldToViewportPoint(pos)
	d.tx.Visible=v.Z>0 and txt~=nil d.ln.Visible=false
	if v.Z<=0 then return end
	if col then d.tx.TextColor3=col d.ln.BackgroundColor3=col end
	if txt then d.tx.Text=txt d.tx.Position=UDim2.fromOffset(v.X,v.Y) end
	if tr then ln(d.ln,Vector2.new(cm.ViewportSize.X/2,cm.ViewportSize.Y),Vector2.new(v.X,v.Y)) end
end
function X.hdot(k) local d=X.OV[k] if d then d.tx.Visible=false d.ln.Visible=false end end
cn(workspace.DescendantRemoving:Connect(function(o) local d=X.OV[o] if d then d.tx:Destroy() d.ln:Destroy() X.OV[o]=nil end end))
function X.watch(pred)
	local set={}
	local function reg(o) if not set[o] then local o2,r=pcall(pred,o) if o2 and r then set[o]=true end end end
	task.spawn(function() for i,o in ipairs(workspace:GetDescendants()) do reg(o) if i%400==0 then task.wait() end end end)
	cn(workspace.DescendantAdded:Connect(reg))
	cn(workspace.DescendantRemoving:Connect(function(o) set[o]=nil end))
	return set
end
function X.opos(o)
	if o:IsA("BasePart") then return o.Position
	elseif o:IsA("Model") then local o2,cf=pcall(o.GetPivot,o) return o2 and cf.Position or nil
	elseif o:IsA("Attachment") then return o.WorldPosition
	elseif o:IsA("ProximityPrompt") then local p=o.Parent if p then return X.opos(p) end
	elseif o:IsA("Tool") then local h=o:FindFirstChild("Handle") return h and h.Position end
end
function X.near(set)
	local r=root() if not r then return end
	local best,bd
	for o in pairs(set) do local p=o.Parent and X.opos(o) if p then local d=(p-r.Position).Magnitude if not bd or d<bd then best,bd=o,d end end end
	return best,bd
end
function X.tp(pos) local r=root() if r and pos then r.CFrame=CFrame.new(pos+Vector3.new(0,3,0)) end end
function X.pass(set,on,col,label)
	local r=root()
	for o in pairs(set) do
		local p=o.Parent and X.opos(o)
		if p and on and r then
			local d=(p-r.Position).Magnitude
			if d<=F.edist then X.dot(o,p,label..": "..o.Name.."\n"..math.floor(d).."m",false,col) else X.hdot(o) end
		else X.hdot(o) end
	end
end
-- state
local EG,BL,SE,SR,BK,KW,SAr={}, {}, {}, {}, {}, {}, {}
local tgt,mode,atE,base,got,t0=nil,"go",false,nil,0,tick()
local pick,scan,ppos,rar,grab,reg,match,eStep=nop,nop,nop,nop,nop,nop,nop,nop
local addE,rpE,addR,rpR,addB,rpB,addA,rpA=nop,nop,nop,nop,nop,nop,nop,nop
local lock,stl,fp,GST=nil,nil,nil,nop
local tn,ti,tpn={"Head","Chest","Legs","Root"},1,"Head"
local TT={Head={"Head"},Chest={"UpperTorso","Torso"},Legs={"LowerTorso","Left Leg"},Root={"HumanoidRootPart"}}
local isE,isM=(choice=="pet" or choice=="egg"),choice=="ml"
local isF=(choice=="riv" or choice=="ars" or choice=="pf" or choice=="cb")
local runMode=choice=="egg"
if isE then PG.e,PG.b,PG.x=tab("Egg"),tab("Blacklist"),tab("ESP")
elseif isF then PG.a,PG.x,PG.t=tab("Aimbot"),tab("ESP"),tab("Players")
elseif isM then PG.f,PG.c,PG.k,PG.t,PG.x=tab("Farm"),tab("Crystals"),tab("Combat"),tab("Players"),tab("ESP")
elseif choice=="mm2" then PG.g,PG.x,PG.t=tab("Game"),tab("ESP"),tab("Players")
elseif choice=="bf" then PG.g,PG.x,PG.t=tab("Fruits"),tab("ESP"),tab("Players")
elseif choice=="doors" then PG.g=tab("Doors")
elseif choice=="ball" then PG.g=tab("Blade Ball")
elseif choice=="nds" then PG.g=tab("Survival")
elseif choice=="flee" then PG.g,PG.x,PG.t=tab("Facility"),tab("ESP"),tab("Players")
elseif choice=="brk" or choice=="prl" then PG.t,PG.x=tab("Players"),tab("ESP")
else PG.a,PG.x,PG.t=tab("Aimbot"),tab("ESP"),tab("Players") end
PG.p,PG.m,PG.s=tab("Player"),tab("Misc"),tab("Settings")
local cx={}
for i,s in ipairs({{14,2},{2,14}}) do cx[i]=new("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,0),Size=UDim2.fromOffset(s[1],s[2]),BackgroundColor3=WH,Visible=false},EL) end
cx[3]=new("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,0),BackgroundTransparency=1,Visible=false},EL) rd(cx[3],999) new("UIStroke",{Color=WH,Transparency=.5},cx[3])
local fl=new("TextLabel",{Size=UDim2.fromOffset(150,24),Position=UDim2.new(.5,-75,0,8),Text="FPS",BackgroundColor3=T.BG,BackgroundTransparency=.2,Visible=false,Active=true},gui) rd(fl,6) drag(fl,fl)
local function aimUI(pg,rv)
	sec(pg,"AIMBOT")
	tog(pg,"Aimbot","aim","Snaps your camera onto the closest player in the FOV",function() lock=nil end)
	tog(pg,"Sticky Lock","sticky","Keeps tracking the same player until they die")
	tog(pg,"Team Check","team","Ignores your teammates")
	tog(pg,"Wall Check","wall","Only locks players you can actually see")
	if rv then tog(pg,"Face Target (Shiftlock)","face","Turns your character toward the locked player") end
	tog(pg,"Crosshair + FOV Circle","cross","Draws a crosshair and the aim area",function(x) for _,f in ipairs(cx) do f.Visible=x end end)
	sld(pg,"Prediction","pred",0,1,"Leads moving targets (higher = further ahead)")
	sld(pg,"Aim FOV","afov",50,600,"Size of the area the aimbot searches")
	sld(pg,"Smoothing","smooth",0,1,"Higher = slower, more natural looking aim")
	btn(pg,"Target Part: Head","Tap to cycle Head / Chest / Legs / Root",function(b) ti=ti%4+1 tpn=tn[ti] b.Text="Target Part: "..tpn end)
	btn(pg,"Release Lock","Drops your current target",function() lock=nil end)
	sec(pg,"TRIGGERBOT")
	tog(pg,"Triggerbot","trig","Auto shoots when your crosshair is on a player")
	sld(pg,"Trigger Delay","tdel",0,.5,"Wait before each auto shot (seconds)")
	X.lockCard(pg)
end
local function espUI(pg)
	sec(pg,"PLAYER ESP")
	tog(pg,"Name / Distance / HP","pesp","Shows name, distance and health over players")
	tog(pg,"Box","pbox","Draws a box around each player")
	tog(pg,"Health Bar","phb","Green to red bar next to the box")
	tog(pg,"Tracers","ptr","Lines from the screen bottom to players")
	tog(pg,"Chams","chams","Glowing outline you can see through walls")
	sld(pg,"Max Distance","edist",100,3000,"ESP hides players farther than this")
end
-- ===== EGG GAMES (Ride a Pet / Steal an Egg) =====
if isE then
	local eP,bP,xP=PG.e,PG.b,PG.x
	local dot,hdot=X.dot,X.hdot
	local RN={C="Common",U="Uncommon",R="Rare",E="Epic",L="Legendary",M="Mythic",K="Cosmic",S="Secret",T="Eternal",D="Divine"}
	local SAD={
		Forest="Chicken:C,Dog:C,Bird:U,Burrowing Owl:R,Raccoon:R,Fox:E,Bear:E,Brr Brr Patapim:L",
		Lake="Frog:C,Duckling:C,Catfish:U,Turtle:R,Trulimero Trulicina:E,Swan:E,Axolotl:L,Leviathan:K",
		Desert="Jerboa:C,Fennec:U,Camel:R,Tob Tobi Tob Tob:E,Snake:L,Sand Spider:M,Scorpion:M,Royal Sphinx:K",
		Jungle="Chimpanzee:R,Toucan:R,Crocodile:E,Gorilla:L,Orangutini Ananassini:L,Spider:M,Tiger:M,King Snake:S",
		Snow="Penguin:R,Walrus:E,Polar Bear:L,Sabertooth Tiger:M,Mammoth:M,King Mammoth:K,Yeti:S,Ice Dragon:T",
		Volcano="Lava Gecko:R,Lava Frog:E,Flaming Bull:L,Lava Iguana:L,Chillin Chilli:M,Cerberus:S,Phoenix:T,Lava Dragon:T",
		["Abyss Ocean"]="Parrotfish:R,Swordfish:E,Shark:L,Orca:M,Whale Shark:K,Beluga Whale:K,Kraken:S,El Maja:T",
		Prehistoric="Dodo:R,Pterodactyl:L,Ankylosaurus:M,Triceratops:K,Bronto:K,T-Rex:S,Tralaledon:S,Mosasaurus:T",
		Cosmic="Centipede:E,Cosmic Gecko:L,Cosmic Gorilla:M,La Vacca Saturno Saturnita:K,Cosmic Skeleton Boss:S,Cosmic Dragon:S,Eternal Lunar Dragon:T,Unicorn:D",
		["Cherry Blossom"]="Crane:E,Salamander:L,Red Panda:M,Snowy Owl:K,Koi:K,Stag:S,Oni Tiger:T,Kitsune:D",
		["Titan Temple"]="Spideron:L,Crustacia:L,Bladehide:K,Mantaris:K,Rhinotaur:K,Mutant Shark:S,Gorilla King:T,Nightflame:D",
		["Angels & Demons"]="Light Dove:L,Winged Lamb:M,Sacred Moth:K,Holy Peacock:K,Pure Jellyfish:S,Centaur:S,Pegasus:T,ArchAngel:D,Flame Sprite:L,Toro:M,Imp:K,Demon Hound:K,Gargoyle:S,RazorFang:S,Skeleton Horse:T,World Burner:D"}
	local AREAS={"Forest","Lake","Desert","Jungle","Snow","Volcano","Abyss Ocean","Prehistoric","Cosmic","Cherry Blossom","Titan Temple","Angels & Demons"}
	local DB={}
	local function norm(s) return (s:lower():gsub("[^%w]","")) end
	if runMode then for b,s in pairs(SAD) do for nm,rc in s:gmatch("([^,:]+):(%a)") do DB[norm(nm.."egg")]={b,RN[rc]} end end end
	local RL=runMode and {"Common","Uncommon","Rare","Epic","Legendary","Mythic","Cosmic","Secret","Eternal","Divine","Unknown"} or {"Common","Uncommon","Rare","Epic","Legendary","Mythical","Secret","Event","Unknown"}
	local RS2={"Secret","Mythical","Legendary","Epic","Rare","Uncommon","Common"}
	sec(eP,runMode and "AUTOFARM" or "AUTO FARM")
	tog(eP,runMode and "Autofarm Eggs" or "Auto Fly To Eggs","auto",runMode and "Runs to the nearest egg, grabs it, runs home" or "Flies to the nearest egg with built-in noclip",function(v)
		tgt=nil mode="go" atE=false
		if v and not base then local r=root() if r then base=r.Position end end
		if not v and runMode then local h=hum() if h then h.WalkSpeed=16 end end
	end)
	if runMode then
		sld(eP,"Run Speed (to egg)","runS",16,200,"Walk speed while heading to an egg")
		sld(eP,"Run Speed (back to base)","runB",16,200,"Walk speed while returning home")
	else
		sld(eP,"Fly Speed (to egg)","spd",20,500,"How fast you fly toward eggs")
		sld(eP,"Return Speed (to base)","rspd",100,1500,"How fast you fly back home")
	end
	sld(eP,"Stay At Egg (sec)","stay",.3,3,"How long to wait at the egg to grab it",nil,.1)
	if not runMode then sld(eP,"Cruise Height","cruise",0,150,"Height you fly at while traveling") end
	sld(eP,"Ignore Eggs Near Base","bsafe",0,300,"Skips eggs this many studs from your base")
	sec(eP,"BASE")
	tog(eP,"Return To Base After Each Egg","back","Goes home after grabbing an egg")
	if not runMode then tog(eP,"Teleport Back (instant)","tpb","Teleports home instead of flying") end
	btn(eP,"Set Base Here","Saves your current spot as home",function() local r=root() if r then base=r.Position toast("Base saved") end end)
	sec(eP,"FILTERS  (none selected = all)")
	addR,rpR=chips(eP,"RARITIES",SR,RL)
	if runMode then addA,rpA=chips(eP,"AREAS (biomes)",SAr,AREAS) end
	addE,rpE=chips(eP,"EGGS",SE,runMode and {} or {"Halloween","Black Hole","Cherub","Rainbow","Gold","Void","Volcanic","Solarius"})
	sec(eP,"TOOLS")
	stl=note(eP,"Eggs found: 0",34)
	btn(eP,"Teleport To Nearest Egg","Instantly moves you next to the closest egg",function() local o,r=pick(),root() if o and r then r.CFrame=CFrame.new(ppos(o)+Vector3.new(0,3,0)) end end)
	btn(eP,"Skip Current Egg","Ignores your current target for 5 minutes",function() if tgt then BL[tgt]=tick()+300 tgt=nil end end)
	btn(eP,"Rescan Eggs","Clears skips and searches the map again",function() BL={} scan() end)
	btn(eP,"Print Eggs To Console","Lists every egg found in the F9 console",function() for o in pairs(EG) do local r,a=rar(o) print("[Zenware]",o:GetFullName(),r,a or "") end end)
	tbox(eP,"extra egg keyword...","Add Keyword",function(n) KW[n]=true scan() toast("Keyword added: "..n) end)
	sec(eP,"ALERTS")
	tog(eP,"Egg Alerts","alert","Pop-up when a new egg that matches appears")
	tog(eP,"Alert Sound","snd","Plays a ping with each alert")
	sec(bP,"NEVER GO TO THESE  (tap to toggle)")
	addB,rpB=chips(bP,"EGG NAMES",BK,runMode and {} or {"Gold","Rainbow","Void","Black Hole","Cherub","Halloween","Volcanic","Solarius"},true)
	tbox(bP,"egg name...","Blacklist",function(n) addB(n) BK[n]=true rpB() tgt=nil toast("Blacklisted: "..n) end)
	btn(bP,"Blacklist Current Target","Never goes to this egg type again",function() if tgt then local n=tgt.Name addB(n) BK[n]=true rpB() BL[tgt]=tick()+600 tgt=nil toast("Blacklisted: "..n) else toast("No target right now") end end)
	btn(bP,"Clear Blacklist","Removes every blacklisted egg",function() for k in pairs(BK) do BK[k]=nil end rpB() toast("Blacklist cleared") end)
	sec(xP,"EGGS")
	tog(xP,"Egg ESP","eesp","Shows name, rarity, area and distance on eggs")
	tog(xP,"Egg Tracers","etr","Draws a line to every egg")
	local NEG={"spawn","shop","stand","machine","incubator","nest","button","stall","pad","hatch"}
	local RC={}
	local function sad(o)
		local best,bl
		local function try(s) for k,v in pairs(DB) do if #k>(bl or 0) and s:find(k,1,true) then best,bl=v,#k end end end
		try(norm(o.Name))
		if not best then for _,d in ipairs(o:GetDescendants()) do if d:IsA("TextLabel") and #d.Text<=30 then try(norm(d.Text)) end end end
		return best
	end
	function ppos(o) if o:IsA("Model") then local ok2,cf=pcall(o.GetPivot,o) return ok2 and cf.Position or nil end return o.Position end
	function rar(o)
		local c=RC[o] if c and tick()-c[2]<2 then return c[1],c[3] end
		local info=runMode and sad(o)
		local r=info and info[2]
		if not r then
			r=o:GetAttribute("Rarity") local v=o:FindFirstChild("Rarity")
			if not r and v and v:IsA("ValueBase") then r=v.Value end
			if not r then
				local txt=o.Name:lower()
				for _,d in ipairs(o:GetDescendants()) do if d:IsA("TextLabel") and #d.Text<=22 then txt=txt.." "..d.Text:lower() end end
				for _,k in ipairs(RS2) do if txt:find(k:lower()) then r=k break end end
				if not r and not runMode then for _,k in ipairs({"halloween","cherub","rainbow","gold","void","black hole"}) do if txt:find(k) then r="Event" break end end end
			end
		end
		r=tostring(r or "Unknown") RC[o]={r,tick(),info and info[1]} return r,info and info[1]
	end
	local function isEgg(o)
		local n=o.Name:lower() local hit=n:find("egg")
		for k in pairs(KW) do if n:find(k:lower(),1,true) then hit=true end end
		if not hit then return false end
		for _,k in ipairs(NEG) do if n:find(k) then return false end end
		if o:IsA("Model") then return true end
		if o:IsA("BasePart") then local m=o.Parent return not (m and m:IsA("Model") and m.Name:lower():find("egg")) end
		return false
	end
	function match(o)
		local n=o.Name:lower()
		for k in pairs(BK) do if n:find(k:lower(),1,true) then return false end end
		if next(SE) then local okk=false for k in pairs(SE) do if n:find(k:lower(),1,true) then okk=true break end end if not okk then return false end end
		if next(SR) and not SR[rar(o)] then return false end
		if next(SAr) then local _,a=rar(o) if not (a and SAr[a]) then return false end end
		return true
	end
	local scanned=false
	function reg(o)
		if EG[o] then return end
		local o2,res=pcall(isEgg,o)
		if o2 and res then
			EG[o]=true addE(o.Name) addB(o.Name) addR((rar(o)))
			if scanned and F.alert and match(o) then
				toast("New egg: "..o.Name)
				if F.snd then local s=Instance.new("Sound") s.SoundId="rbxasset://sounds/electronicpingshort.wav" s.Volume=1 s.Parent=gui s:Play() task.delay(2,function() s:Destroy() end) end
			end
		end
	end
	function scan() scanned=false task.spawn(function() for i,o in ipairs(workspace:GetDescendants()) do reg(o) if i%500==0 then task.wait() end end scanned=true end) end
	function pick()
		local r=root() if not r then return end
		local best,bs
		for o in pairs(EG) do
			local pp=o.Parent and ppos(o)
			if pp and not (LP.Character and o:IsDescendantOf(LP.Character)) and not (BL[o] and BL[o]>tick()) and not (base and F.bsafe>0 and (pp-base).Magnitude<F.bsafe) and match(o) then local d=(pp-r.Position).Magnitude if not bs or d<bs then best,bs=o,d end end
		end
		return best
	end
	function grab(o)
		local r=root()
		local function t(d) if r and firetouchinterest then pcall(function() firetouchinterest(r,d,0) firetouchinterest(r,d,1) end) end end
		for _,d in ipairs(o:GetDescendants()) do
			if d:IsA("ProximityPrompt") then pcall(fireproximityprompt,d) elseif d:IsA("ClickDetector") then pcall(fireclickdetector,d) elseif d:IsA("BasePart") then t(d) end
		end
		if o:IsA("BasePart") then t(o) end
	end
	cn(workspace.DescendantAdded:Connect(reg))
	cn(workspace.DescendantRemoving:Connect(function(o) EG[o]=nil RC[o]=nil end))
	function eStep()
		local r0=root()
		for o in pairs(EG) do
			local pp=o.Parent and ppos(o)
			if pp and (F.eesp or F.etr) then
				local rr,aa=rar(o)
				dot(o,pp,F.eesp and (o.Name.."\n["..rr..(aa and (" | "..aa) or "").."] "..math.floor(r0 and (pp-r0.Position).Magnitude or 0).."m") or nil,F.etr)
			else hdot(o) end
		end
	end
	step(.4,"Scanning eggs") scan()
end
-- ===== MUSCLE LEGENDS =====
if isM then
	local fP,cP,kP=PG.f,PG.c,PG.k
	local RM,RT={}, {}
	local TOOLS={"Weight","Pushups","Situps","Handstands","Punch"}
	local mti=1
	local CRY={"Blue Crystal","Green Crystal","Frost Crystal","Mythical Crystal","Inferno Crystal","Legends Crystal","Muscle Elite Crystal","Galaxy Oracle Crystal","Jungle Crystal","Eclipse Crystal","Infinity Crystal"}
	local cry,ci,costs,gv,gt0,opened,lastRes="Blue Crystal",1,{},nil,0,0,"-"
	local opening=false
	local function rem(names)
		for _,n in ipairs(names) do
			local r=RM[n]
			if r and r.Parent then return r end
			if not RT[n] or tick()-RT[n]>2 then
				RT[n]=tick() r=nil
				for _,rt in ipairs({LP,game:GetService("ReplicatedStorage")}) do
					local x=rt:FindFirstChild(n,true)
					if x and (x:IsA("RemoteEvent") or x:IsA("RemoteFunction")) then r=x break end
				end
				RM[n]=r
				if r then return r end
			end
		end
	end
	local function call(r,...)
		local a={...}
		return pcall(function()
			if r:IsA("RemoteFunction") then return r:InvokeServer(unpack(a)) end
			r:FireServer(unpack(a)) return nil
		end)
	end
	local function fire(names,...)
		local r=rem(names) if not r then return false end
		local a={...}
		task.spawn(function() call(r,unpack(a)) end)
		return true
	end
	local function equip(n)
		local c,h=LP.Character,hum() if not (c and h) then return end
		local t=c:FindFirstChild(n)
		if not t then local bp=LP:FindFirstChildOfClass("Backpack") t=bp and bp:FindFirstChild(n) end
		if t and t:IsA("Tool") and t.Parent~=c then h:EquipTool(t) end
		return t
	end
	local function gems()
		if not (gv and gv.Parent) then gv=nil if tick()-gt0>5 then gt0=tick() for _,d in ipairs(LP:GetDescendants()) do if d.Name=="Gems" and d:IsA("ValueBase") then gv=d break end end end end
		return gv and gv.Value
	end
	local function canOpen() local g=gems() return not g or g>=F.mlmin+(costs[cry] or 0) end
	local function openOne()
		local g0=gems()
		local r=rem({"openCrystalRemote"})
		if not r then lastRes="remote not found" toast("Crystal remote not found") return false end
		local ok2,res=call(r,"openCrystal",cry)
		lastRes=ok2 and (res~=nil and tostring(res) or "sent") or ("error: "..tostring(res))
		task.wait(.35)
		local g1=gems()
		if g0 and g1 then
			if g0>g1 then costs[cry]=g0-g1 opened=opened+1 return true,true end
			return true,false
		end
		opened=opened+1 return true,true
	end
	local function openN(n,auto)
		if opening then toast("Already opening") return end
		opening=true
		task.spawn(function()
			local fails=0
			local i=0
			while opening and i<math.floor(n) do
				i=i+1
				if not canOpen() then toast("Stopped: gem limit") break end
				local ok2,spent=openOne()
				if not ok2 then break end
				if spent==false then fails=fails+1 if fails>=3 then toast("No gems spent. Check crystal name / gems") break end else fails=0 end
				task.wait(F.mlcdel)
			end
			opening=false
			if auto and F.mlcry then TG.mlcry(false) end
		end)
	end
	local frc={}
	local function isFriend(p)
		local v=frc[p]
		if v==nil then frc[p]=false task.spawn(function() local ok2,r=pcall(function() return LP:IsFriendsWith(p.UserId) end) frc[p]=ok2 and r or false end) return false end
		return v
	end
	local function killStep()
		local c,r,h=LP.Character,root(),hum() if not (c and r and h) then return end
		if not F.mlfarm then equip("Punch") end
		local tool=c:FindFirstChild("Punch")
		local hands={c:FindFirstChild("RightHand"),c:FindFirstChild("LeftHand"),c:FindFirstChild("Right Arm"),c:FindFirstChild("Left Arm")}
		local near,nd,hit
		for _,p in ipairs(P:GetPlayers()) do
			if p~=LP and alive(p) and not (F.mlfr and isFriend(p)) then
				local tc=p.Character local tr=tc.HumanoidRootPart
				local d=(tr.Position-r.Position).Magnitude
				if not nd or d<nd then near,nd=tr,d end
				if F.mlkall or d<=F.mlkr then
					hit=true
					if firetouchinterest then
						for _,hd in ipairs(hands) do
							if hd then for _,part in ipairs({tr,tc:FindFirstChild("Head")}) do
								pcall(function() firetouchinterest(hd,part,0) firetouchinterest(hd,part,1) end)
							end end
						end
					end
				end
			end
		end
		if F.mlktp and near and nd>F.mlkr*.6 then r.CFrame=near.CFrame*CFrame.new(0,0,2.5) end
		if hit or F.mlktp then
			if tool then pcall(function() tool:Activate() end) end
			fire({"muscleEvent"},"punch","rightHand") fire({"muscleEvent"},"punch","leftHand")
		end
	end
	sec(fP,"TRAINING")
	tog(fP,"Auto Farm","mlfarm","Trains your selected tool automatically (gets you stronger)")
	btn(fP,"Tool: Weight","Tap to switch which tool you train",function(b) mti=mti%#TOOLS+1 b.Text="Tool: "..TOOLS[mti] end)
	sld(fP,"Reps Per Second","mlrate",1,60,"How fast it trains. Too high can get you kicked")
	tog(fP,"Auto Rebirth","mlreb","Rebirths every few seconds when you have enough strength")
	local fst=note(fP,"Remotes: checking...",34)
	sec(cP,"CRYSTAL")
	btn(cP,"Crystal: Blue Crystal","Tap to cycle which crystal gets opened",function(b) ci=ci%#CRY+1 cry=CRY[ci] b.Text="Crystal: "..cry end)
	tbox(cP,"custom crystal name...","Use Name",function(n) cry=n toast("Crystal: "..n) end)
	local crl=note(cP,"",46)
	sec(cP,"OPENING")
	sld(cP,"Open Amount","mlcnt",1,100,"How many crystals to open at once (whole numbers)")
	sld(cP,"Open Delay (sec)","mlcdel",.1,2,"Wait between each crystal",nil,.1)
	nbox(cP,"Keep At Least (gems)","mlmin","Stops opening before you drop under this many gems")
	btn(cP,"Open Now","Opens the amount set above",function() openN(F.mlcnt) end)
	btn(cP,"Measure Cost (opens 1)","Opens one crystal to learn how many gems it costs",function() openN(1) end)
	tog(cP,"Auto Open Loop","mlcry","Keeps opening until you run out or hit your limit",function(v) if v then openN(math.huge,true) else opening=false end end)
	btn(cP,"Stop Opening","Cancels any opening that is running",function() opening=false end)
	sec(kP,"KILL AURA")
	tog(kP,"Kill Aura","mlka","Punches players near you (kills them)")
	sld(kP,"Kill Aura Range","mlkr",5,100,"How close a player must be to get punched")
	tog(kP,"Kill Everyone (any range)","mlkall","Hits every player in the server, even far away")
	tog(kP,"Teleport To Targets","mlktp","Moves you next to the nearest player so punches land")
	tog(kP,"Ignore Friends","mlfr","Skips players on your friends list")
	note(kP,"Kill aura equips Punch automatically unless Auto Farm is using another tool.",34)
	local rb,ka,ma,sc2=0,0,0,0
	GST=function(dt)
		if F.mlfarm then
			equip(TOOLS[mti])
			ma=math.min(ma+dt*F.mlrate,8)
			local n=math.floor(ma)
			if n>0 then ma=ma-n for _=1,n do fire({"muscleEvent"},"rep") end end
		end
		if F.mlreb then rb=rb+dt if rb>5 then rb=0 fire({"rebirthRemote","rebirthEvent"},"rebirthRequest") end end
		if F.mlka then ka=ka+dt if ka>.1 then ka=0 pcall(killStep) end end
		sc2=sc2+dt
		if sc2>.5 then
			sc2=0
			fst.Text="muscleEvent: "..(rem({"muscleEvent"}) and "found" or "NOT found").." | rebirth: "..(rem({"rebirthRemote","rebirthEvent"}) and "found" or "NOT found")
			crl.Text=string.format("Crystal: %s | Gems: %s\nCost per open: %s | Opened: %d\nLast reply: %s",cry,tostring(gems() or "?"),costs[cry] and (costs[cry].." gems") or "unknown yet",opened,lastRes:sub(1,60))
		end
	end
end
-- ===== AIMBOT GAMES / UNIVERSAL / TELEPORT LISTS =====
if PG.a then aimUI(PG.a,choice=="riv") end
if PG.x and not isE then espUI(PG.x) end
if PG.t then plist(PG.t,function(p) local r,t=root(),p.Character and p.Character:FindFirstChild("HumanoidRootPart") if r and t then r.CFrame=t.CFrame*CFrame.new(0,0,3) end end) end
-- ===== MURDER MYSTERY 2 =====
if choice=="mm2" then
	local g=PG.g
	local CO=X.watch(function(o) if not o:IsA("BasePart") then return false end local n=o.Name:lower() return n:find("coin") and not n:find("container") and true or false end)
	local function role(p)
		local c,b=p.Character,p:FindFirstChildOfClass("Backpack")
		local function has(n) return (c and c:FindFirstChild(n)) or (b and b:FindFirstChild(n)) end
		if has("Knife") then return "Murderer",rgb(255,60,60) elseif has("Gun") then return "Sheriff",rgb(70,140,255) end
		return "Innocent",rgb(70,255,120)
	end
	sec(g,"ROLES")
	tog(g,"Role ESP","mmesp","Red = murderer, blue = sheriff, green = innocent")
	local rl=note(g,"Roles: -",44)
	sec(g,"COINS")
	tog(g,"Auto Collect Coins","mmcoin","Grabs coins near you automatically")
	sld(g,"Collect Range","mmr",20,600,"How far away coins get collected")
	sec(g,"TOOLS")
	btn(g,"Teleport To Dropped Gun","Grabs the sheriff's gun after they die",function() local d=workspace:FindFirstChild("GunDrop",true) local p=d and X.opos(d) if p then X.tp(p) else toast("No gun drop found") end end)
	btn(g,"Teleport To Nearest Coin","Jumps to the closest coin",function() local c=X.near(CO) if c then X.tp(X.opos(c)) else toast("No coins found") end end)
	note(g,"Roles come from who is holding a Knife or Gun. Coins are found by name, so results depend on the map.",44)
	local ra,ca=0,0
	GST=function(dt)
		ra=ra+dt
		if ra>.3 then
			ra=0
			local tx={}
			for _,p in ipairs(P:GetPlayers()) do
				if p~=LP then
					local nm,col=role(p)
					if nm~="Innocent" then tx[#tx+1]=nm..": "..p.DisplayName end
					local c=p.Character
					if F.mmesp and c then
						local hl=X.RH[p] if not hl then hl=Instance.new("Highlight") hl.FillTransparency=.5 hl.Parent=par X.RH[p]=hl end
						hl.Adornee=c hl.FillColor=col hl.OutlineColor=col
					elseif X.RH[p] then X.RH[p].Adornee=nil end
				end
			end
			rl.Text="Roles: "..(#tx>0 and table.concat(tx,"  |  ") or "none yet")
		end
		if F.mmcoin then
			ca=ca+dt
			if ca>.25 then
				ca=0 local r=root()
				if r then
					local n=0
					for o in pairs(CO) do
						if o.Parent and n<6 and (o.Position-r.Position).Magnitude<=F.mmr then
							n=n+1
							if firetouchinterest then pcall(function() firetouchinterest(r,o,0) firetouchinterest(r,o,1) end) else r.CFrame=CFrame.new(o.Position) end
						end
					end
				end
			end
		end
	end
end
-- ===== FLEE THE FACILITY =====
if choice=="flee" then
	local g=PG.g
	local CP=X.watch(function(o) return o:IsA("Model") and o.Name=="ComputerTable" end)
	local PD=X.watch(function(o) return o:IsA("Model") and o.Name=="FreezePod" end)
	local EXs=X.watch(function(o) return o.Name=="ExitDoor" and (o:IsA("Model") or o:IsA("BasePart")) end)
	sec(g,"BEAST")
	tog(g,"Beast ESP","fbeast","Highlights whoever is holding the Hammer in red")
	sec(g,"MAP")
	tog(g,"Computer ESP","fcomp","Shows every computer and how far it is")
	tog(g,"Exit ESP","fexit","Shows the exit doors")
	tog(g,"Freeze Pod ESP","fpod","Shows the freeze pods")
	btn(g,"Teleport To Nearest Computer","Jumps to the closest computer",function() local o=X.near(CP) if o then X.tp(X.opos(o)) else toast("No computers found") end end)
	btn(g,"Teleport To Nearest Exit","Jumps to the closest exit door",function() local o=X.near(EXs) if o then X.tp(X.opos(o)) else toast("No exit found") end end)
	local ba=0
	GST=function(dt)
		X.pass(CP,F.fcomp,rgb(90,200,255),"Computer") X.pass(PD,F.fpod,rgb(190,150,255),"Pod") X.pass(EXs,F.fexit,rgb(90,255,130),"Exit")
		ba=ba+dt
		if ba>.4 then
			ba=0
			for _,p in ipairs(P:GetPlayers()) do
				if p~=LP then
					local c=p.Character
					local beast=c and c:FindFirstChild("Hammer")~=nil
					if F.fbeast and c and beast then
						local hl=X.RH[p] if not hl then hl=Instance.new("Highlight") hl.FillTransparency=.4 hl.Parent=par X.RH[p]=hl end
						hl.Adornee=c hl.FillColor=rgb(255,50,50) hl.OutlineColor=rgb(255,50,50)
					elseif X.RH[p] then X.RH[p].Adornee=nil end
				end
			end
		end
	end
end
-- ===== BLOX FRUITS =====
if choice=="bf" then
	local g=PG.g
	local function inChar(o) local m=o.Parent while m and m~=workspace do if m:FindFirstChildOfClass("Humanoid") then return true end m=m.Parent end return false end
	local FR=X.watch(function(o) return (o:IsA("Tool") or o:IsA("Model")) and o.Name:find("Fruit")~=nil and not inChar(o) end)
	local CH=X.watch(function(o) return (o:IsA("Model") or o:IsA("BasePart")) and o.Name:find("Chest")~=nil and not inChar(o) end)
	sec(g,"FRUITS")
	tog(g,"Fruit ESP","bffesp","Shows spawned fruits and their distance")
	btn(g,"Teleport To Nearest Fruit","Jumps to the closest spawned fruit",function() local o=X.near(FR) if o then X.tp(X.opos(o)) else toast("No fruit found") end end)
	sec(g,"CHESTS")
	tog(g,"Chest ESP","bfcesp","Shows chests and their distance")
	btn(g,"Teleport To Nearest Chest","Jumps to the closest chest",function() local o=X.near(CH) if o then X.tp(X.opos(o)) else toast("No chest found") end end)
	note(g,"Fruit and chest finder only. There is no autofarm here, since I do not know the game's remotes.",44)
	GST=function() X.pass(FR,F.bffesp,rgb(255,190,60),"Fruit") X.pass(CH,F.bfcesp,rgb(90,200,255),"Chest") end
end
-- ===== DOORS =====
if choice=="doors" then
	local g=PG.g
	local PR=X.watch(function(o) return o:IsA("ProximityPrompt") end)
	sec(g,"PROMPTS")
	tog(g,"Prompt ESP","drpesp","Labels items, doors and levers you can interact with")
	sld(g,"ESP Range","drd",20,400,"How far away prompts get labeled")
	tog(g,"Auto Interact","drauto","Grabs nearby items for you (skips hiding spots)")
	sld(g,"Interact Range","drr",4,30,"How close you must be for auto interact")
	sec(g,"ENTITIES")
	tog(g,"Entity Alerts","dral","Warns you when Rush, Ambush, Eyes and others spawn")
	cn(workspace.ChildAdded:Connect(function(c)
		if F.dral then for _,k in ipairs({"Rush","Ambush","Eyes","Halt","Screech","Seek","Figure"}) do if c.Name:find(k) then toast("Entity: "..c.Name) break end end end
	end))
	local ia=0
	GST=function(dt)
		local r=root()
		for pr in pairs(PR) do
			local p=pr.Parent and X.opos(pr)
			if p and r and F.drpesp then
				local d=(p-r.Position).Magnitude
				if d<=F.drd and pr.Enabled then
					local nm=pr.ObjectText~="" and pr.ObjectText or (pr.Parent and pr.Parent.Name or "?")
					X.dot(pr,p,nm.."\n"..(pr.ActionText~="" and (pr.ActionText.." | ") or "")..math.floor(d).."m",false,rgb(255,230,120))
				else X.hdot(pr) end
			else X.hdot(pr) end
		end
		if F.drauto and r then
			ia=ia+dt
			if ia>.3 then
				ia=0
				for pr in pairs(PR) do
					local p=pr.Parent and X.opos(pr)
					if p and pr.Enabled and (p-r.Position).Magnitude<=F.drr and not pr.ActionText:lower():find("hide") then pcall(fireproximityprompt,pr) end
				end
			end
		end
	end
end
-- ===== BLADE BALL =====
if choice=="ball" then
	local g=PG.g
	sec(g,"PARRY")
	tog(g,"Auto Parry","bbp","Presses F right before a ball aimed at you arrives")
	sld(g,"Reaction Time (sec)","bbt",.1,.8,"How early it parries (higher = earlier)",nil,.01)
	tog(g,"Spam Parry","bbs","Mashes F constantly")
	note(g,"Auto parry reads the ball's target attribute and falls back to movement direction.",34)
	local lastP,sp=0,0
	local function pressF()
		pcall(function()
			VIM:SendKeyEvent(true,Enum.KeyCode.F,false,game)
			task.delay(.03,function() pcall(function() VIM:SendKeyEvent(false,Enum.KeyCode.F,false,game) end) end)
		end)
	end
	GST=function(dt)
		if F.bbs then sp=sp+dt if sp>.12 then sp=0 pressF() end end
		local r,balls=root(),workspace:FindFirstChild("Balls")
		if F.bbp and r and balls then
			for _,b in ipairs(balls:GetChildren()) do
				if b:IsA("BasePart") then
					local tg=b:GetAttribute("target")
					local d=r.Position-b.Position
					local v=b.AssemblyLinearVelocity
					local mine=(tg==LP.Name) or (tg==nil and v.Magnitude>1 and d.Magnitude>0 and v:Dot(d.Unit)>v.Magnitude*.6)
					if mine then
						local eta=d.Magnitude/math.max(v.Magnitude,1)
						if eta<=F.bbt and tick()-lastP>.45 then lastP=tick() pressF() end
					end
				end
			end
		end
	end
end
-- ===== NATURAL DISASTER SURVIVAL =====
if choice=="nds" then
	local g=PG.g
	local sky,back2
	sec(g,"SAFE SPOT")
	btn(g,"Teleport To Sky Platform","Builds a safe platform high above the map",function()
		local r=root() if not r then return end
		back2=r.Position
		if not sky then sky=Instance.new("Part") sky.Name="ZSky" sky.Anchored=true sky.Size=Vector3.new(60,2,60) sky.Transparency=.5 sky.Parent=workspace end
		sky.Position=back2+Vector3.new(0,350,0)
		r.CFrame=CFrame.new(sky.Position+Vector3.new(0,4,0))
	end)
	btn(g,"Return To Ground","Takes you back to where you were",function() local r=root() if r and back2 then r.CFrame=CFrame.new(back2+Vector3.new(0,3,0)) end end)
	btn(g,"Remove Platform","Deletes the sky platform",function() if sky then sky:Destroy() sky=nil end end)
	note(g,"The platform is only visible to you. Use it when a disaster starts, then come back down.",44)
	X.cl=function() if sky then sky:Destroy() end end
end
-- ===== PLAYER + MISC =====
if runMode then
	sec(PG.p,"MOVEMENT") note(PG.p,"Fly and Noclip are hidden in this game because it has anticheat. Autofarm runs on foot.",34)
else
	sec(PG.p,"MOVEMENT")
	tog(PG.p,"Fly","fly","WASD / joystick to move, Space up, Ctrl down")
	if not isE then sld(PG.p,"Fly Speed","spd",20,500,"How fast you fly") end
	tog(PG.p,"Noclip","noclip","Walk through walls and objects")
end
tog(PG.p,"Walk Speed","walk","Overrides how fast you run",function(v) if not v then local h=hum() if h then h.WalkSpeed=16 end end end)
sld(PG.p,"Speed Value","walkS",16,250,"The walk speed used when the toggle is on")
if not runMode then
	tog(PG.p,"Jump Power","jp","Overrides how high you jump",function(v) if not v then local h=hum() if h then h.JumpPower=50 end end end)
	sld(PG.p,"Jump Power Value","jpv",50,350,"The jump power used when the toggle is on")
	tog(PG.p,"Gravity","gravOn","Overrides the world's gravity",function(v) if not v then workspace.Gravity=X.g0 end end)
	sld(PG.p,"Gravity Value","grav",0,196,"Lower = floaty, 196 = normal")
	tog(PG.p,"Click Teleport","ctp","Hold Ctrl and click to teleport there")
end
sec(PG.p,"EXTRA")
tog(PG.p,"Infinite Jump","inf","Jump again in mid air as many times as you like")
tog(PG.p,"Anti-AFK","afk","Stops the game from kicking you for idling")
btn(PG.p,"Reset Character","Kills your character so you respawn",function() local h=hum() if h then h.Health=0 end end)
local fbo,fpo
sec(PG.m,"VISUALS")
tog(PG.m,"Fullbright","fb","Removes darkness and fog",function(v)
	if v then fbo={Lt.Brightness,Lt.ClockTime,Lt.FogEnd,Lt.Ambient} Lt.Brightness=2 Lt.ClockTime=14 Lt.FogEnd=1e5 Lt.Ambient=WH
	elseif fbo then Lt.Brightness,Lt.ClockTime,Lt.FogEnd,Lt.Ambient=fbo[1],fbo[2],fbo[3],fbo[4] end
end)
tog(PG.m,"FOV Changer","fovOn","Overrides your camera field of view",function(v) if not v then workspace.CurrentCamera.FieldOfView=70 end end)
sld(PG.m,"FOV Value","fovV",40,120,"Higher = see more of the screen sides")
tog(PG.m,"FPS Booster","fpsb","Lowers shadows and effects for more FPS",function(v)
	if v then
		fpo={sh=Lt.GlobalShadows,fx={}}
		Lt.GlobalShadows=false
		for _,o in ipairs(Lt:GetChildren()) do if o:IsA("PostEffect") and o.Enabled then o.Enabled=false fpo.fx[#fpo.fx+1]=o end end
	elseif fpo then
		Lt.GlobalShadows=fpo.sh
		for _,o in ipairs(fpo.fx) do pcall(function() o.Enabled=true end) end
		fpo=nil
	end
end)
tog(PG.m,"FPS + Ping Counter","fps","Small draggable box with your FPS and ping",function(v) fl.Visible=v end)
sec(PG.m,"UTILITIES")
tog(PG.m,"Instant Prompts","instp","Skips the hold timer on proximity prompts")
cn(game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(pr) if F.instp then pcall(fireproximityprompt,pr) end end))
btn(PG.m,"Copy Place ID","Copies this game's place ID",function() pcall(function() setclipboard(tostring(game.PlaceId)) end) toast("Copied "..game.PlaceId) end)
btn(PG.m,"Copy Job ID","Copies this server's job ID",function() pcall(function() setclipboard(tostring(game.JobId)) end) toast("Copied server ID") end)
sec(PG.m,"SERVER")
tog(PG.m,"Auto Rejoin On Kick","arj","Rejoins the game if you get kicked")
btn(PG.m,"Rejoin Server","Reconnects you to this same server",function() pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,LP) end) end)
btn(PG.m,"Server Hop","Joins a different server",function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end) end)
cn(UIS.InputBegan:Connect(function(i,gpe)
	if gpe or not F.ctp then return end
	if i.UserInputType==Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		local r,m=root(),LP:GetMouse()
		if r and m.Hit then r.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0)) end
	end
end))
-- ===== THEME ENGINE =====
function Th.walk()
	local l={}
	for _,r in ipairs({main,lbx,ts,fl}) do l[#l+1]=r for _,d in ipairs(r:GetDescendants()) do l[#l+1]=d end end
	return l
end
local BGK,TXK={"BG","RW","RB","AC","OF","TR"},{"TX","DIM","OA","AC"}
function Th.rm(o,old)
	if o:IsA("GuiObject") then local v=o.BackgroundColor3 for _,k in ipairs(BGK) do if v==old[k] then o.BackgroundColor3=T[k] break end end end
	if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
		local v=o.TextColor3 for _,k in ipairs(TXK) do if v==old[k] then o.TextColor3=T[k] break end end
	elseif o:IsA("UIStroke") then
		if o.Color==old.TX then o.Color=T.TX elseif o.Color==old.AC then o.Color=T.AC end
	end
end
function Th.save() if Th.sv then return end Th.sv=true task.delay(.5,function() Th.sv=false pcall(writefile,"ZenMenu_Style.json",HS:JSONEncode(ST)) end) end
function Th.apply(name)
	ST.theme=name
	local old=T.cur
	Th.use(name)
	for _,o in ipairs(Th.walk()) do pcall(Th.rm,o,old) end
	Th.rainbow=(name=="Rainbow")
	stg.Color=Th.rainbow and Th.RBSEQ or Th.glow()
	pill.BackgroundColor3=T.AC
	for k,t in pairs(tbn) do t[1].TextColor3=(k==tcur) and T.OA or T.TX end
	for _,f in ipairs(REP) do pcall(f) end
	if not Th.rainbow then for _,o in ipairs(Th.walk()) do local gg=o:FindFirstChild("ZRB") if gg then gg:Destroy() end end end
	Th.save()
end
function Th.setpack(n)
	ST.pack=n
	local oH,oB=T.HF,T.BF
	Th.usepack(n)
	for _,o in ipairs(Th.walk()) do
		if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
			local f=o.Font if f==oH then o.Font=T.HF elseif f==oB then o.Font=T.BF end
		end
	end
	Th.relayout() Th.save()
end
function Th.corner(n)
	ST.corner=n
	for _,o in ipairs(Th.walk()) do if o:IsA("UICorner") then local r=o:GetAttribute("R") if r then o.CornerRadius=UDim.new(0,Th.cr(r)) end end end
	Th.save()
end
Th.rbA=0
function Th.rb(dt)
	if not Th.rainbow then return end
	Th.rbA=Th.rbA+dt if Th.rbA<.07 then return end Th.rbA=0
	local rot=(os.clock()*90)%360
	stg.Rotation=rot
	for _,o in ipairs(Th.walk()) do
		if o:IsA("GuiObject") then
			local gg=o:FindFirstChild("ZRB")
			local want=(o.BackgroundTransparency<.99 and o.BackgroundColor3==T.AC) or (o.Name=="ZTitle")
			if want then
				if not gg then gg=Instance.new("UIGradient") gg.Name="ZRB" gg.Color=Th.RBSEQ gg.Parent=o end
				gg.Rotation=rot
			elseif gg then gg:Destroy() end
		end
	end
end
-- ===== CONFIG + SETTINGS =====
local CFGF="Zenware_"..choice..".json"
local function saveC(q)
	local d={SE={},SR={},BK={},KW={},SA={}}
	for k,v in pairs(F) do if (type(v)=="boolean" or type(v)=="number") and not NS[k] then d[k]=v end end
	for k in pairs(SE) do d.SE[#d.SE+1]=k end for k in pairs(SR) do d.SR[#d.SR+1]=k end
	for k in pairs(BK) do d.BK[#d.BK+1]=k end for k in pairs(KW) do d.KW[#d.KW+1]=k end for k in pairs(SAr) do d.SA[#d.SA+1]=k end
	if base then d.base={base.X,base.Y,base.Z} end
	local o=pcall(function() writefile(CFGF,HS:JSONEncode(d)) end) if not q then toast(o and "Saved!" or "Save failed") end
end
local function loadC(q)
	local o,d=pcall(function() return HS:JSONDecode(readfile(CFGF)) end)
	if not o or type(d)~="table" then if not q then toast("No config found") end return false end
	for k in pairs(SE) do SE[k]=nil end for k in pairs(SR) do SR[k]=nil end for k in pairs(BK) do BK[k]=nil end for k in pairs(SAr) do SAr[k]=nil end
	for _,n in ipairs(d.SE or {}) do addE(n) SE[n]=true end for _,n in ipairs(d.SR or {}) do addR(n) SR[n]=true end
	for _,n in ipairs(d.BK or {}) do addB(n) BK[n]=true end for _,n in ipairs(d.KW or {}) do KW[n]=true end for _,n in ipairs(d.SA or {}) do addA(n) SAr[n]=true end
	rpE() rpR() rpB() rpA()
	if type(d.base)=="table" and #d.base==3 then base=Vector3.new(d.base[1],d.base[2],d.base[3]) end
	for k,v in pairs(d) do if not NS[k] then if TG[k] and type(v)=="boolean" then TG[k](v,true) elseif SL[k] and type(v)=="number" then SL[k](v) end end end
	if next(KW) then scan() end
	return true
end
local sP=PG.s
sec(sP,"MENU STYLE")
X.opts(sP,"THEME",Th.names,function() return ST.theme end,function(n) Th.apply(n) end)
sld(sP,"Custom Theme Hue","hue",0,1,"Only used by the Custom theme",function(v) ST.hue=v Th.custom() if X.built and ST.theme=="Custom" then Th.apply("Custom") end end)
X.opts(sP,"FONT",Th.pnames,function() return ST.pack end,function(n) Th.setpack(n) end)
X.opts(sP,"CORNERS",{"Sharp","Soft","Round","Pill"},function() return ST.corner end,function(n) Th.corner(n) end)
sld(sP,"Menu Opacity","opac",.4,1,"How see-through the menu is",function(v) ST.opac=v if X.built then if main.Visible then main.GroupTransparency=1-v end Th.save() end end)
sec(sP,"EFFECTS")
tog(sP,"Background Blur","blur","Blurs the game behind the menu while it is open",function(v) if main.Visible then tw(X.blur,.3,{Size=v and 14 or 0}) end end)
tog(sP,"Floating Particles","part","Soft glowing dots drifting behind the menu",function(v) for _,d in ipairs(X.dots) do d.f.Visible=v end end)
tog(sP,"Welcome Splash","splash","Plays the avatar welcome intro when the menu first opens")
tog(sP,"Animated Glow Border","glow","Slowly spinning light around the menu edge",function(v) if not v then stg.Rotation=0 end end)
sld(sP,"Menu Scale","uiS",.6,1.3,"Makes the whole menu bigger or smaller",function(v) ms.Scale=v end,.05)
sec(sP,"CONFIG  ("..GN..")")
tog(sP,"Auto Save Config","asave","Saves your toggles and sliders every 25 seconds")
local cr2=row(sP,38)
for i,n in ipairs({"Save","Load"}) do local b=new("TextButton",{Size=UDim2.new(.5,-12,0,26),Position=UDim2.new((i-1)*.5,i==1 and 8 or 4,.5,-13),Text=n,TextSize=12,BackgroundColor3=T.RB},cr2) rd(b,6) press(b) b.Activated:Connect(function() if i==1 then saveC() elseif loadC() then toast("Loaded!") end end) end
btn(sP,"Switch Game","Goes back to the ZenMenu game picker",function() G.ZW() task.spawn(function() G.ZMBoot(true) end) end)
btn(sP,"Unload Zenware","Closes the menu and stops every feature",function() G.ZW() end)
note(sP,"RightShift or '-' hides the menu",20)
step(.6,"Loading engine")
-- ===== ENGINE: ESP, AIMBOT, MOVEMENT =====
do
	local PO,HL={}, {}
	local function mkP(p)
		local d={tx=new("TextLabel",{AnchorPoint=Vector2.new(.5,1),Size=UDim2.fromOffset(200,28),TextSize=11,TextStrokeTransparency=.4,TextColor3=WH,Visible=false,ZIndex=2},EL),ln=mkf(),bx=new("Frame",{BackgroundTransparency=1,Visible=false,ZIndex=2},EL),hb=new("Frame",{BackgroundColor3=BLK,Visible=false,ZIndex=2},EL)}
		new("UIStroke",{Color=WH,Thickness=1.5},d.bx)
		d.hf=new("Frame",{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,0),Size=UDim2.new(1,0,1,0),BackgroundColor3=rgb(60,255,90),ZIndex=3},d.hb)
		PO[p]=d return d
	end
	local function hidP(d) d.tx.Visible=false d.ln.Visible=false d.bx.Visible=false d.hb.Visible=false end
	local function pStep()
		local cm,r0=workspace.CurrentCamera,root()
		local any=F.pesp or F.pbox or F.phb or F.ptr
		for _,p in ipairs(P:GetPlayers()) do
			if p~=LP then
				local c=p.Character local hd=c and c:FindFirstChild("Head") local rt=c and c:FindFirstChild("HumanoidRootPart") local h=c and c:FindFirstChildOfClass("Humanoid")
				if F.chams and c then local hl=HL[p] if not hl then hl=Instance.new("Highlight") hl.FillTransparency=.6 hl.Parent=par HL[p]=hl end hl.Adornee=c elseif HL[p] then HL[p].Adornee=nil end
				local d=PO[p] if not d and any then d=mkP(p) end
				if d then
					local far=r0 and rt and (rt.Position-r0.Position).Magnitude>F.edist
					local top,bot,z1,z2
					if any and not far and hd and rt and h and h.Health>0 then top,z1=w2(hd.Position+Vector3.new(0,.8,0)) bot,z2=w2(rt.Position-Vector3.new(0,3,0)) end
					if not z1 or z1<=0 or z2<=0 then hidP(d) else
						local ht=math.abs(bot.Y-top.Y) local wd=ht*.55 local cxp=(top.X+bot.X)/2
						d.bx.Visible=F.pbox d.bx.Position=UDim2.fromOffset(cxp-wd/2,top.Y) d.bx.Size=UDim2.fromOffset(wd,ht)
						d.hb.Visible=F.phb d.hb.Position=UDim2.fromOffset(cxp-wd/2-6,top.Y) d.hb.Size=UDim2.fromOffset(3,ht)
						local f=math.clamp(h.Health/math.max(h.MaxHealth,1),0,1) d.hf.Size=UDim2.new(1,0,f,0) d.hf.BackgroundColor3=Color3.fromHSV(f*.33,1,1)
						d.tx.Visible=F.pesp d.tx.Position=UDim2.fromOffset(cxp,top.Y-2)
						if F.pesp then d.tx.Text=string.format("%s (@%s)\n%dm | %d HP",p.DisplayName,p.Name,math.floor(r0 and (rt.Position-r0.Position).Magnitude or 0),math.floor(h.Health)) end
						if F.ptr then ln(d.ln,Vector2.new(cm.ViewportSize.X/2,cm.ViewportSize.Y),Vector2.new(cxp,bot.Y)) else d.ln.Visible=false end
					end
				end
			end
		end
	end
	local function gpart(c) for _,n in ipairs(TT[tpn]) do local x=c:FindFirstChild(n) if x then return x end end end
	local faceOn=false
	local function setFace(on)
		local h=hum()
		if on then if h then h.AutoRotate=false end faceOn=true
		elseif faceOn then if h then h.AutoRotate=true end faceOn=false end
	end
	local function aimStep()
		local cm=workspace.CurrentCamera
		if not (F.sticky and lock and alive(lock)) then lock=nil end
		if not lock then
			local ctr,bd=cm.ViewportSize/2,F.afov
			for _,p in ipairs(P:GetPlayers()) do
				if p~=LP and alive(p) and not (F.team and p.Team and p.Team==LP.Team) then
					local pt=gpart(p.Character)
					if pt then
						local v,on=cm:WorldToViewportPoint(pt.Position) local d=(Vector2.new(v.X,v.Y)-ctr).Magnitude
						local rp=RaycastParams.new() rp.FilterDescendantsInstances={LP.Character,p.Character}
						if on and d<bd and not (F.wall and workspace:Raycast(cm.CFrame.Position,pt.Position-cm.CFrame.Position,rp)) then bd,lock=d,p end
					end
				end
			end
		end
		if X.setLock then X.setLock(lock) end
		local pt=lock and gpart(lock.Character)
		if pt then
			local pos=pt.Position+pt.AssemblyLinearVelocity*F.pred
			local dv=pos-cm.CFrame.Position
			local up=(dv.Magnitude>0 and math.abs(dv.Unit.Y)>.97) and cm.CFrame.RightVector or Vector3.yAxis
			cm.CFrame=cm.CFrame:Lerp(CFrame.lookAt(cm.CFrame.Position,pos,up),1-F.smooth*.95)
			if choice=="riv" and F.face then
				local r,h=root(),hum()
				if r and h then
					local fd=Vector3.new(pos.X-r.Position.X,0,pos.Z-r.Position.Z)
					if fd.Magnitude>.5 then setFace(true) r.CFrame=CFrame.lookAt(r.Position,r.Position+fd) end
				end
			elseif faceOn then setFace(false) end
		elseif faceOn then setFace(false) end
	end
	local tdt,tlast=0,0
	local function trigStep(dt)
		local cm=workspace.CurrentCamera
		local rp=RaycastParams.new() rp.FilterType=Enum.RaycastFilterType.Exclude rp.FilterDescendantsInstances=LP.Character and {LP.Character} or {}
		local res=workspace:Raycast(cm.CFrame.Position,cm.CFrame.LookVector*1500,rp)
		local m=res and res.Instance and res.Instance:FindFirstAncestorOfClass("Model")
		local pl=m and P:GetPlayerFromCharacter(m)
		if pl and pl~=LP and alive(pl) and not (F.team and pl.Team and pl.Team==LP.Team) then
			tdt=tdt+dt
			if tdt>=F.tdel and tick()-tlast>.08 then
				tlast=tick()
				if mouse1click then pcall(mouse1click) else
					pcall(function() local vs=cm.ViewportSize VIM:SendMouseButtonEvent(vs.X/2,vs.Y/2,0,true,game,0) VIM:SendMouseButtonEvent(vs.X/2,vs.Y/2,0,false,game,0) end)
				end
			end
		else tdt=0 end
	end
	local function hz(a,b) return Vector3.new(a.X-b.X,0,a.Z-b.Z).Magnitude end
	local function stepTo(tp,spd,dt)
		local goal=tp
		if F.cruise>0 and hz(tp,fp)>6 then local ch=tp.Y+F.cruise goal=(fp.Y<ch-2) and Vector3.new(fp.X,ch,fp.Z) or Vector3.new(tp.X,ch,tp.Z) end
		local d=goal-fp
		if d.Magnitude>0 then fp=fp+d.Unit*math.min(spd*dt,d.Magnitude) end
		return (tp-fp).Magnitude<=2.5
	end
	local PFS=game:GetService("PathfindingService")
	local wp,wi,pt0,ptg=nil,2,0,nil
	local function runTo(tp,hh,r)
		local flat=Vector3.new(tp.X-r.Position.X,0,tp.Z-r.Position.Z).Magnitude
		if flat<=4 and math.abs(tp.Y-r.Position.Y)<10 then return true end
		if ptg~=tp or tick()-pt0>2 then
			if ptg~=tp then wp=nil end
			ptg,pt0=tp,tick()
			local from=r.Position
			task.spawn(function()
				local path=PFS:CreatePath({AgentRadius=2,AgentHeight=5,AgentCanJump=true})
				local o2=pcall(function() path:ComputeAsync(from,tp) end)
				if o2 and path.Status==Enum.PathStatus.Success then wp=path:GetWaypoints() wi=2 else wp=nil end
			end)
		end
		local w=wp and wp[wi]
		if w then
			hh:MoveTo(w.Position) if w.Action==Enum.PathWaypointAction.Jump then hh.Jump=true end
			if Vector3.new(w.Position.X-r.Position.X,0,w.Position.Z-r.Position.Z).Magnitude<4 then wi=wi+1 end
		else hh:MoveTo(tp) end
		return false
	end
	local ctl,ctt pcall(function() ctl=require(LP.PlayerScripts.PlayerModule):GetControls() end)
	ctt=0
	local function flyDir(h,cm)
		if not ctl and tick()-ctt>3 then
			ctt=tick()
			pcall(function() ctl=require(LP.PlayerScripts:FindFirstChild("PlayerModule")):GetControls() end)
		end
		local mv=Vector3.zero
		if ctl then local o,v=pcall(ctl.GetMoveVector,ctl) if o and typeof(v)=="Vector3" then mv=v end end
		local typing=UIS:GetFocusedTextBox()~=nil
		if mv.Magnitude<.05 and not typing then
			local kx=(UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0)-(UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0)
			local kz=(UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0)-(UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
			mv=Vector3.new(kx,0,kz)
		end
		if mv.Magnitude<.05 and h then
			local md=h.MoveDirection
			if md.Magnitude>.05 then
				local lk,rv=cm.CFrame.LookVector,cm.CFrame.RightVector
				local fw,fr=Vector3.new(lk.X,0,lk.Z),Vector3.new(rv.X,0,rv.Z)
				if fw.Magnitude>.01 and fr.Magnitude>.01 then fw,fr=fw.Unit,fr.Unit mv=Vector3.new(md:Dot(fr),0,-md:Dot(fw)) end
			end
		end
		local dir=cm.CFrame.LookVector*-mv.Z+cm.CFrame.RightVector*mv.X
		if not typing then
			local up=(UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0)-((UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftShift)) and 1 or 0)
			dir=dir+Vector3.yAxis*up
		end
		if dir.Magnitude>1 then dir=dir.Unit end
		return dir
	end
	local was,ct,gt,sc,fa,ft,tm,av,wsr=false,0,0,0,0,0,0,0,false
	local function arrive(dt)
		if mode=="back" then mode="go" else
			atE=true ct=ct+dt gt=gt+dt
			if gt>.25 then gt=0 grab(tgt) end
			if ct>F.stay then BL[tgt]=tick()+300 tgt=nil atE=false ct=0 if F.back and base then mode="back" end end
		end
	end
	cn(RS.RenderStepped:Connect(function(dt)
		tm=tm+dt fa=fa+1 ft=ft+dt sc=sc+dt av=av+dt
		if F.glow and not Th.rainbow then stg.Rotation=(tm*60)%360 end
		if main.Visible then
			shg.Offset=Vector2.new(((tm*.45)%2)-1,0)
			shine.BackgroundColor3=T.AC:Lerp(WH,.2)
			if F.part then
				local pc=T.AC:Lerp(WH,.3)
				for _,d in ipairs(X.dots) do
					d.y=d.y-d.s*dt if d.y<-.05 then d.y=1.05 d.x=math.random() end
					d.f.Position=UDim2.fromScale(d.x+math.sin(tm*d.w+d.p)*.012,d.y)
					d.f.BackgroundColor3=pc
					d.f.BackgroundTransparency=.8+.12*math.sin(tm*1.5+d.p)
				end
			end
		end
		if ft>=.5 then
			if F.fps then
				local pg=0 pcall(function() pg=LP:GetNetworkPing()*1000 end)
				fl.Text=string.format("%d FPS | %d ms",math.floor(fa/ft+.5),math.floor(pg))
			end
			fa,ft=0,0
		end
		if av>25 then av=0 if F.asave then saveC(true) end end
		pcall(Th.rb,dt)
		local h,r,cm=hum(),root(),workspace.CurrentCamera
		if h and F.walk and not (runMode and F.auto and tgt) then h.WalkSpeed=F.walkS end
		if h and F.jp and not runMode then pcall(function() h.UseJumpPower=true h.JumpPower=F.jpv end) end
		if F.gravOn and not runMode then workspace.Gravity=F.grav end
		if F.fovOn then cm.FieldOfView=F.fovV end
		if X.specP then
			local sh=X.specP.Character and X.specP.Character:FindFirstChildOfClass("Humanoid")
			if sh and cm.CameraSubject~=sh then cm.CameraSubject=sh end
		end
		local tp
		if F.auto then
			local held=tgt and LP.Character and tgt:IsDescendantOf(LP.Character)
			if tgt and (held or not tgt.Parent or not match(tgt)) then
				if (held or atE) and (held or not tgt.Parent) then got=got+1 if F.back and base then mode="back" end end
				tgt=nil atE=false ct=0
			end
			if mode=="back" then tp=base
			else
				if not tgt then tgt=pick() ct=0 atE=false end
				tp=tgt and ppos(tgt)
			end
		end
		if runMode then
			if h and r and tp then
				wsr=true h.WalkSpeed=(mode=="back") and F.runB or F.runS
				if runTo(tp,h,r) then arrive(dt) end
			elseif wsr and h and not F.walk then h.WalkSpeed=16 wsr=false end
		elseif h and r and (F.fly or tp) then
			was=true h.PlatformStand=true
			if not fp or (r.Position-fp).Magnitude>15 then fp=r.Position end
			if tp then
				if mode=="back" and F.tpb then fp=tp end
				if stepTo(tp,mode=="back" and F.rspd or F.spd,dt) then arrive(dt) end
			else
				fp=fp+flyDir(h,cm)*F.spd*dt
			end
			local lk=cm.CFrame.LookVector
			r.AssemblyLinearVelocity=Vector3.zero r.AssemblyAngularVelocity=Vector3.zero
			r.CFrame=CFrame.new(fp)*CFrame.Angles(0,math.atan2(-lk.X,-lk.Z),0)
		else fp=nil if was and h then h.PlatformStand=false was=false end end
		pcall(eStep) pcall(pStep)
		if F.cross then cx[3].Size=UDim2.fromOffset(F.afov*2,F.afov*2) end
		if F.aim then pcall(aimStep) elseif faceOn then pcall(setFace,false) end
		if F.trig then pcall(trigStep,dt) end
		pcall(GST,dt)
		if sc>.3 and stl then
			sc=0 local n=0 for _ in pairs(EG) do n=n+1 end
			local el=tick()-t0
			local tn2="none" if tgt then local rr,aa=rar(tgt) tn2=tgt.Name.." ["..rr..(aa and (" | "..aa) or "").."]" end
			stl.Text=string.format("Eggs found: %d | Collected: %d | %d:%02d\nTarget: %s | Base: %s",n,got,math.floor(el/60),math.floor(el%60),tn2,base and "set" or "not set")
		end
	end))
	cn(RS.Stepped:Connect(function() if (F.noclip or F.fly or (F.auto and not runMode)) and LP.Character then for _,p in ipairs(LP.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end))
	cn(UIS.JumpRequest:Connect(function() if F.inf then local h=hum() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end))
	cn(LP.Idled:Connect(function() if F.afk then pcall(function() local v=game:GetService("VirtualUser") v:CaptureController() v:ClickButton2(Vector2.new()) end) end end))
	cn(game:GetService("GuiService").ErrorMessageChanged:Connect(function() if F.arj then pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end) end end))
	cn(P.PlayerRemoving:Connect(function(p) local d=PO[p] if d then d.tx:Destroy() d.ln:Destroy() d.bx:Destroy() d.hb:Destroy() PO[p]=nil end if HL[p] then HL[p]:Destroy() HL[p]=nil end if X.RH[p] then X.RH[p]:Destroy() X.RH[p]=nil end end))
	G.ZW=function()
		if F.asave then pcall(saveC,true) end
		for _,c in ipairs(C) do pcall(function() c:Disconnect() end) end
		if F.fb then pcall(TG.fb,false,true) end
		if F.fpsb then pcall(TG.fpsb,false,true) end
		for _,d in pairs(HL) do pcall(function() d:Destroy() end) end
		for _,d in pairs(X.RH) do pcall(function() d:Destroy() end) end
		if X.cl then pcall(X.cl) end
		pcall(function() X.blur:Destroy() end)
		pcall(function() workspace.Gravity=X.g0 end)
		pcall(function() workspace.CurrentCamera.FieldOfView=70 local h=hum() if h then workspace.CurrentCamera.CameraSubject=h end end)
		pcall(function() local h=hum() if h then h.PlatformStand=false h.WalkSpeed=16 h.JumpPower=50 h.AutoRotate=true end end)
		gui:Destroy()
	end
end
step(.8,"Loading your config")
local loaded=loadC(true)
for _,d in ipairs(X.dots) do d.f.Visible=F.part end
step(.95,"Starting engine")
X.built=true
show(first)
step(1,"Ready")
endLoad() showM()
if loaded then task.delay(.9,function() toast("Config loaded") end) end
end)
if not ok then
	warn("[Zenware] "..tostring(e))
	-- on error, always leave a visible message AND a Z button so the menu can still be reached
	pcall(function()
		local g=Instance.new("ScreenGui") g.Name="ZenwareError" g.ResetOnSpawn=false g.Parent=gp()
		local l=Instance.new("TextLabel") l.Size=UDim2.new(0,420,0,120) l.Position=UDim2.new(.5,-210,0,40) l.BackgroundColor3=Color3.fromRGB(150,20,20) l.TextColor3=Color3.new(1,1,1) l.TextWrapped=true l.Font=Enum.Font.GothamBold l.TextSize=13 l.Text="ZenMenu error:\n"..tostring(e) l.Parent=g
		task.delay(30,function() g:Destroy() end)
	end)
end
end
G.ZMBoot=boot
boot(false)
