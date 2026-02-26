--[[
------------------------------------------
--_____------------_---------___----------
-|  __ \          | |        |__ \ -------
-| |__) |___   ___| | ___   _   ) |   _ --
-|  _  // _ \ / __| |/ / | | | / / | | |--
-| | \ \ (_) | (__|   <| |_| |/ /| |_| |--
-|_|  \_\___/ \___|_|\_\\__, |____\__,_|--
-------------------------__/ |------------
------------------------|___/-------------
------------------------------------------
------------------REBORN------------------
]]

local ADMINS = {game:GetService("Players").LocalPlayer.UserId}
local BANS = {}
local MOTD = "improve you are security"

function _G.ADD_ADMIN(ID) table.insert(ADMINS, ID) end
function _G.ADD_BAN(ID) table.insert(BANS, ID) end

local VERSION = '1.2.5'
local UPDATED = '2/26/2026'
local CHANGELOG = {        
	    'First update in 5 months',
	    'Changed btools command to have new tool',
	    'Added 2 commands'
}

local CREDITS = [[
 Rocky2u - lol
 java - for making this remaster
 check cashed - fixes + maintenance
 Alex Wang - ;stools and Unfiltered
 All of the people who made the scripts for the cmds
 etc etc
]]

local _CORE = game.CoreGui
local _LIGHTING = game:GetService('Lighting')
local _PLAYERS = game:GetService('Players')

local LP = _PLAYERS.LocalPlayer
local MOUSE = LP:GetMouse()

local SERVER_LOCKED = false
local SHOWING_MESSAGE = false

local SERVICES = {}
SERVICES.EVENTS = {}

local COMMANDS = {}
local STD = {}
local JAILED = {}
local KICKS = {}
local LOOPED_H = {}
local LOOPED_K = {}

local C_PREFIX = ';'
local SPLIT = ' '

function NEW(class, props)
	local i = new(class)
	if not props then return end
	for prop,val in pairs(props) do
		i[prop] = val
	end
end
new=Instance.new

function FIND_IN_TABLE(t, v)
	for i,vv in pairs(t) do
		if v==vv then
			return i
		end
	end
	return nil
end

function UPDATE_CHAT(PLAYER) local C = PLAYER.Chatted:connect(function(M) if CHECK_ADMIN(PLAYER) then DEXECUTE(M, PLAYER) end end) table.insert(SERVICES.EVENTS, C) end
function STD.TABLE(T, V) if not T then return false end for i,v in pairs(T) do if v == V then return true end end return false end
function STD.ENDAT(S, V) local SF = S:find(V) if SF then return S:sub(0, SF - string.len(V)), true else return S, false end end
function CHECK_ADMIN(PLAYER) if FIND_IN_TABLE(ADMINS, PLAYER.userId) then return true elseif PLAYER.userId == LP.userId then return true end end
function FCOMMAND(COMMAND) for i,v in pairs(COMMANDS) do if v.N:lower() == COMMAND:lower() or STD.TABLE(v.A, COMMAND:lower()) then return v end end end
function GCOMMAND(M) local CMD, HS = STD.ENDAT(M:lower(), SPLIT) if HS then return {CMD, true} else return {CMD, false} end end
function GPREFIX(STRING) if STRING:sub(1, string.len(C_PREFIX)) == C_PREFIX then return {'COMMAND', string.len(C_PREFIX) + 1} end return end
function GARGS(STRING) local A = {} local NA = nil local HS = nil local S = STRING repeat NA, HS = STD.ENDAT(S:lower(), SPLIT) if NA ~= '' then table.insert(A, NA) S = S:sub(string.len(NA) + string.len(SPLIT) + 1) end until not HS return A end
function GCAPARGS(STRING) local A = {} local NA = nil local HS = nil local S = STRING repeat NA, HS = STD.ENDAT(S, SPLIT) if NA ~= '' then table.insert(A, NA) S = S:sub(string.len(NA) + string.len(SPLIT) + 1) end until not HS return A end
function ECOMMAND(STRING, SPEAKER) repeat if STRING:find('  ') then STRING = STRING:gsub('  ', ' ') end until not STRING:find('  ') local SCMD, A, CMD SCMD = GCOMMAND(STRING) CMD = FCOMMAND(SCMD[1]) if not CMD then return end A = STRING:sub(string.len(SCMD[1]) + string.len(SPLIT) + 1) local ARGS = GARGS(A) CA = GCAPARGS(A) pcall(function() CMD.F(ARGS, SPEAKER) end) end
function DEXECUTE(STRING, SPEAKER) if not CHECK_ADMIN(SPEAKER) then return end STRING = STRING:gsub('/e ', '') local GP = GPREFIX(STRING) if not GP then return end STRING = STRING:sub(GP[2]) if GP[1] == 'COMMAND' then ECOMMAND(STRING, SPEAKER) end end

function GLS(LOWER, START) local AA = '' for i,v in pairs(CA) do if i > START then if AA ~= '' then AA = AA .. ' ' .. v else AA = AA .. v end end end if not LOWER then return AA else return string.lower(AA) end end
function C3(R, G, B) return Color3.new(R/255, G/255, B/255) end
function GET_MASS(A, B) B = 0 for i,v in pairs(A:GetChildren()) do if v:IsA('BasePart') then B = B + v:GetMass() end GET_MASS(v) end return B end

local STUFF = '[ Rocky2u\'s CMDs Reborn ] : '
local NOCLIP, JESUSFLY, SWIM = false, false, false

_PLAYERS.PlayerAdded:connect(function(PLAYER)
	if SERVER_LOCKED then PLAYER.CharacterAdded:connect(function() table.insert(KICKS, PLAYER) return end) end
	if FIND_IN_TABLE(BANS, PLAYER.userId) then PLAYER.CharacterAdded:connect(function() table.insert(KICKS, PLAYER) return end) end
	UPDATE_CHAT(PLAYER)
	if CHECK_ADMIN(PLAYER) then PLAYER.CharacterAdded:connect(function() game.Chat:Chat(PLAYER.Character.Head, STUFF .. 'Welcome, you\'re an admin!') end) end
end)

game:GetService('RunService').Stepped:connect(function()
	for i,v in pairs(_PLAYERS:GetPlayers()) do
		if FIND_IN_TABLE(KICKS, v) then KICK(v) end
		if FIND_IN_TABLE(LOOPED_H, v.Name) then
			v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
		end
		if FIND_IN_TABLE(LOOPED_K, v.Name) then
			v.Character:BreakJoints()
		end
	end
	if NOCLIP then
		if LP.Character:FindFirstChild('Humanoid') then LP.Character.Humanoid:ChangeState(11) end
	elseif JESUSFLY then
		if LP.Character:FindFirstChild('Humanoid') then LP.Character.Humanoid:ChangeState(12) end
	elseif SWIM then
		if LP.Character:FindFirstChild('Humanoid') then LP.Character.Humanoid:ChangeState(4) end
	end
end)

function ADD_COMMAND(N, D, A, F) table.insert(COMMANDS, {N = N, D = D, A = A, F = F}) end

function GET_PLAYER(NAME, SPEAKER)
	local NAME_TABLE = {}
	NAME = NAME:lower()
	if NAME == 'me' then
		table.insert(NAME_TABLE, SPEAKER.Name)
	elseif NAME == 'others' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v.Name ~= SPEAKER.Name then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'all' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do table.insert(NAME_TABLE, v.Name) end
	elseif NAME == 'random' then
		table.insert(NAME_TABLE, _PLAYERS:GetPlayers()[math.random(1, #_PLAYERS:GetPlayers())].Name)
	elseif NAME == 'team' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v.TeamColor == SPEAKER.TeamColor then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'nonadmins' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if not CHECK_ADMIN(v) then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'admins' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if CHECK_ADMIN(v) then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'nonfriends' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if not v:IsFriendsWith(SPEAKER.userId) then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'friends' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v ~= SPEAKER and v:IsFriendsWith(SPEAKER.userId) then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'nbcs' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v.MembershipType == Enum.MembershipType.None then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'bcs' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v.MembershipType == Enum.MembershipType.BuildersClub then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'tbcs' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v.MembershipType == Enum.MembershipType.TurboBuildersClub then table.insert(NAME_TABLE, v.Name) end end
	elseif NAME == 'obcs' then
		for i,v in pairs(_PLAYERS:GetPlayers()) do if v.MembershipType == Enum.MembershipType.OutrageousBuildersClub then table.insert(NAME_TABLE, v.Name) end end
	else
		for i,v in pairs(_PLAYERS:GetPlayers()) do local L_NAME = v.Name:lower() local F = L_NAME:find(NAME) if F == 1 then table.insert(NAME_TABLE, v.Name) end end
	end
	return NAME_TABLE
end

local SI = 'rbxasset://textures/blackBkg_square.png'

local DATA_LOADED = false
function LOAD_DATA()
	local DATA = new("Folder")
	GUIS = new('Folder', DATA)
	HUMANOIDS = new('Folder', DATA)
	OTHER = new('Folder', DATA)

	MAIN_GUI = new('ScreenGui', GUIS)
	pcall(function() MAIN_GUI.ResetOnSpawn = false end)
	MAIN_GUI.Name = 'seth_main'
	NEW('TextLabel',{Name = 'main', Active = true, BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0.5, -200, 0.4, 0), Size = UDim2.new(0, 400, 0, 25), Draggable = true, Font = 'SourceSansBold', Text = ' Control Center', TextColor3 = C3(255, 255, 255), TextSize = 20, TextXAlignment = 'Left', Parent = MAIN_GUI})
	NEW('Frame',{Name = 'holder', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 25, 12, 0), Parent = MAIN_GUI.main})
	local BUTTONS = new('Folder', MAIN_GUI.main.holder) BUTTONS.Name = 'buttons'
	NEW('TextButton',{Name = 'server', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 5), Size = UDim2.new(0, 100, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'server info', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})
	NEW('TextButton',{Name = 'admins', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 110, 0, 5), Size = UDim2.new(0, 100, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'admins', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})
	NEW('TextButton',{Name = 'bans', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 215, 0, 5), Size = UDim2.new(0, 100, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'bans', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})
	NEW('TextButton',{Name = 'cmds', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 320, 0, 5), Size = UDim2.new(0, 100, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'commands', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})
	NEW('TextButton',{Name = 'fun', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 50, 0, 40), Size = UDim2.new(0, 105, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'fun', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})
	NEW('TextButton',{Name = 'changelog', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 160, 0, 40), Size = UDim2.new(0, 105, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'changelog', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})
	NEW('TextButton',{Name = 'credits', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 270, 0, 40), Size = UDim2.new(0, 105, 0, 30), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'credits', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = BUTTONS})

	local HOLDERS = new('Folder', MAIN_GUI.main.holder) HOLDERS.Name = 'holders'
	NEW('Frame',{Name = 'server', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 85), Size = UDim2.new(1, -10, 0, 210), Parent = HOLDERS})
	NEW('TextLabel',{Name = 'fe', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' FilteringEnabled | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('TextLabel',{Name = 'ip', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 30), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' IP Address | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('TextLabel',{Name = 'port', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 60), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' Port | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('TextLabel',{Name = 'place_id', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 90), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' Place ID | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('TextLabel',{Name = 'players', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 120), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' Players | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('TextLabel',{Name = 'time', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 150), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' Time | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('TextLabel',{Name = 'gravity', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 180), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = ' Gravity | ', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.server})
	NEW('ScrollingFrame',{Name = 'admins', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 85), Size = UDim2.new(1, -10, 0, 210), Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 5, TopImage = SI, MidImage = SI, BottomImage = SI, Parent = HOLDERS})
	NEW('ScrollingFrame',{Name = 'bans', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 85), Size = UDim2.new(1, -10, 0, 210), Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 5, TopImage = SI, MidImage = SI, BottomImage = SI, Parent = HOLDERS})
	NEW('ScrollingFrame',{Name = 'cmds', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 115), Size = UDim2.new(1, -10, 0, 210), Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 5, TopImage = SI, MidImage = SI, BottomImage = SI, Parent = HOLDERS})
	NEW('ScrollingFrame',{Name = 'fun', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 85), Size = UDim2.new(1, -10, 0, 210), Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 5, TopImage = SI, MidImage = SI, BottomImage = SI, Parent = HOLDERS})
	NEW('ScrollingFrame',{Name = 'changelog', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 85), Size = UDim2.new(1, -10, 0, 210), Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 5, TopImage = SI, MidImage = SI, BottomImage = SI, Parent = HOLDERS})
	local Y_CHANGES = 0
	for i,v in pairs(CHANGELOG) do
		NEW('TextLabel',{Name = '', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, Y_CHANGES), Size = UDim2.new(1, 0, 0, 30), Font = 'SourceSansBold', Text = v, TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.changelog})
		HOLDERS.changelog.CanvasSize = HOLDERS.changelog.CanvasSize + UDim2.new(0, 0, 0, 30)
		Y_CHANGES = Y_CHANGES + 30
	end
	NEW('Frame',{Name = 'credits', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 85), Size = UDim2.new(1, -10, 0, 210), Visible = false, Parent = HOLDERS})
	NEW('TextLabel',{Name = 'text', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Font = 'SourceSansBold', Text = CREDITS, TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', TextYAlignment = 'Top', Parent = HOLDERS.credits})
	NEW('TextBox',{Name = 'search', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0.25, 0, 0, 85), Size = UDim2.new(0.5, 0, 0, 25), Visible = false, Font = 'SourceSansBold', Text = 'search commands', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = HOLDERS})

	NEW('Frame',{Name = 'line', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(0, 5, 0, 75), Size = UDim2.new(1, -10, 0, 5), Parent = MAIN_GUI.main.holder})
	NEW('TextButton',{Name = 'close', BackgroundColor3 = C3(255, 50, 50), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 25, 0, 25), Text = '', Parent = MAIN_GUI.main})

	CMD_BAR_H = new('ScreenGui', GUIS)
	CMD_BAR_H.Name = 'cmdbar_seth'
	NEW('TextBox',{Name = 'bar', BackgroundColor3 = C3(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(0, -200, 1, -50), Size = UDim2.new(0, 225, 0, 25), Font = 'SourceSansItalic', Text = 'press ; to execute a command', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = CMD_BAR_H})
	NEW('ScrollingFrame',{Name = 'commands', BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -250), Size = UDim2.new(1, 0, 0, 0), Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 6, ScrollingEnabled = true, BottomImage = SI, MidImage = SI, TopImage = SI, Parent = CMD_BAR_H.bar})
	NEW('TextLabel',{Name = 'commands_ex', BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0, 200, 0, 20), Visible = false, Font = 'SourceSansBold', TextColor3 = C3(255, 255, 255), TextSize = 18, TextXAlignment = 'Left', Parent = CMD_BAR_H.bar})
	NEW('Frame',{Name = 'overlay', BackgroundColor3 = C3(50, 50, 50), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -25), Size = UDim2.new(1, 0, 0, 0), Visible = false, Parent = CMD_BAR_H.bar,ZIndex=-5})

	local NOTIFY_H = new('ScreenGui', GUIS)
	NOTIFY_H.Name = 'notify_seth'
	local N = new('Frame', NOTIFY_H)
	N.Name = 'notify'
	N.BackgroundColor3 = C3(0, 0, 0)
	N.BackgroundTransparency = 0.5
	N.BorderSizePixel = 0
	N.Position = UDim2.new(0, -225, 0.6, 0)
	N.Size = UDim2.new(0, 225, 0, 30)
	local BAR = new('Frame', N)
	BAR.Name = ''
	BAR.BackgroundColor3 = C3(255, 255, 255)
	BAR.BackgroundTransparency = 0.5
	BAR.BorderSizePixel = 0
	BAR.Position = UDim2.new(0, 0, 1, 0)
	BAR.Size = UDim2.new(1, 0, 0, 5)
	local TEXT = new('TextLabel', N)
	TEXT.Name = 'text'
	TEXT.BackgroundTransparency = 1
	TEXT.BorderSizePixel = 0
	TEXT.Size = UDim2.new(1, 0, 1, 0)
	TEXT.Font = 'SourceSansBold'
	TEXT.TextColor3 = C3(255, 255, 255)
	TEXT.TextSize = 18
	TEXT.TextXAlignment = 'Left'

	PAPER_MESH = new('BlockMesh', OTHER)
	PAPER_MESH.Scale = Vector3.new(1, 1, 0.1)

	JAIL = new('Model', OTHER)
	JAIL.Name = 'JAIL'
	local B = new('Part', JAIL)
	B.Name = 'BUTTOM'
	B.BrickColor = BrickColor.new('Black')
	B.Transparency = 0.5
	B.Anchored = true
	B.Locked = true
	B.Size = Vector3.new(6, 1, 6)
	B.TopSurface = 'Smooth'
	B.BottomSurface = 'Smooth'
	local M = new('Part', JAIL)
	M.Name = 'MAIN'
	M.BrickColor = BrickColor.new('Black')
	M.Transparency = 1
	M.Anchored = true
	M.CanCollide = false
	M.Locked = true
	M.Position = B.Position + Vector3.new(0, 3, 0)
	M.Size = Vector3.new(1, 1, 1)
	local P1 = new('Part', JAIL)
	P1.BrickColor = BrickColor.new('Black')
	P1.Transparency = 1
	P1.Position = B.Position + Vector3.new(0, 3.5, -2.5)
	P1.Rotation = Vector3.new(0, 90, 0)
	P1.Anchored = true
	P1.Locked = true
	P1.Size = Vector3.new(1, 6, 6)
	local P2 = new('Part', JAIL)
	P2.BrickColor = BrickColor.new('Black')
	P2.Transparency = 1
	P2.Position = B.Position + Vector3.new(-2.5, 3.5, 0)
	P2.Rotation = Vector3.new(-180, 0, -180)
	P2.Anchored = true
	P2.Locked = true
	P2.Size = Vector3.new(1, 6, 4)
	local P3 = new('Part', JAIL)
	P3.BrickColor = BrickColor.new('Black')
	P3.Transparency = 1
	P3.Position = B.Position + Vector3.new(2.5, 3.5, 0)
	P3.Rotation = Vector3.new(0, 0, 0)
	P3.Anchored = true
	P3.Locked = true
	P3.Size = Vector3.new(1, 6, 4)
	local P4 = new('Part', JAIL)
	P4.BrickColor = BrickColor.new('Black')
	P4.Transparency = 1
	P4.Position = B.Position + Vector3.new(0, 3.5, 2.5)
	P4.Rotation = Vector3.new(0, 90, 0)
	P4.Anchored = true
	P4.Locked = true
	P4.Size = Vector3.new(1, 6, 4)
	local TOP = new('Part', JAIL)
	TOP.BrickColor = BrickColor.new('Black')
	TOP.Transparency = 0.5
	TOP.Position = B.Position + Vector3.new(0, 7, 0)
	TOP.Rotation = Vector3.new(0, 0, 0)
	TOP.Anchored = true
	TOP.Locked = true
	TOP.Size = Vector3.new(6, 1, 6)
	TOP.TopSurface = 'Smooth'
	TOP.BottomSurface = 'Smooth'

	ROCKET = new('Part', OTHER)
	ROCKET.Name = 'rocket_seth'
	ROCKET.CanCollide = false
	ROCKET.Size = Vector3.new(2, 5, 2) 
	new('CylinderMesh', ROCKET)
	local F = new('Part', ROCKET)
	F.BrickColor = BrickColor.new('Black')
	F.CanCollide = false
	F.Size = Vector3.new(2, 0.2, 2)
	new('CylinderMesh', F)
	local PE = new('ParticleEmitter', F)
	PE.Color = ColorSequence.new(C3(236, 139, 70), C3(236, 139, 70))
	PE.Size = NumberSequence.new(0.2)
	PE.Texture = 'rbxassetid://17238048'
	PE.LockedToPart = true
	PE.Lifetime = NumberRange.new(0.2)
	PE.Rate = 50
	PE.Speed = NumberRange.new(-20)
	local TOP = new('Part', ROCKET)
	TOP.CanCollide = false
	TOP.Shape = 'Ball'
	TOP.Size = Vector3.new(2, 2, 2)
	TOP.TopSurface = 'Smooth'
	TOP.BottomSurface = 'Smooth'
	local BF = new('BodyForce', ROCKET)
	BF.Name = 'force'
	BF.Force = Vector3.new(0, 0, 0)
	local W1 = new('Weld', ROCKET)
	W1.Part0 = ROCKET
	W1.Part1 = F
	W1.C1 = CFrame.new(0, 2.6, 0)
	local W2 = new('Weld', ROCKET)
	W2.Part0 = ROCKET
	W2.Part1 = TOP
	W2.C1 = CFrame.new(0, -2.6, 0)

	ALIEN_H = new('Accessory', OTHER)
	local H = new('Part', ALIEN_H)
	H.Name = 'Handle'
	H.Size = Vector3.new(2, 2.4, 2)
	local HA = new('Attachment', H)
	HA.Name = 'HatAttachment'
	HA.Position = Vector3.new(0, 0.15, 0)
	local SM = new('SpecialMesh', H)
	SM.MeshId = 'rbxassetid://13827689'
	SM.MeshType = 'FileMesh'
	SM.Scale = Vector3.new(1, 1.02, 1)
	SM.TextureId = 'rbxassetid://13827796'

	local S = new('Model', OTHER) S.Name = 'swastika'
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Anchored = true, CanCollide = false, Size = Vector3.new(2, 2, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(0, 3, 0), Anchored = true, CanCollide = false, Size = Vector3.new(2, 4, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(3, 0, 0), Anchored = true, CanCollide = false, Size = Vector3.new(4, 2, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(0, -3, 0), Anchored = true, CanCollide = false, Size = Vector3.new(2, 4, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(-3, 0, 0), Anchored = true, CanCollide = false, Size = Vector3.new(4, 2, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(3, 4, 0), Anchored = true, CanCollide = false, Size = Vector3.new(4, 2, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(4, -3, 0), Anchored = true, CanCollide = false, Size = Vector3.new(2, 4, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(-3, -4, 0), Anchored = true, CanCollide = false, Size = Vector3.new(4, 2, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})
	NEW('Part',{BrickColor = BrickColor.new('Really red'), Material = 'Plastic', Position = Vector3.new(-4, 3, 0), Anchored = true, CanCollide = false, Size = Vector3.new(2, 4, 2), BottomSurface = 'Smooth', TopSurface = 'Smooth', Parent = S})

	CMD_BAR_H.Parent = _CORE
	DATA_LOADED = true
end

local RS = game:GetService('RunService').RenderStepped

function OPEN_MAIN()
	if not DATA_LOADED then LOAD_DATA() end
	SETH_MAIN = MAIN_GUI:Clone()

	local BUTTONS = SETH_MAIN.main.holder.buttons
	local HOLDERS = SETH_MAIN.main.holder.holders

	for i,v in pairs(SETH_MAIN.main.holder.buttons:GetChildren()) do
		v.MouseButton1Down:connect(function(X, Y)
			OPEN_TAB(v.Name)
			if not v:FindFirstChild('circle') then
				local C = new('ImageLabel', v, {BackgroundTransparency = 1,Position = UDim2.new(0, X - 0, 0, Y - 35) - UDim2.new(0, v.AbsolutePosition.X, 0, v.AbsolutePosition.Y),Size = UDim2.new(0, 0, 0, 0),ZIndex=v.ZIndex,Image = 'rbxassetid://200182847',ImageColor3 = C3(0, 100, 255)})
				C:TweenSizeAndPosition(UDim2.new(0, 500, 0, 500), C.Position - UDim2.new(0, 250, 0, 250), 'Out', 'Quart', 2.5)
				for i = 0, 1, 0.03 do
					C.ImageTransparency = i
					RS:Wait()
				end
				C:Destroy()
			end
		end)
	end

	HOLDERS.server.place_id.Text = ' Place ID | ' .. game.PlaceId
	game:GetService('RunService').Stepped:connect(function()
		if SETH_MAIN:FindFirstChild('main') and HOLDERS:FindFirstChild('server') then
			if not workspace.FilteringEnabled then
				HOLDERS.server.fe.Text = ' FilteringEnabled | false'
			else
				HOLDERS.server.fe.Text = ' FilteringEnabled | true'
			end
			HOLDERS.server.ip.Text = ' PlaceId | ' .. game.PlaceId
			HOLDERS.server.port.Text = ' JobId | ' .. game.JobId
			HOLDERS.server.players.Text = ' Players | ' .. _PLAYERS.NumPlayers .. '/' .. _PLAYERS.MaxPlayers
			HOLDERS.server.time.Text = ' Time | ' .. _LIGHTING.TimeOfDay
			HOLDERS.server.gravity.Text = ' Gravity | ' .. workspace.Gravity
		end
	end)

	function UPDATE_ADMINS()
		HOLDERS.admins:ClearAllChildren()
		HOLDERS.admins.CanvasSize = UDim2.new(0, 0, 0, 0)
		local Y_ADMINS = 5
		for i,v in pairs(ADMINS) do
			NEW('TextLabel',{Name = v, BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, Y_ADMINS), Size = UDim2.new(1, -30, 0, 25), Font = 'SourceSansBold', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.admins})
			NEW('TextButton',{Name = 'update', BackgroundColor3 = C3(255, 50, 50), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 25, 0, 25), Text = '', Parent = HOLDERS.admins[v]})
			HOLDERS.admins[v].update.MouseButton1Down:connect(function()
				table.remove(ADMINS, i)
				UPDATE_ADMINS()
			end)
			HOLDERS.admins.CanvasSize = HOLDERS.admins.CanvasSize + UDim2.new(0, 0, 0, 30)
			Y_ADMINS = Y_ADMINS + 30
		end
		HOLDERS.admins.CanvasSize = HOLDERS.admins.CanvasSize + UDim2.new(0, 0, 0, 5)
		spawn(function()
			for i,v in pairs(HOLDERS.admins:GetChildren()) do
				v.Text = ' ' .. _PLAYERS:GetNameFromUserIdAsync(v.Name)
			end
		end)
	end
	UPDATE_ADMINS()
	function UPDATE_BANS()
		HOLDERS.bans:ClearAllChildren()
		HOLDERS.bans.CanvasSize = UDim2.new(0, 0, 0, 0)
		local Y_BANS = 5
		for i,v in pairs(BANS) do
			NEW('TextLabel',{Name = v, BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, Y_BANS), Size = UDim2.new(1, -30, 0, 25), Font = 'SourceSansBold', Text = '', TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.bans})
			NEW('TextButton',{Name = 'update', BackgroundColor3 = C3(255, 50, 50), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 25, 0, 25), Text = '', Parent = HOLDERS.bans[v]})
			HOLDERS.bans[v].update.MouseButton1Down:connect(function()
				table.remove(BANS, i)
				UPDATE_BANS()
			end)
			HOLDERS.bans.CanvasSize = HOLDERS.bans.CanvasSize + UDim2.new(0, 0, 0, 30)
			Y_BANS = Y_BANS + 30
		end
		HOLDERS.bans.CanvasSize = HOLDERS.bans.CanvasSize + UDim2.new(0, 0, 0, 5)
		spawn(function()
			for i,v in pairs(HOLDERS.bans:GetChildren()) do
				v.Text = ' ' .. _PLAYERS:GetNameFromUserIdAsync(v.Name)
			end
		end)
	end
	UPDATE_BANS()
	local function DISPLAY_CMDS()
		local Y_COMMANDS = 0
		for i,v in pairs(COMMANDS) do
			NEW('TextLabel',{Name = '', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, Y_COMMANDS), Size = UDim2.new(1, 0, 0, 25), Font = 'SourceSansBold', Text = ' ' .. v.D, TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.cmds})
			HOLDERS.cmds.CanvasSize = HOLDERS.cmds.CanvasSize + UDim2.new(0, 0, 0, 25)
			Y_COMMANDS = Y_COMMANDS + 25
		end
	end
	DISPLAY_CMDS()
	print("cmds")
	
	HOLDERS.search.Changed:connect(function()
		if SETH_MAIN:FindFirstChild('main') and SETH_MAIN.main.holder.holders:FindFirstChild('search') then
			if HOLDERS.search.Text ~= 'search commands' and HOLDERS.search.Focused then
				if HOLDERS.search.Text ~= '' then
					if not HOLDERS.search.Text:find(' ') then
						HOLDERS.cmds:ClearAllChildren()
						HOLDERS.cmds.CanvasSize = UDim2.new(0, 0, 0, 0)
						local Y_COMMANDS = 0
						for i,v in pairs(COMMANDS) do
							if v.N:find(HOLDERS.search.Text) then
								HOLDERS.cmds.CanvasSize = HOLDERS.cmds.CanvasSize + UDim2.new(0, 0, 0, 25)
								NEW('TextLabel',{Name = '', BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, Y_COMMANDS), Size = UDim2.new(1, 0, 0, 25), Font = 'SourceSansBold', Text = ' ' .. v.D, TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.cmds})
								HOLDERS.changelog.CanvasSize = HOLDERS.changelog.CanvasSize + UDim2.new(0, 0, 0, 25)
								Y_COMMANDS = Y_COMMANDS + 25
							end
						end
					end
				else
					HOLDERS.cmds:ClearAllChildren()
					HOLDERS.cmds.CanvasSize = UDim2.new(0, 0, 0, 0)
					DISPLAY_CMDS()
				end
			end
		end
	end)

	local FUN = {'balefire', 'swastika', 'trowel', 'path giver', 'orbital strike', 'furry rapist', 'doge army', 'yourmom', 'holy wrench', 'john doe'}
	local Y_FUN = 5
	for i,v in pairs(FUN) do
		NEW('TextLabel',{Name = v, BackgroundColor3 = C3(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, Y_FUN), Size = UDim2.new(1, -50, 0, 25), Font = 'SourceSansBold', Text = ' ' .. v, TextColor3 = C3(0, 0, 0), TextSize = 24, TextTransparency = 0.25, TextXAlignment = 'Left', Parent = HOLDERS.fun})
		HOLDERS.fun.CanvasSize = HOLDERS.fun.CanvasSize + UDim2.new(0, 0, 0, 30)
		Y_FUN = Y_FUN + 30
	end
	HOLDERS.fun.CanvasSize = HOLDERS.fun.CanvasSize + UDim2.new(0, 0, 0, 5)
	for i,v in pairs(HOLDERS.fun:GetChildren()) do
		NEW('TextButton',{Name = 'load', BackgroundColor3 = C3(50, 50, 255), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 45, 0, 25), ClipsDescendants = true, Font = 'SourceSansBold', Text = 'load', TextColor3 = C3(255, 255, 255), TextSize = 20, Parent = v})
		v.load.MouseButton1Down:connect(function()
			if v.Name == 'balefire' then LOAD_BALEFIRE()
			elseif v.Name == 'swastika' then local S = OTHER.swastika:Clone() S.Parent = workspace S:MoveTo(LP.Character.Head.Position + Vector3.new(0, 10, 0))
			elseif v.Name == 'trowel' then LOAD_TROWEL()
			elseif v.Name == 'path giver' then LOAD_PATH()
			elseif v.Name == 'orbital strike' then LOAD_STRIKE()
			elseif v.Name == 'furry rapist' then LOAD_FURRY()
			elseif v.Name == 'doge army' then LOAD_DOGE()
			elseif v.Name == 'yourmom' then LOAD_YOMAMAHAHA()
			elseif v.Name == 'holy wrench' then LOAD_HW()
			elseif v.Name == 'john doe' then LOAD_JD()
			end
		end)
	end

	SETH_MAIN.main.close.MouseButton1Down:connect(function()
		SETH_MAIN:destroy()
	end)

	SETH_MAIN.Parent = _CORE
end

LOAD_DATA()

--// LOADSTRINGS
function LOAD_DOGE()
	loadstring(game:HttpGet("https://github.com/ZwDaNk/rocky2u-cmdscript/blob/main/data/doge.lua"))()
end

function LOAD_YOMAMAHAHA()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZwDaNk/rocky2u-cmdscript/refs/heads/main/data/yourmom.lua"))()
end

function LOAD_HW()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZwDaNk/rocky2u-cmdscript/refs/heads/main/data/holywrench.lua"))()
end

function LOAD_JD()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZwDaNk/rocky2u-cmdscript/refs/heads/main/data/johndoe.lua"))()
end

--/ TOOLS

function LOAD_BALEFIRE()
	local HB = new('HopperBin', LP.Backpack)
	HB.Name = 'balefire'

	local function BF(P)
		for i = 1, 50 do
			local E = new('Explosion', workspace)
			E.BlastRadius = 3
			E.BlastPressure = 999999
			E.Position = LP.Character.Torso.CFrame.p + ((P - LP.Character.Torso.CFrame.p).unit * 6 * i) + ((P - LP.Character.Torso.CFrame.p).unit * 7)
		end
	end

	FIRED = false
	local function FIRE(M)
		if not FIRED then
			FIRED = true
			BF(M.Hit.p)
			wait(0.25)
			FIRED = false
		end
	end

	HB.Selected:connect(function(M)
		M.Button1Down:connect(function()
			FIRE(M)
		end)
	end)
end

function LOAD_TROWEL()
	local T = new('Tool', LP.Backpack) T.Name = 'trowel'
	NEW('Part',{Name = 'Handle', Size = Vector3.new(1, 4.4, 1), Parent = T})
	NEW('SpecialMesh',{MeshId = 'rbxasset://fonts/trowel.mesh', MeshType = 'FileMesh', TextureId = 'rbxasset://textures/TrowelTexture.png', Parent = T.Handle})
	NEW('Sound',{Name = 'build', SoundId = 'rbxasset://sounds//bass.wav', Volume = 1, Parent = T.Handle})

	local HEIGHT = 5
	local SPEED = 0.05
	local WIDTH = 15

	function BRICK(CF, P, C)
		local B = new('Part')
		B.BrickColor = C
		B.CFrame = CF * CFrame.new(P + B.Size / 2)
		B.Parent = game.Workspace
		B:MakeJoints()
		B.Material = 'Neon'
		return  B, P + B.Size
	end

	function BW(CF)
		local BC = BrickColor.Random()
		local B = {}
		assert(WIDTH > 0)
		local Y = 0
		while Y < HEIGHT do
			local P
			local X = -WIDTH / 2
			while X < WIDTH / 2 do
				local brick
				brick, P = BRICK(CF, Vector3.new(X, Y, 0), BC)
				X = P.x
				table.insert(B, brick)
				wait(SPEED)
			end
			Y = P.y
		end
		return B
	end

	function S(A)
		if math.abs(A.x) > math.abs(A.z) then
			if A.x > 0 then
				return Vector3.new(1, 0, 0)
			else
				return Vector3.new(-1, 0, 0)
			end
		else
			if A.z > 0 then
				return Vector3.new(0, 0, 1)
			else
				return Vector3.new(0, 0, -1)
			end
		end
	end

	T.Enabled = true
	T.Activated:connect(function()
		if T.Enabled and LP.Character:FindFirstChild('Humanoid') then
			T.Enabled = false
			T.Handle.build:Play()
			BW(CFrame.new(LP.Character.Humanoid.TargetPoint, LP.Character.Humanoid.TargetPoint + S((LP.Character.Humanoid.TargetPoint - LP.Character.Head.Position).unit)))
			T.Enabled = true
		end
	end)
end

function LOAD_PATH()
	local HB = new('HopperBin', LP.Backpack) HB.Name = 'path giver'

	local function PATH(M, C)
		if ENABLED and LP.Character then
			if not workspace:FindFirstChild('paths_seth') then new('Folder', workspace).Name = 'paths_seth' end
			local hit = M.Target
			local point = M.Hit.p
			local P = new('Part', workspace.paths_seth)
			P.BrickColor = C
			P.Material = 'Neon'
			P.Transparency = 0.75
			P.Anchored = true
			P.Size = Vector3.new(20, 1, 20)
			P.Velocity = M.Hit.lookVector * 75
			P.BottomSurface = 'Smooth'
			P.TopSurface = 'Smooth'
			P.CFrame = CFrame.new(LP.Character.Head.Position)
			P.CFrame = CFrame.new(LP.Character.Torso.Position.x, LP.Character.Torso.Position.y - 4, LP.Character.Torso.Position.z)
			P.CFrame = CFrame.new(P.Position, point)
			wait()
			PATH(M, C)
		end
	end

	local function SELECTED(M)
		M.Button1Down:connect(function() ENABLED = true PATH(M, BrickColor.Random()) end)
		M.Button1Up:connect(function() ENABLED = false end)
		M.KeyDown:connect(function(K) if K == 'r' then if workspace:FindFirstChild('paths_seth') then workspace.paths_seth:destroy() end end end)
	end

	HB.Selected:connect(SELECTED)
end

function LOAD_STRIKE()
	local HB = new('HopperBin', LP.Backpack) HB.Name = 'orbital strike'

	local function SHOOT(T)
		if ENABLED then
			local P0 = CFrame.new(0, 1500, 0)
			P0 = P0 + ((P0 * CFrame.fromEulerAnglesXYZ(math.pi / 2, 0, 0)).lookVector * 0.5) + (P0 * CFrame.fromEulerAnglesXYZ(0, math.pi / 2, 0)).lookVector
			local P1 = P0 + ((P0.p - T.Hit.p).unit * -2)
			SATELITE.CFrame = CFrame.new((P0.p + P1.p) / 2, P0.p) * CFrame.fromEulerAnglesXYZ(-math.pi / 2, 0, 0)

			local M = new('Model', workspace)
			NEW('Part',{BrickColor = BrickColor.new('Pink'), Material = 'Neon', CFrame = CFrame.new((SATELITE.CFrame.p + T.Hit.p) / 2, SATELITE.CFrame.p), Anchored = true, CanCollide = false, Size = Vector3.new(1, 1, 1), Parent = M})
			NEW('BlockMesh',{Scale = Vector3.new(1, 1, (SATELITE.CFrame.p - T.Hit.p).magnitude), Parent = M.Part})
			NEW('Explosion',{Position = T.Hit.p, BlastRadius = 20, Parent = workspace})

			for i = 1,10 do M.Part.Transparency = 0.5 + (i * 0.05) wait(0.05) end
			M:destroy()
		end
	end

	HB.Selected:connect(function(M)
		if not workspace:FindFirstChild('orbital_seth') then
			SATELITE = new('Part', workspace)
			SATELITE.Name = 'orbital_seth'
			SATELITE.Position = Vector3.new(0, 1500, 0)
			SATELITE.Anchored = true
			SATELITE.CanCollide = false
			SATELITE.Size = Vector3.new(5, 16.8, 5)
			NEW('SpecialMesh',{MeshId = 'rbxassetid://1064328', Scale = Vector3.new(0.2, 0.2, 0.2), Parent = SATELITE})
		end
		M.Button1Down:connect(function() ENABLED = true SHOOT(M) end)
		M.Button1Up:connect(function() ENABLED = false end)
	end)
end

function LOAD_FURRY()
    local InsertService = game:GetService("InsertService")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:FindFirstChild("Head") or character:FindFirstChild("Torso")

    local asset = InsertService:LoadAsset(94251705):GetChildren()[1]
    asset.Parent = game.Workspace
    asset.Name = "mathmark124 the rapist"

    local shirt = Instance.new("Shirt")
    shirt.Parent = asset
    shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=1253513442"

    local pants = Instance.new("Pants")
    pants.Parent = asset
    pants.PantsTemplate = "http://www.roblox.com/asset/?id=1253513840"

    local hat = Instance.new("SpecialMesh")
    hat.Parent = asset.Head
    hat.MeshId = "http://www.roblox.com/asset/?id=188699722"
    hat.TextureId = "http://www.roblox.com/asset/?id=188699768"

    asset.Head.Transparency = 0
    asset.Torso.Transparency = 0
    asset["Right Leg"].Transparency = 0
    asset["Right Arm"].Transparency = 0
    asset["Left Leg"].Transparency = 0
    asset["Left Arm"].Transparency = 0

    if not asset.PrimaryPart then
        asset.PrimaryPart = asset:FindFirstChild("Head") or asset:FindFirstChild("Torso")
    end

    if head then
        asset:SetPrimaryPartCFrame(head.CFrame)
    end
end

function FIND_IN_TABLE(TABLE, NAME)
	for i,v in pairs(TABLE) do
		if v == NAME then
			return true
		end
	end
	return false
end

function GET_IN_TABLE(TABLE, NAME)
	for i = 1, #TABLE do
		if TABLE[i] == NAME then
			return i
		end
	end
	return false
end

local NOTIFY_1 = false
local NOTIFY_2 = false

function NOTIFY(M, R, G, B)
	spawn(function()
		repeat wait() until not NOTIFY_1
		local NOTIFY_SETH = GUIS.notify_seth:Clone() NOTIFY_SETH.Parent = _CORE
		if NOTIFY_SETH then
			NOTIFY_SETH.notify[''].BackgroundColor3 = C3(R, G, B)
			NOTIFY_SETH.notify.text.Text = ' ' .. M
			repeat wait() until not NOTIFY_1
			NOTIFY_1 = true
			wait(0.5)
			NOTIFY_SETH.notify:TweenPosition(UDim2.new(0, 0, 0.6, 0), 'InOut', 'Quad', 0.4, false) wait(0.5)
			wait(0.5)
			repeat wait() until not NOTIFY_2
			NOTIFY_1 = false
			NOTIFY_SETH.notify:TweenPosition(UDim2.new(0, 0, 0.6, -40), 'InOut', 'Quad', 0.4, false) wait(0.5)
			wait(0.5)
			NOTIFY_2 = true
			wait(2.5)
			NOTIFY_SETH.notify:TweenPosition(UDim2.new(0, -225, 0.6, -40), 'InOut', 'Quad', 0.4, false) wait(0.5)
		end
		wait(.5)
		NOTIFY_SETH:destroy()
		NOTIFY_2 = false
	end)
end

function KICK(P)
	spawn(function()
		for i = 1,5 do
			if P.Character and P.Character:FindFirstChild('Torso') then
				P.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(999000, 1001000), 1000000, 1000000)
				local SP = new('SkateboardPlatform', P.Character) SP.Position = P.Character.HumanoidRootPart.Position SP.Transparency = 1
				spawn(function()
					repeat wait()
						if P.Character then SP.Position = P.Character.Torso.Position end
					until not _PLAYERS:FindFirstChild(P.Name)
				end)
				P.Character.Torso.Anchored = true
			end
		end
	end)
end

function GULL(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:Destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end

	local char = PLAYER.Character
	char.PrimaryPart = char.HumanoidRootPart

	local tors = char.HumanoidRootPart
	local initCFrame = tors.CFrame

	if char:FindFirstChild("Torso") then
		char.Torso.Anchored = true
	else
		char.UpperTorso.Anchored = true
	end
	char:FindFirstChildOfClass("Humanoid").Name = "Sad"

	local gull = new("Part", workspace)
	gull.Anchored = true
	gull.CanCollide = false
	gull.Position = Vector3.new(0,100000,0)
	local mesh = new("SpecialMesh", gull)
	mesh.MeshId = "http://www.roblox.com/asset/?id=272501436"
	mesh.TextureId = "http://www.roblox.com/asset/?id=267684509"
	mesh.Scale = Vector3.new(10,10,10)

	local leftWing = new("Part", gull)
	leftWing.CanCollide = false
	local lmesh = new("SpecialMesh", leftWing)
	lmesh.MeshId = "http://www.roblox.com/asset/?id=267684584"
	lmesh.TextureId = "http://www.roblox.com/asset/?id=267684509"
	lmesh.Scale = Vector3.new(10,10,10)
	local leftMotor = new("Motor6D", gull)
	leftMotor.MaxVelocity = 1
	leftMotor.Part0 = gull
	leftMotor.Part1 = leftWing
	leftMotor.C0 = CFrame.new(-50.2919998, -0.0920021087, 0.280000001)

	local rightWing = new("Part", gull)
	rightWing.CanCollide = false
	local rmesh = new("SpecialMesh", rightWing)
	rmesh.MeshId = "http://www.roblox.com/asset/?id=267684651"
	rmesh.TextureId = "http://www.roblox.com/asset/?id=267684509"
	rmesh.Scale = Vector3.new(10,10,10)
	local rightMotor = new("Motor6D", gull)
	rightMotor.MaxVelocity = 1
	rightMotor.Part0 = gull
	rightMotor.Part1 = rightWing
	rightMotor.C0 = CFrame.new(47.1930008, -0.0670021027, 0.280000001)

	local sound = new("Sound", gull)
	sound.SoundId = "rbxassetid://160877039"
	sound.Volume = 10

	for i = 400,-1000,-2 do
		local der = 0.02*i
		local angle = math.atan(der/1)
		gull.CFrame = initCFrame*CFrame.Angles(angle, math.pi, 0) + initCFrame.lookVector * (i+5) + Vector3.new(0,0.01*i^2+7,0)
		if i == 0 then sound:Play() end
		if i <= 0 then
			char:SetPrimaryPartCFrame(gull.CFrame)
			local nextAngle = -0.2*math.sin(0.05*math.pi*(i))
			leftMotor.DesiredAngle = -nextAngle
			leftMotor.C0 = CFrame.new(-50.2919998, 47.193*math.tan(nextAngle), 0.280000001)
			rightMotor.DesiredAngle = nextAngle
			rightMotor.C0 = CFrame.new(47.1930008, 47.193*math.tan(nextAngle), 0.280000001)
		end
		game:GetService("RunService").RenderStepped:Wait()
	end

	local function GULLKICK(P)
		spawn(function()
			if not FindTable(WL, P.Name) then
				for i = 1,5 do
					if P.Character and P.Character:FindFirstChild('HumanoidRootPart') then
						P.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(999000, 1001000), 1000000, 1000000)
						local SP = new('SkateboardPlatform', P.Character) 
						SP.Position = P.Character.HumanoidRootPart.Position 
						SP.Transparency = 1
						spawn(function()
							repeat wait()
								if P.Character and P.Character:FindFirstChild('HumanoidRootPart') then 
									SP.Position = P.Character.HumanoidRootPart.Position 
								end
							until not game:GetService("Players"):FindFirstChild(P.Name)
						end)
						P.Character.HumanoidRootPart.Anchored = true
					end
				end
			end
		end)
	end

	if char:FindFirstChild("Torso") then
		char.Torso.Anchored = false
	else
		char.UpperTorso.Anchored = false
	end

	spawn(function()
		if PLAYER == game:GetService("Players").LocalPlayer then wait(5) end
		PLAYER.CharacterAdded:Connect(function()
			wait()
			GULLKICK(PLAYER)
		end)
		GULLKICK(PLAYER)
	end)

	local go = new("BodyVelocity", gull)
	go.Velocity = Vector3.new(0,1000,0)
	go.MaxForce = Vector3.new(1000000,1000000,1000000)
	gull.Anchored = false
end

_PLAYERS.PlayerRemoving:connect(function(P)
	if FIND_IN_TABLE(KICKS, P) then
		for i,v in pairs(KICKS) do if v == P then table.remove(KICKS, i) end end
		NOTIFY('KICKED ' .. P.Name, 255, 255, 255)
	end
	if FIND_IN_TABLE(JAILED, P.Name) then
		for i,v in pairs(JAILED) do if v == P.Name then table.remove(KICKS, i) end end
	end
end)

function FIX_LIGHTING()
	_LIGHTING.Ambient = C3(0.5, 0.5, 0.5)
	_LIGHTING.Brightness = 1
	_LIGHTING.GlobalShadows = true
	_LIGHTING.Outlines = false
	_LIGHTING.TimeOfDay = 14
	_LIGHTING.FogEnd = 100000
end

function COLOR(PLAYER, BCOLOR)
	for i,v in pairs(PLAYER.Character:GetChildren()) do if v:IsA('Shirt') or v:IsA('Pants') then v:destroy() elseif v:IsA('ShirtGraphic') then v.Archivable = false v.Graphic = '' end end
	for i,v in pairs(PLAYER.Character.Head:GetChildren()) do if v:IsA('Decal') then v:destroy() end end
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new(BCOLOR)
		elseif v:IsA('Accessory') then
			v.Handle.BrickColor = BrickColor.new(BCOLOR)
			for a,b in pairs(v.Handle:GetChildren()) do
				if b:IsA('SpecialMesh') then
					b.TextureId = ''
				end
			end
		end
	end
end

function LAG(PLAYER)

end

local FLYING = false

if LP.Character and LP.Character:FindFirstChild('Humanoid') then
	LP.Character.Humanoid.Died:connect(function() FLYING = false end)
end

function sFLY()
	repeat wait() until LP and LP.Character and LP.Character:FindFirstChild('Torso') and LP.Character:FindFirstChild('Humanoid')
	repeat wait() until MOUSE

	local T = LP.Character.Torso
	local CONTROL = {F = 0, B = 0, L = 0, R = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = new('BodyGyro', T)
		local BV = new('BodyVelocity', T)
		BG.P = 9e4
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0.1, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		spawn(function()
			repeat wait()
				LP.Character.Humanoid.PlatformStand = true
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0.1, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0}
			SPEED = 0
			BG:destroy()
			BV:destroy()
			LP.Character.Humanoid.PlatformStand = false
		end)
	end

	MOUSE.KeyDown:connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 1
		elseif KEY:lower() == 's' then
			CONTROL.B = -1
		elseif KEY:lower() == 'a' then
			CONTROL.L = -1 
		elseif KEY:lower() == 'd' then 
			CONTROL.R = 1
		end
	end)

	MOUSE.KeyUp:connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	LP.Character.Humanoid.PlatformStand = false
end

function RESET_MODEL(MODEL)
	for i,v in pairs(MODEL:GetChildren()) do
		if v:IsA('Seat') and v.Name == 'FakeTorso' then
			v:destroy()
		elseif v:IsA('CharacterMesh') or v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 0
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	for i,v in pairs(MODEL.Torso:GetChildren()) do
		if v:IsA('SpecialMesh') then
			v:destroy()
		end
	end
	if MODEL.Head:FindFirstChild('Mesh') then
		MODEL.Head.Mesh:destroy()
	end
	if MODEL.Torso:FindFirstChild('Neck') then MODEL.Torso.Neck.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0) end
	if MODEL.Torso:FindFirstChild('Left Shoulder') then MODEL.Torso['Left Shoulder'].C0 = CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, math.rad(-90), 0) end
	if MODEL.Torso:FindFirstChild('Right Shoulder') then MODEL.Torso['Right Shoulder'].C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.rad(90), 0) end
	if MODEL.Torso:FindFirstChild('Left Hip') then MODEL.Torso['Left Hip'].C0 = CFrame.new(-1, -1, 0) * CFrame.Angles(0, math.rad(-90), 0) end
	if MODEL.Torso:FindFirstChild('Right Hip') then MODEL.Torso['Right Hip'].C0 = CFrame.new(1, -1, 0) * CFrame.Angles(0, math.rad(90), 0) end
end

function UPDATE_MODEL(MODEL, USERNAME)
	local AppModel = _PLAYERS:GetCharacterAppearanceAsync(_PLAYERS:GetUserIdFromNameAsync(USERNAME))
	MODEL.Name = USERNAME
	for i,v in pairs(AppModel:GetChildren()) do
		if v:IsA('SpecialMesh') or v:IsA('BlockMesh') or v:IsA('CylinderMesh') then
			v.Parent = MODEL.Head
		elseif v:IsA('Decal') then
			if MODEL.Head:FindFirstChild('face') then
				MODEL.Head.face.Texture = v.Texture
			else
				local FACE = new('Decal', MODEL.Head)
				FACE.Texture = v.Texture
			end
		elseif v:IsA('BodyColors') or v:IsA('CharacterMesh') or v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
			if MODEL:FindFirstChild('Body Colors') then
				MODEL['Body Colors']:destroy()
			end
			v.Parent = MODEL
		elseif v:IsA('Accessory') then
			v.Parent = MODEL
			v.Handle.CFrame = MODEL.Head.CFrame * CFrame.new(0, MODEL.Head.Size.Y / 2, 0) * v.AttachmentPoint:inverse()
		end
	end
	if not MODEL.Head:FindFirstChild('Mesh') then
		local SM = new('SpecialMesh', MODEL.Head)
		SM.MeshType = Enum.MeshType.Head
		SM.Scale = Vector3.new(1.25, 1.25, 1.25)
	end
end

function CREEPER(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Accessory') then
			v:destroy()
		end
	end
	PLAYER.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(90),math.rad(180),0)
	PLAYER.Character.Torso['Right Shoulder'].C0 = CFrame.new(0,-1.5,-.5) * CFrame.Angles(0,math.rad(90),0)
	PLAYER.Character.Torso['Left Shoulder'].C0 = CFrame.new(0,-1.5,-.5) * CFrame.Angles(0,math.rad(-90),0)
	PLAYER.Character.Torso['Right Hip'].C0 = CFrame.new(0,-1,.5) * CFrame.Angles(0,math.rad(90),0)
	PLAYER.Character.Torso['Left Hip'].C0 = CFrame.new(0,-1,.5) * CFrame.Angles(0,math.rad(-90),0)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new('Bright green')
		end
	end
end

function SHREK(PLAYER)
	COLOR(PLAYER, 'Bright green')
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') or v:IsA('CharacterMesh') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	for i,v in pairs(PLAYER.Character.Head:GetChildren()) do
		if v:IsA('Decal') or v:IsA('SpecialMesh') then
			v:destroy()
		end
	end
	if PLAYER.Character:FindFirstChild('Shirt Graphic') then
		PLAYER.Character['Shirt Graphic'].Archivable = false
		PLAYER.Character['Shirt Graphic'].Graphic = ''
	end
	local M = new('SpecialMesh', PLAYER.Character.Head)
	local S = new('Shirt', PLAYER.Character)
	local P = new('Pants', PLAYER.Character)
	M.MeshType = 'FileMesh'
	M.MeshId = 'rbxassetid://19999257'
	M.Offset = Vector3.new(-0.1, 0.1, 0)
	M.TextureId = 'rbxassetid://156397869'
	S.ShirtTemplate = 'rbxassetid://133078194'
	P.PantsTemplate = 'rbxassetid://133078204'
end

function FURRY(PLAYER)
	COLOR(PLAYER, 'White')
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') or v:IsA('CharacterMesh') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	for i,v in pairs(PLAYER.Character.Head:GetChildren()) do
		if v:IsA('Decal') or v:IsA('SpecialMesh') then
			v:destroy()
		end
	end
	if PLAYER.Character:FindFirstChild('Shirt Graphic') then
		PLAYER.Character['Shirt Graphic'].Archivable = false
		PLAYER.Character['Shirt Graphic'].Graphic = ''
	end
	local M = new('SpecialMesh', PLAYER.Character.Head)
	local S = new('Shirt', PLAYER.Character)
	local P = new('Pants', PLAYER.Character)
	M.MeshType = 'FileMesh'
	M.MeshId = 'rbxassetid://188699722'
	M.Offset = Vector3.new(-0.1, 0.1, 0)
	M.TextureId = 'rbxassetid://188699768'
	S.ShirtTemplate = 'rbxassetid://1253513442'
	P.PantsTemplate = 'rbxassetid://1253513840'
end

function SWAG(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
			v:destroy()
		end
	end
	if PLAYER.Character:FindFirstChild('Shirt Graphic') then
		PLAYER.Character['Shirt Graphic'].Archivable = false
		PLAYER.Character['Shirt Graphic'].Graphic = ''
	end
	local S = new('Shirt', PLAYER.Character)
	local P = new('Pants', PLAYER.Character)
	S.ShirtTemplate = 'rbxassetid://109163376'
	P.PantsTemplate = 'rbxassetid://109163376'
end

function IPHONE(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	local DUCK = new('SpecialMesh', PLAYER.Character.Torso)
	DUCK.MeshType = 'FileMesh'
	DUCK.MeshId = 'http://www.roblox.com/asset/?id=430345282'
	DUCK.TextureId = 'http://www.roblox.com/asset/?id=430345284'
	DUCK.Scale = Vector3.new(1, 1, 1)
	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Transparency = 1
	end
end

function SPONGE(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	local DUCK = new('SpecialMesh', PLAYER.Character.Torso)
	DUCK.MeshType = 'FileMesh'
	DUCK.MeshId = 'http://www.roblox.com/asset/?id=430088036'
	DUCK.TextureId = 'http://www.roblox.com/asset/?id=430088043'
	DUCK.Scale = Vector3.new(1, 1, 1)
	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Transparency = 1
	end
end

function CAKE(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	local DUCK = new('SpecialMesh', PLAYER.Character.Torso)
	DUCK.MeshType = 'FileMesh'
	DUCK.MeshId = 'http://www.roblox.com/asset/?id=1376455'
	DUCK.TextureId = 'http://www.roblox.com/asset/?id=1376454'
	DUCK.Scale = Vector3.new(5, 5, 5)
	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Transparency = 1
	end
end

function KEEMSTAR(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	local DUCK = new('SpecialMesh', PLAYER.Character.Torso)
	DUCK.MeshType = 'FileMesh'
	DUCK.MeshId = 'rbxassetid://471652548'
	DUCK.TextureId = 'rbxassetid://471652580'
	DUCK.Scale = Vector3.new(.5, .5, .5)
	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Transparency = 1
	end
end

function DUCK(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'Torso' and v.Name ~= 'HumanoidRootPart' then
			v.Transparency = 1
		elseif v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	local DUCK = new('SpecialMesh', PLAYER.Character.Torso)
	DUCK.MeshType = 'FileMesh'
	DUCK.MeshId = 'rbxassetid://9419831'
	DUCK.TextureId = 'rbxassetid://9419827'
	DUCK.Scale = Vector3.new(5, 5, 5)
	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Transparency = 1
	end
end

function DOG(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end
	PLAYER.Character.Torso.Transparency = 1
	PLAYER.Character.Torso.Neck.C0 = CFrame.new(0, -0.5, -2) * CFrame.Angles(math.rad(90), math.rad(180), 0)
	PLAYER.Character.Torso['Right Shoulder'].C0 = CFrame.new(0.5, -1.5, -1.5) * CFrame.Angles(0, math.rad(90), 0)
	PLAYER.Character.Torso['Left Shoulder'].C0 = CFrame.new(-0.5, -1.5, -1.5) * CFrame.Angles(0, math.rad(-90), 0)
	PLAYER.Character.Torso['Right Hip'].C0 = CFrame.new(1.5, -1, 1.5) * CFrame.Angles(0, math.rad(90), 0)
	PLAYER.Character.Torso['Left Hip'].C0 = CFrame.new(-1.5, -1, 1.5) * CFrame.Angles(0, math.rad(-90), 0)
	local FakeTorso = new('Seat', PLAYER.Character)
	local BF = new('BodyForce', FakeTorso)
	local W = new('Weld', PLAYER.Character.Torso)
	FakeTorso.Name = 'FakeTorso'
	FakeTorso.TopSurface = 0
	FakeTorso.BottomSurface = 0
	FakeTorso.Size = Vector3.new(3,1,4)
	FakeTorso.BrickColor = BrickColor.new('Brown')
	FakeTorso.CFrame = PLAYER.Character.Torso.CFrame
	BF.Force = Vector3.new(0, FakeTorso:GetMass() * 196.25, 0)
	W.Part0 = PLAYER.Character.Torso
	W.Part1 = FakeTorso
	W.C0 = CFrame.new(0, -0.5, 0)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new('Brown')
		end
	end
end

function ALIEN(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		if v:IsA('Shirt') or v:IsA('Pants') or v:IsA('Accessory') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		elseif v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			v.BrickColor = BrickColor.new('Fossil')
		end
	end
	ALIEN_H:Clone().Parent = PLAYER.Character
end

function DECALSPAM(INSTANCE, ID)
	for i,v in pairs(INSTANCE:GetChildren()) do
		if v:IsA('BasePart') then
			spawn(function()
				local FACES = {'Back', 'Bottom', 'Front', 'Left', 'Right', 'Top'}
				local CURRENT_FACE = 1
				for i = 1, 6 do
					local DECAL = new('Decal', v)
					DECAL.Name = 'decal_seth'
					DECAL.Texture = 'rbxassetid://' .. ID - 1
					DECAL.Face = FACES[CURRENT_FACE]
					CURRENT_FACE = CURRENT_FACE + 1
				end
			end)
		end
		DECALSPAM(v, ID)
	end
end

function UNDECALSPAM(INSTANCE)
	for i,v in pairs(INSTANCE:GetChildren()) do
		if v:IsA('BasePart') then
			for a,b in pairs(v:GetChildren()) do
				if b:IsA('Decal') and b.Name == 'decal_seth' then
					b:destroy()
				end
			end
		end
		UNDECALSPAM(v)
	end
end

function CREATE_DONG(PLAYER, DONG_COLOR)
	if PLAYER.Character:FindFirstChild('DONG') then
		PLAYER.Character.DONG:destroy()
	end
	local D = new('Model', PLAYER.Character)
	D.Name = 'DONG'

	local BG = new('BodyGyro', PLAYER.Character.Torso)
	local MAIN = new('Part', PLAYER.Character['DONG'])
	local M1 = new('CylinderMesh', MAIN)
	local W1 = new('Weld', PLAYER.Character.Head)
	local P1 = new('Part', PLAYER.Character['DONG'])
	local M2 = new('SpecialMesh', P1)
	local W2 = new('Weld', P1)
	local B1 = new('Part', PLAYER.Character['DONG'])
	local M3 = new('SpecialMesh', B1)
	local W3 = new('Weld', B1)
	local B2 = new('Part', PLAYER.Character['DONG'])
	local M4 = new('SpecialMesh', B2)
	local W4 = new('Weld', B2)
	MAIN.TopSurface = 0 MAIN.BottomSurface = 0 MAIN.Name = 'Main' MAIN.Size = Vector3.new(0.6, 2.5, 0.6) MAIN.BrickColor = BrickColor.new(DONG_COLOR) MAIN.Position = PLAYER.Character.Head.Position MAIN.CanCollide = false
	W1.Part0 = MAIN W1.Part1 = PLAYER.Character.Head W1.C0 = CFrame.new(0, 0.25, 2.1) * CFrame.Angles(math.rad(45), 0, 0)
	P1.Name = 'Mush' P1.BottomSurface = 0 P1.TopSurface = 0 P1.Size = Vector3.new(0.6, 0.6, 0.6) P1.CFrame = CFrame.new(MAIN.Position) P1.BrickColor = BrickColor.new('Pink') P1.CanCollide = false
	M2.MeshType = 'Sphere'
	W2.Part0 = MAIN W2.Part1 = P1 W2.C0 = CFrame.new(0, 1.3, 0)
	B1.Name = 'Left Ball' B1.BottomSurface = 0 B1.TopSurface = 0 B1.CanCollide = false B1.Size = Vector3.new(1, 1, 1) B1.CFrame = CFrame.new(PLAYER.Character['Left Leg'].Position) B1.BrickColor = BrickColor.new(DONG_COLOR)
	M3.Parent = B1 M3.MeshType = 'Sphere'
	W3.Part0 = PLAYER.Character['Left Leg'] W3.Part1 = B1 W3.C0 = CFrame.new(0, 0.5, -0.5)
	B2.Name = 'Right Ball' B2.BottomSurface = 0 B2.CanCollide = false B2.TopSurface = 0 B2.Size = Vector3.new(1, 1, 1) B2.CFrame = CFrame.new(PLAYER.Character['Right Leg'].Position) B2.BrickColor = BrickColor.new(DONG_COLOR)
	M4.MeshType = 'Sphere'
	W4.Part0 = PLAYER.Character['Right Leg'] W4.Part1 = B2 W4.C0 = CFrame.new(0, 0.5, -0.5)
end

function SCALE(C, S)
	if tonumber(S) < 0.5 then S = 0.5 elseif tonumber(S) > 25 then S = 25 end

	local HAT_CLONE = {}

	for i,v in pairs(C:GetChildren()) do if v:IsA('Accessory') then local HC = v:Clone() table.insert(HAT_CLONE, HC) v:destroy() end end

	local HEAD = C.Head
	local TORSO = C.Torso
	local LA = C['Left Arm']
	local RA = C['Right Arm']
	local LL = C['Left Leg']
	local RL = C['Right Leg']
	local HRP = C.HumanoidRootPart

	HEAD.Size = Vector3.new(S * 2, S, S)
	TORSO.Size = Vector3.new(S * 2, S * 2, S)
	LA.Size = Vector3.new(S, S * 2, S)
	RA.Size = Vector3.new(S, S * 2, S)
	LL.Size = Vector3.new(S, S * 2, S)
	RL.Size = Vector3.new(S, S * 2, S)
	HRP.Size = Vector3.new(S * 2, S * 2, S)

	local M1 = new('Motor6D', TORSO)
	local M2 = new('Motor6D', TORSO)
	local M3 = new('Motor6D', TORSO)
	local M4 = new('Motor6D', TORSO)
	local M5 = new('Motor6D', TORSO)
	local M6 = new('Motor6D', HRP)

	M1.Name = 'Neck' M1.Part0 = TORSO M1.Part1 = HEAD M1.C0 = CFrame.new(0, 1 * S, 0) * CFrame.Angles(-1.6, 0, 3.1) M1.C1 = CFrame.new(0, -0.5 * S, 0) * CFrame.Angles(-1.6, 0, 3.1)
	M2.Name = 'Left Shoulder' M2.Part0 = TORSO M2.Part1 = LA M2.C0 = CFrame.new(-1 * S, 0.5 * S, 0) * CFrame.Angles(0, -1.6, 0) M2.C1 = CFrame.new(0.5 * S, 0.5 * S, 0) * CFrame.Angles(0, -1.6, 0)
	M3.Name = 'Right Shoulder' M3.Part0 = TORSO M3.Part1 = RA M3.C0 = CFrame.new(1 * S, 0.5 * S, 0) * CFrame.Angles(0, 1.6, 0) M3.C1 = CFrame.new(-0.5 * S, 0.5 * S, 0) * CFrame.Angles(0, 1.6, 0)
	M4.Name  = 'Left Hip' M4.Part0 = TORSO M4.Part1 = LL M4.C0 = CFrame.new(-1 * S, -1 * S, 0) * CFrame.Angles(0, -1.6, 0) M4.C1 = CFrame.new(-0.5 * S, 1 * S, 0) * CFrame.Angles(0, -1.6, 0)
	M5.Name = 'Right Hip' M5.Part0 = TORSO M5.Part1 = RL M5.C0 = CFrame.new(1 * S, -1 * S, 0) * CFrame.Angles(0, 1.6, 0) M5.C1 = CFrame.new(0.5 * S, 1 * S, 0) * CFrame.Angles(0, 1.6, 0)
	M6.Name = 'RootJoint' M6.Part0 = HRP M6.Part1 = TORSO M6.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(-1.6, 0, -3.1) M6.C1 = CFrame.new(0, 0, 0) * CFrame.Angles(-1.6, 0, -3.1)

	for i,v in pairs(HAT_CLONE) do v.Parent = C end
end

function CAPE(COLOR)
	if LP.Character:FindFirstChild('Cape') then LP.Character.Cape:destroy() end

	repeat wait() until LP and LP.Character and LP.Character:FindFirstChild('Torso')

	local T = LP.Character.Torso

	local C = new('Part', T.Parent)
	C.Name = 'cape_seth'
	C.Anchored = false
	C.CanCollide = false
	C.TopSurface = 0
	C.BottomSurface = 0
	C.BrickColor = BrickColor.new(COLOR)
	C.Material = 'Neon'
	C.Size = Vector3.new(0.2, 0.2, 0.2)

	local M = new('BlockMesh', C)
	M.Scale = Vector3.new(9, 17.5, 0.5)

	local M1 = new('Motor', C)
	M1.Part0 = C
	M1.Part1 = T
	M1.MaxVelocity = 1
	M1.C0 = CFrame.new(0, 1.75, 0) * CFrame.Angles(0, math.rad(90), 0)
	M1.C1 = CFrame.new(0, 1, .45) * CFrame.Angles(0, math.rad(90), 0)

	local WAVE = false

	repeat wait(1 / 44)
		local ANG = 0.2
		local oldMag = T.Velocity.magnitude
		local MV = 0.1

		if WAVE then
			ANG = ANG + ((T.Velocity.magnitude / 10) * 0.05) + 1
			WAVE = false
		else
			WAVE = false
		end
		ANG = ANG + math.min(T.Velocity.magnitude / 30, 1)
		M1.MaxVelocity = math.min((T.Velocity.magnitude / 10), 0.04) + MV
		M1.DesiredAngle = -ANG
		if M1.CurrentAngle < -0.05 and M1.DesiredAngle > -.05 then
			M1.MaxVelocity = 0.04
		end
		repeat
			wait()
		until M1.CurrentAngle == M1.DesiredAngle or math.abs(T.Velocity.magnitude - oldMag)  >= (T.Velocity.magnitude / 10) + 1
		if T.Velocity.magnitude < 0.1 then
			wait(0.1)
		end
	until not C or C.Parent ~= T.Parent
end

function INFECT(PLAYER)
	for i,v in pairs(PLAYER.Character:GetChildren()) do
		new('Folder', PLAYER.Character).Name = 'infected_seth'
		if v:IsA('Accessory') or v:IsA('Shirt') or v:IsA('Pants') then
			v:destroy()
		elseif v:IsA('ShirtGraphic') then
			v.Archivable = false
			v.Graphic = ''
		end
	end

	if PLAYER.Character.Head:FindFirstChild('face') then
		PLAYER.Character.Head.face.Texture = 'rbxassetid://7074882'
	end

	for i,v in pairs (PLAYER.Character:GetChildren()) do
		if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
			if v.Name == 'Head' or v.Name == 'Left Arm' or v.Name == 'Right Arm' then
				v.BrickColor = BrickColor.new('Medium green')
			elseif v.Name == 'Torso' or v.Name == 'Left Leg' or v.Name == 'Right Leg' then
				v.BrickColor = BrickColor.new('Brown')
			end
		end
	end

	local T = PLAYER.Character.Torso.Touched:connect(function(TC)
		if not TC.Parent:FindFirstChild('infected_seth') then
			local GPFC = _PLAYERS:GetPlayerFromCharacter(TC.Parent)
			if GPFC then
				INFECT(GPFC)
			end
		end
	end)
end

function RESPAWN(PLAYER)
	local M = new('Model', workspace) M.Name = 'respawn_seth'
	local T = new('Part', M) T.Name = 'Torso' T.CanCollide = false T.Transparency = 1
	new('Humanoid', M)
	PLAYER.Character = M
end

function LOAD_MESSAGE(STRING)
	_PLAYERS.LocalPlayer.CharacterAppearanceId = 20018
	RESPAWN(LP)

	R = false
	LP.CharacterAdded:connect(function()
		if not R then
			wait(0.5)
			if LP.Character:FindFirstChild('Humanoid') then
				MAIN_HAT = LP.Character:FindFirstChild('BunnyEarsOfCaprice'):Clone()
			end
			R = true
		end
	end)
	repeat wait() until R
	RESPAWN(LP)
	LP.CharacterAppearanceId = 0

	if MAIN_HAT then
		MAIN_HAT.Handle.CanCollide = true
		local M = MAIN_HAT.Handle.BunnyTools.EggScript3:Clone()
		local P = new('Part')
		M.Disabled = false
		M.Parent = P
		MAIN_HAT.Handle.BunnyTools.EggMesh3:Clone().Parent = P
		MAIN_HAT:destroy()
		P.Parent = LP.Character
		repeat wait() until LP:FindFirstChild('ChessMsg')
		MG = LP:FindFirstChild('ChessMsg')
		MG.Name = 'message_seth'
		MG.Text = ''
		MG.Parent = workspace
		MESSAGE(STRING)
		P:destroy()
		for i,v in pairs(workspace:GetChildren()) do
			if v:IsA('Part') and v.BrickColor == BrickColor.new('Bright red') and v.Reflectance == 0 and v.Transparency == 0 and not v.Anchored and v.CanCollide and v.Locked and v:FindFirstChild('Decal') and v.Size == Vector3.new(8, 0.4, 8) then
				if v.Decal.Texture == 'http://www.roblox.com/asset/?id=1531000' and v.Transparency == 0 and v.Decal.Face == Enum.NormalId.Top then
					v:destroy()
				end
			end
		end
	end
end

function MESSAGE(STRING)
	if not SHOWING_MESSAGE then
		spawn(function()
			SHOWING_MESSAGE = true
			MG.Text = STRING
			wait(5)
			MG.Text = ''
			SHOWING_MESSAGE = false
		end)
	end
end

_G.CLICK_TP = false
local M_CTRL = false

MOUSE.KeyDown:connect(function(K) if K:byte() == 50 then M_CTRL = true end end)
MOUSE.KeyUp:connect(function(K) if K:byte() == 50 then M_CTRL = false end end)
MOUSE.Button1Down:connect(function() if _G.CLICK_TP and M_CTRL and MOUSE.Target and LP.Character and LP.Character:FindFirstChild('HumanoidRootPart') then LP.Character.HumanoidRootPart.CFrame = CFrame.new(MOUSE.Hit.p) + Vector3.new(0, 3, 0) end end)

_LIGHTING.Outlines = false -- / outlines are gross

if FIND_IN_TABLE(BANS, LP.userId) then LP:Kick() end

for i,v in pairs(_PLAYERS:GetPlayers()) do if FIND_IN_TABLE(BANS, v.userId) then table.insert(KICKS, v) else UPDATE_CHAT(v) end end

-- / commands

ADD_COMMAND('ff','ff [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		new('ForceField', _PLAYERS[v].Character)
	end
end)

ADD_COMMAND('unff','unff [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			if v:IsA('ForceField') then
				v:destroy()
			end
		end
	end
end)

ADD_COMMAND('fire','fire [plr] [r] [g] [b]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
				local F = new('Fire', v)
				if ARGS[2] and ARGS[3] and ARGS[4] then
					F.Color = C3(ARGS[2], ARGS[3], ARGS[4])
					F.SecondaryColor = C3(ARGS[2], ARGS[3], ARGS[4])
				end
			end
		end
	end
end)

ADD_COMMAND('unfire','unfire [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			for i,v in pairs(v:GetChildren()) do
				if v:IsA('Fire') then
					v:destroy()
				end
			end
		end
	end
end)

ADD_COMMAND('sp','sp [plr] [r] [g] [b]',{'sparkles'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
				if ARGS[2] and ARGS[3] and ARGS[4] then
					new('Sparkles', v).Color = C3(ARGS[2], ARGS[3], ARGS[4])
				else
					new('Sparkles', v)
				end
			end
		end
	end
end)

ADD_COMMAND('unsp','unsp [plr]',{'unsparkles'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			for i,v in pairs(v:GetChildren()) do
				if v:IsA('Sparkles') then
					v:destroy()
				end
			end
		end
	end
end)

ADD_COMMAND('smoke','smoke [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		new('Smoke', _PLAYERS[v].Character.Torso)
	end
end)

ADD_COMMAND('unsmoke','unsmoke [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character.Torso:GetChildren()) do
			if v:IsA('Smoke') then
				v:destroy()
			end
		end
	end
end)

ADD_COMMAND('btools','btools [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		new('HopperBin', _PLAYERS[v].Backpack).BinType = 1
		new('HopperBin', _PLAYERS[v].Backpack).BinType = 2
		new('HopperBin', _PLAYERS[v].Backpack).BinType = 3
		new('HopperBin', _PLAYERS[v].Backpack).BinType = 4
	end
end)

ADD_COMMAND('pbstools','pbstools [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].PersonalServerRank = 255
	end
end)

ADD_COMMAND('god','god [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			PCHAR.Humanoid.MaxHealth = math.huge PCHAR.Humanoid.Health = PCHAR.Humanoid.MaxHealth
		end
	end
end)

ADD_COMMAND('sgod','sgod [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			PCHAR.Humanoid.MaxHealth = 10000000 PCHAR.Humanoid.Health = PCHAR.Humanoid.MaxHealth
		end
	end
end)

ADD_COMMAND('ungod','ungod [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then 
			PCHAR.Humanoid.MaxHealth = 100 
		end
	end
end)

ADD_COMMAND('heal','heal [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			PCHAR.Humanoid.Health = PCHAR.Humanoid.MaxHealth
		end
	end
end)

ADD_COMMAND('freeze','freeze [plr]',{'frz'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(PLAYERS) do
			local PCHAR = _PLAYERS[v].Character
			for i,v in pairs(PCHAR:GetChildren()) do
				if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
					v.Anchored = true
				end
			end
		end
	end
end)

ADD_COMMAND('thaw','thaw [plr]',{'unfreeze','unfrz'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(PLAYERS) do
			for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
				if v:IsA('Part') then
					v.Anchored = false
				end
			end
		end
	end
end)

ADD_COMMAND('kill','kill [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character:BreakJoints()
	end
end)

ADD_COMMAND('sound','sound [id]',{'music', 'song'},
function(ARGS, SPEAKER)
	for i,v in pairs(workspace:GetChildren()) do if v:IsA('Sound') then v:Stop() v:destroy() end end
	if ARGS[1]:lower() ~= 'off' then
		local S = new('Sound', workspace) S.Name = 'song_seth' S.Archivable = false S.Looped = true S.SoundId = 'rbxassetid://' .. ARGS[1] S.Volume = 1 S:Play()
	end
end)

ADD_COMMAND('volume','volume [int]',{},
function(ARGS, SPEAKER)
	for i,v in pairs(workspace:GetChildren()) do if v:IsA('Sound') then v.Volume = ARGS[1] end end
end)

ADD_COMMAND('pitch','pitch [int]',{},
function(ARGS, SPEAKER)
	for i,v in pairs(workspace:GetChildren()) do if v:IsA('Sound') then v.Pitch = ARGS[1] end end
end)

ADD_COMMAND('explode','explode [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Torso') then
			new('Explosion', PCHAR).Position = PCHAR.Torso.Position					
		end
	end
end)

ADD_COMMAND('invis','invis [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
				v.Transparency = 1
			end
			if v:IsA('Accessory') and v:FindFirstChild('Handle') then
				v.Handle.Transparency = 1
			end
		end
		if PCHAR.Head:FindFirstChild('face') then PCHAR.Head.face.Transparency = 1 end
	end
end)

ADD_COMMAND('vis','vis [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
				v.Transparency = 0
			end
			if v:IsA('Accessory') and v:FindFirstChild('Handle') then
				v.Handle.Transparency = 0
			end
		end
		if PCHAR.Head:FindFirstChild('face') then PCHAR.Head.face.Transparency = 0 end
	end
end)

ADD_COMMAND('goto','goto [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR then
			SPEAKER.Character.HumanoidRootPart.CFrame = PCHAR.Torso.CFrame
		end
	end
end)

ADD_COMMAND('bring','bring [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.HumanoidRootPart.CFrame = SPEAKER.Character.Torso.CFrame
	end
end)

ADD_COMMAND('tp','tp [plr] [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS1, PLAYERS2 = GET_PLAYER(ARGS[1], SPEAKER), GET_PLAYER(ARGS[2], SPEAKER)
	for i,v in pairs(PLAYERS1) do for a,b in pairs(PLAYERS2) do
			if _PLAYERS[v].Character and _PLAYERS[b].Character then
				_PLAYERS[v].Character.HumanoidRootPart.CFrame = _PLAYERS[b].Character.Torso.CFrame
			end
		end end
end)

ADD_COMMAND('char','char [plr] [id]',{'charapp'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].CharacterAppearanceId = ARGS[2]
		_PLAYERS[v].Character:BreakJoints()
	end
end)

ADD_COMMAND('ws','ws [plr] [int]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			PCHAR.Humanoid.WalkSpeed = tonumber(ARGS[2])
		end
	end
end)

ADD_COMMAND('time','time [int]',{},
function(ARGS, SPEAKER)
	_LIGHTING:SetMinutesAfterMidnight(tonumber(ARGS[1]) * 60)
end)

ADD_COMMAND('kick','kick [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		table.insert(KICKS, _PLAYERS[v])
	end
end)

ADD_COMMAND('ban','ban [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		table.insert(BANS, _PLAYERS[v].userId)
		table.insert(KICKS, _PLAYERS[v])
		UPDATE_BANS()
	end
end)

ADD_COMMAND('unban','unban [username]',{},
function(ARGS, SPEAKER)
	if FIND_IN_TABLE(BANS, game.Players:GetUserIdFromNameAsync(ARGS[1])) then
		table.remove(BANS, GET_IN_TABLE(BANS, game.Players:GetUserIdFromNameAsync(ARGS[1])))
		UPDATE_BANS()
	end
end)

ADD_COMMAND('unlockws','unlock',{'unlock'},
function(ARGS, SPEAKER)
	local function UNLOCK(INSTANCE) 
		for i,v in pairs(INSTANCE:GetChildren()) do
			if v:IsA('BasePart') then
				v.Locked = false
			end
			UNLOCK(v)
		end
	end
	UNLOCK(workspace)
end)

ADD_COMMAND('lockws','lock',{'lock'},
function(ARGS, SPEAKER)
	local function LOCK(INSTANCE) 
		for i,v in pairs(INSTANCE:GetChildren()) do
			if v:IsA('BasePart') then
				v.Locked = true
			end
			LOCK(v)
		end
	end
	LOCK(workspace)
end)

ADD_COMMAND('unanchorws','unanchor',{'unanchor'},
function(ARGS, SPEAKER)
	local function UNANCHOR(INSTANCE) 
		for i,v in pairs(INSTANCE:GetChildren()) do
			if v:IsA('BasePart') then
				v.Anchored = false
			end
			UNANCHOR(v)
		end
	end
	UNANCHOR(workspace)
end)

ADD_COMMAND('anchorws','anchor',{'anchor'},
function(ARGS, SPEAKER)
	local function ANCHOR(INSTANCE) 
		for i,v in pairs(INSTANCE:GetChildren()) do
			if v:IsA('BasePart') then
				v.Anchored = true
			end
			ANCHOR(v)
		end
	end
	ANCHOR(workspace)
end)

ADD_COMMAND('hsize','hsize [plr] [int]',{'hatsize'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			if v:IsA('Accessory') then
				for a,b in pairs(v.Handle:GetChildren()) do
					if b:IsA('SpecialMesh') then
						b.Scale = ARGS[2] * Vector3.new(1, 1, 1)
					end
				end
			end
		end
	end
end)

ADD_COMMAND('shats','shats [plr]',{'stealhats'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			if v:IsA('Accessory') then
				v.Parent = SPEAKER.Character
			end
		end
	end
end)

ADD_COMMAND('rhats','rhats [plr]',{'removehats'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			PCHAR.Humanoid:RemoveAccessories()
		end
	end
end)

ADD_COMMAND('firstp','firstp [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].CameraMode = 'LockFirstPerson'
	end
end)

ADD_COMMAND('thirdp','thirdp [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].CameraMode = 'Classic'
	end
end)

ADD_COMMAND('chat','chat [plr] [string]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		game.Chat:Chat(_PLAYERS[v].Character.Head, GLS(false, 1))
	end
end)

ADD_COMMAND('name','name [plr] [string]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.Name = GLS(false, 1)
	end
end)

ADD_COMMAND('unname','unname [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.Name = _PLAYERS[v].Name
	end
end)

ADD_COMMAND('noname','noname [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.Name = ''
	end
end)

ADD_COMMAND('stun','stun [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		PCHAR.Humanoid.PlatformStand = true
	end
end)

ADD_COMMAND('unstun','unstun [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		PCHAR.Humanoid.PlatformStand = false
	end
end)

ADD_COMMAND('guest','guest [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		_PLAYERS[v].CharacterAppearanceId = 1
		PCHAR:BreakJoints()
	end
end)

ADD_COMMAND('noob','noob [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		_PLAYERS[v].CharacterAppearanceId = 155902847
		PCHAR:BreakJoints()
	end
end)

ADD_COMMAND('damage','damage [plr] [int]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.Humanoid:TakeDamage(ARGS[2])
	end
end)

ADD_COMMAND('view','view [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		workspace.CurrentCamera.CameraSubject = PCHAR
	end
end)

ADD_COMMAND('unview','unview',{},
function()
	workspace.CurrentCamera.CameraSubject = _PLAYERS.LocalPlayer.Character
end)

ADD_COMMAND('nolimbs','nolimbs [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			local LIMB = PCHAR.Humanoid:GetLimb(v)
			if v:IsA('BasePart') and PCHAR:FindFirstChild('Humanoid') and LIMB ~= Enum.Limb.Unknown and LIMB ~= Enum.Limb.Head and LIMB ~= Enum.Limb.Torso then
				v:destroy()
			end
		end
	end	
end)

ADD_COMMAND('box','box [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		local SB = new('SelectionBox', PCHAR)
		SB.Adornee = SB.Parent
		SB.Color = BrickColor.new('' .. (ARGS[2]))
	end
end)

ADD_COMMAND('unbox','nobox [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(_PLAYERS[v].Character:GetChildren()) do
			if v:IsA('SelectionBox') then
				v:destroy()
			end
		end
	end
end)

ADD_COMMAND('ghost','ghost [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
				v.Transparency = 0.5
			elseif v:IsA('Accessory') and v:FindFirstChild('Handle') then
				v.Handle.Transparency = 0.5
			elseif PCHAR.Head:FindFirstChild('face') then
				PCHAR.Head.face.Transparency = 0.5
			end
		end
	end
end)

ADD_COMMAND('sphere','sphere [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR=_PLAYERS[v].Character
		local SS = new('SelectionSphere', PCHAR)
		SS.Adornee = SS.Parent
	end
end)

ADD_COMMAND('sky','sky [id]',{},
function(ARGS, SPEAKER)
	if ARGS[1] then
		for i,v in pairs(_LIGHTING:GetChildren()) do if v:IsA('Sky') then v:destroy() end end
		local SKIES = {'Bk', 'Dn', 'Ft', 'Lf', 'Rt', 'Up'}
		local SKY = new('Sky', _LIGHTING)
		for i,v in pairs(SKIES) do
			SKY['Skybox' .. v] = 'rbxassetid://' .. ARGS[1] - 1
		end
	end
end)

ADD_COMMAND('ambient','ambient [r] [g] [b]',{},
function(ARGS, SPEAKER)
	if ARGS[1] and ARGS[2] and ARGS[3] then
		_LIGHTING.Ambient = C3(ARGS[1], ARGS[2], ARGS[3])
	end
end)

ADD_COMMAND('jail','jail [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if FIND_IN_TABLE(JAILED, _PLAYERS[v].Name) then return end
		table.insert(JAILED, _PLAYERS[v].Name)
		local PCHAR = _PLAYERS[v].Character
		local J = JAIL:Clone() J.Parent = workspace J:MoveTo(PCHAR.Torso.Position) J.Name = 'JAIL_' .. _PLAYERS[v].Name
		repeat wait()
			PCHAR = _PLAYERS[v].Character if PCHAR and PCHAR:FindFirstChild('HumanoidRootPart') and J:FindFirstChild('MAIN') then PCHAR.HumanoidRootPart.CFrame = J.MAIN.CFrame + Vector3.new(0, 1, 0) end
		until not FIND_IN_TABLE(JAILED, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('unjail','unjail [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for a,b in pairs(JAILED) do if b == _PLAYERS[v].Name then table.remove(JAILED, a) end end
		if workspace:FindFirstChild('JAIL_' .. _PLAYERS[v].Name) then workspace['JAIL_' .. _PLAYERS[v].Name]:destroy() end
	end
end)

ADD_COMMAND('animation','animation [plr] [id]',{'anim'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local ID = ARGS[2]
		if ARGS[2] == 'climb' then ID = '180436334' end
		if ARGS[2] == 'fall' then ID = '180436148' end
		if ARGS[2] == 'jump' then ID = '125750702' end
		if ARGS[2] == 'sit' then ID = '178130996' end
		for a,b in pairs(_PLAYERS[v].Character.Animate:GetChildren()) do
			if b:IsA('StringValue') then
				for c,d in pairs(b:GetChildren()) do
					if d:IsA('Animation') then
						d.AnimationId = 'rbxassetid://' .. ID
					end
				end
			end
		end
	end
end)

ADD_COMMAND('fix','fix [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('creeper','creeper [plr]',{'crpr'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		CREEPER(_PLAYERS[v])
	end
end)

ADD_COMMAND('uncreeper','uncreeper [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('shrek','shrek [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		SHREK(_PLAYERS[v])
	end
end)

ADD_COMMAND('unshrek','unshrek [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('nuke','nuke [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		spawn(function()
			if _PLAYERS[v] and PCHAR and PCHAR:FindFirstChild('Torso')  then
				local N = new('Part', workspace)
				N.Name = 'nuke_seth'
				N.Anchored = true
				N.CanCollide = false
				N.Shape = 'Ball'
				N.Size = Vector3.new(1, 1, 1)
				N.BrickColor = BrickColor.new('New Yeller')
				N.Transparency = 0.5
				N.Reflectance = 0.2
				N.TopSurface = 0
				N.BottomSurface = 0
				N.Touched:connect(function(T)
					if T and T.Parent then
						local E = new('Explosion', workspace)
						E.Position = T.Position
						E.BlastRadius = 20
						E.BlastPressure = math.huge
					end
				end)
				local CF = PCHAR.Torso.CFrame
				N.CFrame = CF
				for i = 1,30 do
					N.Size = N.Size + Vector3.new(5, 5, 5)
					N.CFrame = CF
					wait(1 / 44)
				end
				N:destroy()
			end
		end)
	end
end)

ADD_COMMAND('unnuke','nonuke',{},
function(ARGS, SPEAKER)
	for i,v in pairs(workspace:GetChildren()) do
		if v:IsA('Part') and v.Name == 'nuke_seth' then
			v:destroy()
		end
	end
end)

ADD_COMMAND('infect','infect [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		INFECT(_PLAYERS[v])
	end
end)

ADD_COMMAND('uninfect','uninfect [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('duck','duck [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		DUCK(_PLAYERS[v])
	end
end)

ADD_COMMAND('unduck','unduck [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('disable','disable [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			PCHAR.Humanoid.Name = 'HUMANOID_' .. _PLAYERS[v].Name
			local humanoid = PCHAR['HUMANOID_' .. _PLAYERS[v].Name]
			humanoid.Parent = HUMANOIDS
		end
	end
end)

ADD_COMMAND('enable','enable [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			return
		else
			if HUMANOIDS:FindFirstChild('HUMANOID_' .. _PLAYERS[v].Name) then
				local humanoid = HUMANOIDS['HUMANOID_' .. _PLAYERS[v].Name] humanoid.Parent = PCHAR humanoid.Name = 'Humanoid'
			end
		end
	end
end)

ADD_COMMAND('size','size [plr] [int]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		SCALE(_PLAYERS[v].Character, ARGS[2])
	end
end)

ADD_COMMAND('clone','clone [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character PCHAR.Archivable = true
		local C = PCHAR:Clone() C.Parent = workspace C:MoveTo(PCHAR:GetModelCFrame().p) C:MakeJoints()
		PCHAR.Archivable = false
	end
end)

ADD_COMMAND('spin','spin [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR.Torso:GetChildren()) do
			if v.Name == 'SPIN' then
				v:destroy()
			end
		end
		local T = PCHAR.Torso
		local BG = new('BodyGyro', T) BG.Name = 'SPIN' BG.maxTorque = Vector3.new(0, math.huge, 0) BG.P = 11111 BG.cframe = T.CFrame
		spawn(function()
			repeat wait(1/44)
				BG.CFrame = BG.CFrame * CFrame.Angles(0,math.rad(30),0)
			until not BG or BG.Parent ~= T
		end)
	end
end)

ADD_COMMAND('unspin','unspin [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR.Torso:GetChildren()) do
			if v.Name == 'SPIN' then
				v:destroy()
			end
		end
	end
end)

ADD_COMMAND('dog','dog [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		DOG(_PLAYERS[v])
	end
end)

ADD_COMMAND('undog','undog [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('loopheal','loopheal [plr]',{'lheal'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if not FIND_IN_TABLE(LOOPED_H, _PLAYERS[v].Name) then
			table.insert(LOOPED_H, _PLAYERS[v].Name)
		end
	end
end)

ADD_COMMAND('unloopheal','unloopheal [plr]',{'unlheal'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if FIND_IN_TABLE(LOOPED_H, _PLAYERS[v].Name) then
			table.remove(LOOPED_H, GET_IN_TABLE(LOOPED_H, _PLAYERS[v].Name))
		end
	end
end)

ADD_COMMAND('loopkill','loopheal [plr]',{'lheal'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if not FIND_IN_TABLE(LOOPED_K, _PLAYERS[v].Name) then
			table.insert(LOOPED_K, _PLAYERS[v].Name)
		end
	end
end)

ADD_COMMAND('unloopkill','unloopkill [plr]',{'unlkill'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if FIND_IN_TABLE(LOOPED_K, _PLAYERS[v].Name) then
			table.remove(LOOPED_K, GET_IN_TABLE(LOOPED_K, _PLAYERS[v].Name))
		end
	end
end)

ADD_COMMAND('fling','fling [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then
			
			PCHAR.Torso.Velocity = Vector3.new(0, 0, 0)
			local BF = new('BodyForce', PCHAR.Torso) BF.force = Vector3.new(X * 4, 9999 * 5, Z * 4)
		end
	end
end)

ADD_COMMAND('alien','alien [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		ALIEN(_PLAYERS[v])
	end
end)

ADD_COMMAND('nograv','nograv [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if not _PLAYERS[v].Character.Torso:FindFirstChild('nograv_seth') then
			NEW('BodyForce',{Name = 'nograv_seth', Force = Vector3.new(0, GET_MASS(_PLAYERS[v].Character) * 196.2, 0), Parent = _PLAYERS[v].Character.Torso})
		end
	end
end)

ADD_COMMAND('grav','grav [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if _PLAYERS[v].Character.Torso:FindFirstChild('nograv_seth') then
			_PLAYERS[v].Character.Torso.nograv_seth:destroy()
		end
	end
end)

ADD_COMMAND('cape','cape [brick color]',{},
function(ARGS, SPEAKER)
	spawn(function()
		if LP.Character:FindFirstChild('Cape') then
			LP.Character.Cape:destroy()
		end
		if not ARGS[1] then
			ARGS[1] = 'Deep blue'
		end
		CAPE(GLS(false, 1))
	end)
end)

ADD_COMMAND('uncape','uncape',{},
function(ARGS, SPEAKER)
	if LP.Character:FindFirstChild('cape_seth') then
		LP.Character.cape_seth:destroy()
	end
end)

ADD_COMMAND('paper','paper [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			if v:IsA('Part') and v.Name ~= 'HumanoidRootPart' then
				PAPER_MESH:Clone().Parent = v
			end
		end
	end
end)

ADD_COMMAND('punish','punish [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.Parent = nil
	end
end)

ADD_COMMAND('unpunish','unpunish [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].Character.Parent = workspace
	end
end)

local DISCO = false

ADD_COMMAND('disco','disco',{},
function(ARGS, SPEAKER)
	DISCO = true
	if not DISCO then
		spawn(function()
			repeat wait(1) _LIGHTING.Ambient = C3(math.random(), math.random(), math.random()) until not DISCO
		end)
	end
end)

ADD_COMMAND('undisco','undisco',{},
function(ARGS, SPEAKER)
	DISCO = false
end)

ADD_COMMAND('team','team [plr] [team]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for a,b in pairs(game.Teams:GetChildren()) do
			if string.lower(b.Name) == GLS(true, 1) then
				_PLAYERS[v].Team = b
			end
		end
	end
end)

ADD_COMMAND('jp','jp [plr] [int]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then PCHAR.Humanoid.JumpPower = ARGS[2] end
	end
end)

ADD_COMMAND('smallhead','smallhead [plr]',{'shead'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		PCHAR.Head.Mesh.Scale = Vector3.new(0.5, 0.5, 0.5)
		PCHAR.Head.Mesh.Offset = Vector3.new(0, -0.25, 0)
	end
end)

ADD_COMMAND('bighead','bighead [plr]',{'bhead'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		PCHAR.Head.Mesh.Scale = Vector3.new(2.25, 2.25, 2.25)
		PCHAR.Head.Mesh.Offset = Vector3.new(0, 0.5, 0)
	end
end)

ADD_COMMAND('headsize','headsize [plr] [int]',{'hsize'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if ARGS[2] == 1 then
			PCHAR.Head.Mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
			PCHAR.Head.Mesh.Offset = Vector3.new(0, 0, 0)
		else
			PCHAR.Head.Mesh.Scale = ARGS[2] * Vector3.new(1.25, 1.25, 1.25)
		end
	end
end)

ADD_COMMAND('fixhead','fixhead [plr]',{'fhead'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		PCHAR.Head.Mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
		PCHAR.Head.Mesh.Offset = Vector3.new(0, 0, 0)
		PCHAR.Head.Transparency = 0
		if PCHAR.Head:FindFirstChild('face') then PCHAR.Head.face.Transparency = 0 end
	end
end)

ADD_COMMAND('removehead','removehead [plr]',{'rhead'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		PCHAR.Head.Transparency = 1
		if PCHAR.Head:FindFirstChild('face') then PCHAR.Head.face.Transparency = 1 end
	end
end)

ADD_COMMAND('stealtools','stealtools [plr]',{'stools'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	local lp = game:GetService("Players").LocalPlayer
	local hst = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end
	for _, plr in pairs(PLAYERS) do
		if plr.Character then
			for _, t in ipairs(plr.Character:GetChildren()) do
				if t:IsA("Tool") then h:EquipTool(t) end
			end
			wait()
		end
	end
end)

ADD_COMMAND('removetools','removetools [plr]',{'rtools'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	local lprt = game:GetService("Players").LocalPlayer
	local hrt = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end
	for _, plr in pairs(PLAYERS) do
		if plr.Character then
			for _, t in ipairs(plr.Character:GetChildren()) do
				if t:IsA("Tool") then h:EquipTool(t) end
			end
			wait()
		end
	end
	lp.Character.Humanoid.Health = 0
end)

ADD_COMMAND('clonetools','clonetools [plr]',{'ctools'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		for i,v in pairs(_PLAYERS[v].Backpack:GetChildren()) do
			if v:IsA('Tool') or v:IsA('HopperBin') then
				v:Clone().Parent = LP.Backpack
			end
		end
	end
end)

ADD_COMMAND('dong','dong [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if ARGS[2] == 'black' then
			CREATE_DONG(_PLAYERS[v], 'Brown')
		end
		if ARGS[2] == 'asian' then
			CREATE_DONG(_PLAYERS[v], 'Cool yellow')
		end
		if ARGS[2] == 'alien' then
			CREATE_DONG(_PLAYERS[v], 'Lime green')
		end
		if ARGS[2] == 'frozen' then
			CREATE_DONG(_PLAYERS[v], 1019)
		end
		if not ARGS[2] then
			CREATE_DONG(_PLAYERS[v], 'Pastel brown')
		end
	end
end)

ADD_COMMAND('particles','particles [plr] [id]',{'pts'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR.Torso:GetChildren()) do
			if v:IsA('ParticleEmitter') then
				v:destroy()
			end
		end
		new('ParticleEmitter', PCHAR.Torso).Texture = 'rbxassetid://' .. ARGS[2] - 1
	end
end)

ADD_COMMAND('rocket','rocket [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		spawn(function()
			local R = ROCKET:Clone()
			R.Parent = workspace
			local W = new('Weld', R)
			W.Part0 = W.Parent
			W.Part1 = PCHAR.Torso
			W.C1 = CFrame.new(0, 0.5, 1)
			R.force.Force = Vector3.new(0, 15000, 0)
			wait()
			PCHAR.HumanoidRootPart.CFrame = PCHAR.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
			wait(5)
			new('Explosion', R).Position = R.Position
			wait(1)
			R:destroy()
		end)
	end
end)

ADD_COMMAND('blackify','blackify [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		COLOR(_PLAYERS[v], 'Really black')
	end
end)

ADD_COMMAND('whitify','whitify [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		COLOR(_PLAYERS[v], 'White')
	end
end)

ADD_COMMAND('color','color [plr] [brick color]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		COLOR(_PLAYERS[v], GLS(false, 1))
	end
end)

ADD_COMMAND('change','change [plr] [stat] [int/string]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if _PLAYERS[v]:FindFirstChild('leaderstats') then
			for i,v in pairs(_PLAYERS[v].leaderstats:GetChildren()) do
				if string.lower(v.Name) == string.lower(ARGS[2]) and v:IsA('IntValue') or v:IsA('NumberValue') then
					if ARGS[3] then v.Value = tonumber(ARGS[3]) end
				elseif string.lower(v.Name) == string.lower(ARGS[2]) and v:IsA('StringValue') then
					v.Value = GLS(false, 2)
				end
			end
		end
	end
end)

ADD_COMMAND('bait','bait',{},
function(ARGS, SPEAKER)
	spawn(function()
		local M = new('Model', workspace) M.Name = 'Touch For Admin!'
		local P = new('Part', M) P.Name = 'Head' P.Position = SPEAKER.Character.Head.Position P.BrickColor = BrickColor.new('Pink') P.Material = 'Neon'
		local H = new('Humanoid', M)
		P.Touched:connect(function(RIP) if RIP.Parent.Name ~= SPEAKER.Name or RIP.Parent.Name ~= LP.Name then if RIP.Parent:FindFirstChild('Humanoid') then RIP.Parent.Humanoid:destroy() end end end)
	end)
end)

ADD_COMMAND('naked','naked [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do
			if v:IsA('Accessory') or v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
				v:destroy()
			end
			for i,v in pairs(PCHAR.Torso:GetChildren()) do
				if v:IsA('Decal') then
					v:destroy()
				end
			end
		end
	end
end)

ADD_COMMAND('decalspam','decalspam [decal]',{'dspam'},
function(ARGS, SPEAKER)
	if ARGS[1] then
		DECALSPAM(workspace, ARGS[1])
	end
end)

ADD_COMMAND('undecalspam','undecalspam',{'undspam'},
function(ARGS, SPEAKER)
	if ARGS[1] then
		UNDECALSPAM(workspace)
	end
end)

ADD_COMMAND('bang','bang [plr]',{'rape', 'sex'},
function(ARGS, SPEAKER)
    NOTIFY('Who are you?', 255, 50, 50)
    wait(2)
    NOTIFY('I am Death, said the creature.', 255, 50, 50)
    wait(2)
    NOTIFY('I thought that was obvious.', 255, 50, 50)
    wait(2)
    NOTIFY('But you are so small!', 255, 50, 50)
    wait(2)
    NOTIFY('Only because you are small.', 255, 50, 50)
    wait(2)
    NOTIFY('You are young and far from your Death, September, ...', 255, 50, 50)
    wait(2)
    NOTIFY('... so I seem as anything would seem if you saw it from a long way off ..', 255, 50, 50)
    wait(2)
    NOTIFY('... very small, very harmless.', 255, 50, 50)
    wait(2)
    NOTIFY('But I am always closer than I appear.', 255, 50, 50)
    wait(2)
    NOTIFY('As you grow, I shall grow with you ...', 255, 50, 50)
    wait(2)
    NOTIFY('... until at the end, I shall loom huge and dark over your bed ...', 255, 50, 50)
    wait(2)
    NOTIFY('... and you will shut your eyes so as not to see me.', 255, 50, 50)
    wait(2)
    NOTIFY('Find me.', 255, 50, 50)
    wait(2)
    NOTIFY('Fear me.', 255, 50, 50)
    wait(2)
    NOTIFY('Love me.', 255, 50, 50)
    wait(2)
end)

ADD_COMMAND('lag','lag [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		LAG(_PLAYERS[v])
	end
end)

ADD_COMMAND('respawn','respawn [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		RESPAWN(_PLAYERS[v])
	end
end)

ADD_COMMAND('face','face [plr] [decal]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR.Head:GetChildren()) do if v:IsA('Decal') then v:destroy() end end
		local F = new('Decal', PCHAR.Head) F.Name = 'face' F.Texture = 'rbxassetid://' .. ARGS[2] - 1
	end
end)

ADD_COMMAND('shirt','shirt [plr] [decal]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do if v:IsA('Shirt') then v:destroy() end end
		local S = new('Shirt', PCHAR) S.Name = 'Shirt' S.ShirtTemplate = 'rbxassetid://' .. ARGS[2] - 1
	end
end)

ADD_COMMAND('pants','pants [plr] [decal]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		for i,v in pairs(PCHAR:GetChildren()) do if v:IsA('Pants') then v:destroy() end end
		local P = new('Pants', PCHAR) P.Name = 'Shirt' P.PantsTemplate = 'rbxassetid://' .. ARGS[2] - 1
	end
end)

ADD_COMMAND('longneck','longneck [plr]',{'lneck', 'giraffe'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
		for i,v in pairs(PCHAR:GetChildren()) do if v:IsA('Accessory') then v.Handle.Mesh.Offset = Vector3.new(0, 5, 0) end end
		if PCHAR.Head:FindFirstChild('Mesh') then PCHAR.Head.Mesh.Offset = Vector3.new(0, 5, 0) end
		local G = new('Part', PCHAR) G.Name = 'giraffe_seth' G.BrickColor = PCHAR.Head.BrickColor G.Size = Vector3.new(2, 1, 1)
		local SM = new('SpecialMesh', G) SM.Scale = Vector3.new(1.25, 5, 1.25) SM.Offset = Vector3.new(0, 2, 0)
		local W = new('Weld', G) W.Part0 = PCHAR.Head W.Part1 = G
	end
end)

ADD_COMMAND('stealchar','stealchar [plr]',{'schar'},
function(ARGS, SPEAKER)
	local PLAYERS1, PLAYERS2 = GET_PLAYER(ARGS[1])
	for i,v in pairs(PLAYERS1) do
		RESET_MODEL(SPEAKER.Character) UPDATE_MODEL(SPEAKER.Character, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('baseplate','baseplate',{'bp'},
function(ARGS, SPEAKER)
	for i,v in pairs(workspace:GetChildren()) do if v:IsA('Model') and v.Name == 'baseplate_seth' then v:destroy() end end
	local BP = new('Part', workspace) BP.Name = 'baseplate_seth' BP.Anchored = true BP.BrickColor = BrickColor.new('Bright green') BP.Size = Vector3.new(2048, 5, 2048) BP.Position = Vector3.new(0, 0, 0)
end)

ADD_COMMAND('norotate','norotate [plr]',{'nrt'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then PCHAR.Humanoid.AutoRotate = false end
	end
end)

ADD_COMMAND('rotate','rotate [plr]',{'rt'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Humanoid') then PCHAR.Humanoid.AutoRotate = true end
	end
end)

ADD_COMMAND('admin','admin [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if not CHECK_ADMIN(_PLAYERS[v]) then
			table.insert(ADMINS, _PLAYERS[v].userId)
			UPDATE_ADMINS()
			spawn(function()
				game.Chat:Chat(_PLAYERS[v].Character.Head, STUFF .. 'You\'re now an admin!')
				wait(3)
				game.Chat:Chat(_PLAYERS[v].Character.Head, STUFF .. 'Give me a try! | ' .. C_PREFIX .. 'ff me')
			end)
		end
	end
end)

ADD_COMMAND('unadmin','unadmin [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		if CHECK_ADMIN(_PLAYERS[v]) then
			if FIND_IN_TABLE(ADMINS, _PLAYERS[v].userId) then
				table.remove(ADMINS, GET_IN_TABLE(ADMINS, _PLAYERS[v].userId))
				UPDATE_ADMINS()
				game.Chat:Chat(_PLAYERS[v].Character.Head, STUFF .. 'You\'re no longer an admin.')
			end
		end
	end
end)

ADD_COMMAND('minzoom','minzoom [plr] [int]',{'minz'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].CameraMinZoomDistance = ARGS[2]
	end
end)

ADD_COMMAND('maxzoom','maxzoom [plr] [int]',{'maxz'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		_PLAYERS[v].CameraMaxZoomDistance = ARGS[2]
	end
end)

ADD_COMMAND('age','age [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		NOTIFY(_PLAYERS[v].Name .. ' | ' .. _PLAYERS[v].AccountAge, 255, 255, 255)
	end
end)

ADD_COMMAND('hl','hl [plr] [r] [g] [b]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Torso') then
			local HL = new('SpotLight', PCHAR.Torso) HL.Name = 'seth_hl' HL.Brightness = 5 HL.Range = 60
			if ARGS[2] and ARGS[3] and ARGS[4] then
				HL.Color = C3(ARGS[2], ARGS[3], ARGS[4])
			end
		end
	end
end)

ADD_COMMAND('unhl','unhl [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		if PCHAR:FindFirstChild('Torso') then
			for i,v in pairs(PCHAR.Torso:GetChildren()) do
				if v:IsA('SpotLight') and v.Name == 'seth_hl' then
					v:destroy()
				end
			end
		end
	end
end)

ADD_COMMAND('shutdown','shutdown',{},
function(ARGS, SPEAKER)
	game:Shutdown()
end)

ADD_COMMAND('smite','smite [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		spawn(function()
			local function CastRay(A, B, C) local V = B - A return workspace:FindPartOnRayWithIgnoreList(Ray.new(A, V.unit * math.min(V.magnitude, 999)), C or {}, false, true) end

			local PP = PCHAR.PrimaryPart.Position - Vector3.new(0, 3, 0)
			local S = new('Sound', workspace) S.SoundId = 'rbxassetid://178090362' S.Volume = 1 S:Play() spawn(function() wait(7) S:destroy() end)
			local S,P2 = CastRay(PP, PP - Vector3.new(0, 9, 0), {PCHAR})

			local P1 = new('Part', game.Workspace)
			P1.BrickColor = BrickColor.new('Institutional white')
			P1.Material = 'Neon'
			P1.Transparency = 0.9
			P1.Anchored = true
			P1.CanCollide = false
			P1.Size = Vector3.new(0.2, 0.2, 0.2)
			P1.CFrame = CFrame.new((S and P2 or PP) + Vector3.new(0, 1e3, 0))
			new('BlockMesh', P1).Scale = Vector3.new(10, 10000, 10)

			local P2, P3, P4, P5 = P1:Clone(), P1:Clone(), P1:Clone(), P1:Clone()
			for i, v in next, {P2, P3, P4, P5} do i = i * 0.1 v.Parent, v.Size = P1, Vector3.new(0.2 + i, 0.2, 0.2 + i ) v.CFrame = P1.CFrame end wait(0.5) P1:destroy() PCHAR:BreakJoints()
		end)
	end
end)

ADD_COMMAND('skydive','skydive [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		spawn(function()
			for i = 0, 3 do
				if PCHAR then
					PCHAR.HumanoidRootPart.CFrame = PCHAR.HumanoidRootPart.CFrame + Vector3.new(0, 7500, 0)
				end
			end
		end)
	end
end)

ADD_COMMAND('message','message [string]',{'m'},
function(ARGS, SPEAKER)
	spawn(function()
		if MG then
			MESSAGE(GLS(false, 0))
		else
			LOAD_MESSAGE(GLS(false, 0))
		end
	end)
end)

ADD_COMMAND('control','control [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		local HB = new('HopperBin', LP.Backpack) HB.Name = _PLAYERS[v].Name
		local CONTROL_ENABLED = false
		local function CONTROL(P, V3)
			if CONTROL_ENABLED then
				if P.Character and P.Character:FindFirstChild('Humanoid') then
					P.Character.Humanoid:MoveTo(V3)
				end
			end
		end
		HB.Selected:connect(function(M)
			M.Button1Down:connect(function() CONTROL_ENABLED = true CONTROL(_PLAYERS:FindFirstChild(HB.Name), M.Hit.p) end)
			M.Button1Up:connect(function() CONTROL_ENABLED = false end)
		end)
	end
end)

-- / extra

ADD_COMMAND('gravity','gravity [int]',{},
function(ARGS, SPEAKER)
	workspace.Gravity = ARGS[1]
end)

ADD_COMMAND('fixlighting','fixlighting',{'fixl'},
function(ARGS, SPEAKER)
	FIX_LIGHTING()
end)

ADD_COMMAND('fixfog','fixfog',{'clrfog'},
function(ARGS, SPEAKER)
	_LIGHTING.FogColor = C3(191, 191, 191)
	_LIGHTING.FogEnd = 100000000
	_LIGHTING.FogStart = 0
end)

ADD_COMMAND('day','day',{},
function(ARGS, SPEAKER)
	_LIGHTING.TimeOfDay = 14
end)

ADD_COMMAND('night','night',{},
function(ARGS, SPEAKER)
	_LIGHTING.TimeOfDay = 24
end)

ADD_COMMAND('serverlock','serverlock',{'slock'},
function(ARGS, SPEAKER)
	SERVER_LOCKED = true
end)

ADD_COMMAND('unserverlock','unserverlock',{'unslock'},
function(ARGS, SPEAKER)
	SERVER_LOCKED = false
end)

ADD_COMMAND('fogend','fogend [int]',{},
function(ARGS, SPEAKER)
	_LIGHTING.FogEnd = ARGS[1]
end)

ADD_COMMAND('fogcolor','fogcolor [r] [g] [b]',{},
function(ARGS, SPEAKER)
	if ARGS[1] and ARGS[2] and ARGS[3] then
		_LIGHTING.FogColor = C3(ARGS[1], ARGS[2], ARGS[3])
	end
end)

ADD_COMMAND('noclip','noclip',{},
function(ARGS, SPEAKER)
	NOCLIP = true
	JESUSFLY = false
	SWIM = false
end)

ADD_COMMAND('clip','clip',{},
function(ARGS, SPEAKER)
	NOCLIP = false
end)

ADD_COMMAND('jesusfly','jesusfly',{},
function(ARGS, SPEAKER)
	NOCLIP = false
	JESUSFLY = true
	SWIM = false
end)

ADD_COMMAND('nojfly','nojfly',{},
function(ARGS, SPEAKER)
	JESUSFLY = false
end)

ADD_COMMAND('swim','swim',{},
function(ARGS, SPEAKER)
	NOCLIP = false
	JESUSFLY = false
	SWIM = true
end)

ADD_COMMAND('noswim','noswim',{},
function(ARGS, SPEAKER)
	SWIM = false
end)

ADD_COMMAND('fly','fly',{},
function(ARGS, SPEAKER)
	sFLY()
end)

ADD_COMMAND('unfly','unfly',{},
function(ARGS, SPEAKER)
	NOFLY()
end)

ADD_COMMAND('prefix','prefix [string]',{},
function(ARGS, SPEAKER)
	if ARGS[1] then
		C_PREFIX = ARGS[1]
		NOTIFY('Changed prefix to \'' .. ARGS[1] .. '\'', 255, 255, 255)
	end
end)

ADD_COMMAND('version','version',{},
function(ARGS, SPEAKER)
	NOTIFY('VERSION | ' .. VERSION, 255, 255, 255)
end)

ADD_COMMAND('fe','fe',{},
function(ARGS, SPEAKER)
	spawn(function()
		CHECK_FE()
	end)
end)

--// New Commands
ADD_COMMAND('cake','cake [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		CAKE(_PLAYERS[v])
	end
end)

ADD_COMMAND('spongebob','spongebob [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		SPONGE(_PLAYERS[v])
	end
end)

ADD_COMMAND('iphone','iphone [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		IPHONE(_PLAYERS[v])
	end
end)

ADD_COMMAND('keemstar','keemstar [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		KEEMSTAR(_PLAYERS[v])
	end
end)

ADD_COMMAND('gull','gull [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		GULL(_PLAYERS[v])
	end
end)

ADD_COMMAND('spasm','spasm [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		local AnimationId = "33796059"
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://"..AnimationId
		local k = PCHAR.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(99)
	end
end)

ADD_COMMAND('dance','dance [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		local anim = nil
		local dance1 = math.random(1,7)
		if dance1 == 1 then
			anim = '27789359'
		elseif dance1 == 2 then
			anim = '30196114'
		elseif dance1 == 3 then
			anim = '248263260'
		elseif dance1 == 4 then
			anim = '45834924'
		elseif dance1 == 5 then
			anim = '33796059'
		elseif dance1 == 6 then
			anim = '28488254'
		elseif dance1 == 7 then
			anim = '52155728'
		end
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://"..anim
		local animTrack = PCHAR.Humanoid:LoadAnimation(animation)
		animTrack:Play()
	end
end)

ADD_COMMAND('chickenarms','chickenarms [plr]',{'chicken'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		spawn(function()
			local CHICKEN = _PLAYERS[v].Character
			CHICKEN.Torso["Left Shoulder"].C0 = CFrame.new(-1.5, 0.5, 0) 
				* CFrame.fromEulerAnglesXYZ(0, math.pi/2, 0) 
				* CFrame.fromEulerAnglesXYZ(math.pi/2, 0, 0) 
				* CFrame.fromEulerAnglesXYZ(0, -math.pi/2, 0)
			CHICKEN.Torso["Left Shoulder"].C1 = CFrame.new(0, 0.5, 0)

			CHICKEN.Torso["Right Shoulder"].C0 = CFrame.new(1.5, 0.5, 0) 
				* CFrame.fromEulerAnglesXYZ(0, -math.pi/2, 0) 
				* CFrame.fromEulerAnglesXYZ(math.pi/2, 0, 0) 
				* CFrame.fromEulerAnglesXYZ(0, -math.pi/2, 0)
			CHICKEN.Torso["Right Shoulder"].C1 = CFrame.new(0, 0.5, 0)
		end)
	end
end)

ADD_COMMAND('crucify', 'crucify [plr]', {}, 
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local char = _PLAYERS[v].Character
		local torso = char['Torso']
		local larm = char['Left Arm']
		local rarm = char['Right Arm']
		local lleg = char['Left Leg']
		local rleg = char['Right Leg']
		local head = char['Head']

		if torso and larm and rarm and lleg and rleg and head and not char:FindFirstChild(char.Name..'epixcrusify') then
			local cru = new('Model', char)
			cru.Name = char.Name..'epixcrusify' -- bypasses epixcommands ;)

			local c1 = new('Part', cru)
			c1.BrickColor = BrickColor.new('Reddish brown')
			c1.Material = 'Wood'
			c1.CFrame = (torso.CFrame - torso.CFrame.lookVector) * CFrame.new(0,0,2)
			c1.Size = Vector3.new(2,18.4,1)
			c1.Anchored = true

			local c2 = c1:Clone()
			c2.Parent = cru
			c2.Size = Vector3.new(11,1.6,1)
			c2.CFrame = c1.CFrame + Vector3.new(0,5,0)

			torso.Anchored = true; wait(0.5)
			torso.CFrame = c2.CFrame + torso.CFrame.lookVector + Vector3.new(0,-1,0); wait(0.5)
			larm.Anchored = true
			rarm.Anchored = true
			lleg.Anchored = true
			rleg.Anchored = true
			head.Anchored = true; wait()

			larm.CFrame = torso.CFrame * CFrame.new(-1.5,1,0)
			rarm.CFrame = torso.CFrame * CFrame.new(1.5,1,0)
			lleg.CFrame = torso.CFrame * CFrame.new(-0.1,-1.7,0)
			rleg.CFrame = torso.CFrame * CFrame.new(0.1,-1.7,0)
			larm.CFrame = larm.CFrame * CFrame.Angles(0,0,-140)
			rarm.CFrame = rarm.CFrame * CFrame.Angles(0,0,140)
			lleg.CFrame = lleg.CFrame * CFrame.Angles(0,0,0.6)
			rleg.CFrame = rleg.CFrame * CFrame.Angles(0,0,-0.6)
			-- head.CFrame = head.CFrame * CFrame.Angles(0,0,0.3)

			local n1 = new('Part', cru)
			n1.BrickColor = BrickColor.new('Dark stone grey')
			n1.Material = 'DiamondPlate'
			n1.Size = Vector3.new(0.2,0.2,2)
			n1.Anchored = true
			local m = new('BlockMesh', n1)
			m.Scale = Vector3.new(0.2,0.2,0.7)

			local n2 = n1:Clone()
			n2.Parent = cru
			local n3 = n1:Clone()
			n3.Parent = cru

			n1.CFrame = (c2.CFrame + torso.CFrame.lookVector) * CFrame.new(2,0,0)
			n2.CFrame = (c2.CFrame + torso.CFrame.lookVector) * CFrame.new(-2,0,0)
			n3.CFrame = (c2.CFrame + torso.CFrame.lookVector) * CFrame.new(0,-3,0)

			spawn(function()
				repeat
					wait(0.1)
					char.Humanoid.Health = char.Humanoid.Health - 0.6
				until (not cru) or (not cru.Parent) or (not v) or (not char) or (not char:FindFirstChild('Head')) or char.Humanoid.Health <= 0
				char:BreakJoints()
			end)
		end
	end
end)

ADD_COMMAND('hang', 'hang [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local plr = _PLAYERS[v].Character
		plr.HumanoidRootPart.Anchored = true
		cors = {}
		local mas = new('Model', game:GetService('Lighting'))
		local Model0 = new('Model')
		Model0.Name = 'hang'
		Model0.Parent = mas

		local Part1 = new('Part', Model0)
		Part1.Material = Enum.Material.SmoothPlastic
		Part1.BrickColor = BrickColor.new('Reddish brown')
		Part1.Anchored = true
		Part1.Size = Vector3.new(0.2,0.2,0.6)
		Part1.CFrame = CFrame.new(1.539994, 9.299922, 12.699988)
		Part2 = new('Part', Model0)
		Part2.Material = Enum.Material.Wood
		Part2.BrickColor = BrickColor.new('Pine Cone')
		Part2.Anchored = true
		Part2.Size = Vector3.new(0.5,0.2,0.2)
		Part2.CFrame = CFrame.new(1.44999, 9.099926, 12.699988)
		Part3 = new('Part', Model0)
		Part3.Material = Enum.Material.Wood
		Part3.BrickColor = BrickColor.new('Pine Cone')
		Part3.Anchored = true
		Part3.Size = Vector3.new(1,9.4,0.6)
		Part3.CFrame = CFrame.new(-0.100002,4.700011,12.699988)
		Part4 = new('Part', Model0)
		Part4.Material = Enum.Material.Wood
		Part4.BrickColor = BrickColor.new('Pine Cone')
		Part4.Anchored = true
		Part4.Size = Vector3.new(1,0.6,0.6)
		Part4.CFrame = CFrame.new(0.899998,9.099954,12.699988)
		Part5 = new('Part', Model0)
		Part5.Name = 'main'
		Part5.BrickColor = BrickColor.new('Bright blue')
		Part5.Transparency = 1
		Part5.Rotation = Vector3.new(0,-90,0)
		Part5.Anchored = true
		Part5.CanCollide = false
		Part5.Size = Vector3.new(2,2,1)
		Part5.CFrame = CFrame.new(1.989986,6.330018,12.700024)
		local Motor6D6 = new('Motor6D', Part5)
		Motor6D6.Name = 'RootJoint'
		Motor6D6.Part0 = Part5
		Motor6D6.C0 = CFrame.new(0,0,0)
		Motor6D6.C1 = CFrame.new(0,0,0)
		Part7 = new('Part', Model0)
		Part7.Material = Enum.Material.SmoothPlastic
		Part7.BrickColor = BrickColor.new('Reddish brown')
		Part7.Anchored = true
		Part7.Size = Vector3.new(0.2,0.2,0.8)
		Part7.CFrame = CFrame.new(2.02296,7.370589,12.100006)
		Part8 = new('Part', Model0)
		Part8.Material = Enum.Material.Wood
		Part8.BrickColor = BrickColor.new('Pine Cone')
		Part8.Anchored = true
		Part8.Size = Vector3.new(0.2,0.6,0.6)
		Part8.CFrame = CFrame.new(1.779996,9.099926,12.699988)
		for i,vv in pairs(mas:GetChildren()) do
			vv.Parent = workspace
			pcall(function() vv:MakeJoints() end)
		end
		mas:Destroy()
		for i,vv in pairs(cors) do
			spawn(function() pcall(vv) end)
		end
		local hang = Model0
		hang.Parent = plr
		hang:MoveTo(plr.Torso.Position - Vector3.new(0,0,5))
		pcall(function()
			plr.HumanoidRootPart.CFrame = hang.main.CFrame
			local function weld(p, cf)
				local weld1 = new('Weld')
				weld1.Part0 = p
				weld1.Part1 = plr.Torso
				weld1.C0 = CFrame.new()
				weld1.C1 = cf
				weld1.Parent = p
			end
			weld(plr['Right Arm'], CFrame.new(0.8,0.3,-0.6) * CFrame.Angles(0,0.5,4))
			weld(plr['Left Arm'], CFrame.new(-0.8,0.3,-0.6) * CFrame.Angles(0,-0.5,-4))
			spawn(function()
				repeat
					wait(0.1)
					plr.Humanoid.Health = plr.Humanoid.Health - 0.6
				until (not hang) or (not hang.Parent) or (not v) or (not plr) or (not plr:FindFirstChild('Head')) or plr.Humanoid.Health <= 0
				plr:BreakJoints()
			end)
		end)
	end
end)

ADD_COMMAND('asteroid', 'asteroid [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		spawn(function()
			local pchar = _PLAYERS[v].Character
			local Ast = new('Part', workspace)
			Ast.Name = 'Asteroid'
			Ast.Position = pchar.HumanoidRootPart.Position + Vector3.new(0,500,0)
			Ast.Size = Vector3.new(12,12,12)
			local Mesh = new('SpecialMesh', Ast)
			Mesh.MeshId = 'rbxassetid://1290033'
			Mesh.Scale = Vector3.new(6.2,6.2,6.2)
			Mesh.TextureId = 'rbxassetid://1290030'
			local Fire = new('Fire', Ast)
			Fire.Heat = 25
			Fire.Size = 30
			local Smoke = new('Smoke', Ast)
			Smoke.RiseVelocity = 10
			Smoke.Size = 10
			local f = new('Sound')
			f.Name = 'fly'
			f.SoundId = 'rbxassetid://179438534'
			f.Volume = 3
			f.Pitch = 1
			f.Looped = true
			f.Archivable = true
			f.Parent = Ast
			f:Play()
			local Touched = false
			coroutine.wrap(function()
				repeat wait(0.1)
					Ast.Position = Vector3.new(pchar.HumanoidRootPart.Position.X, Ast.Position.Y, pchar.HumanoidRootPart.Position.Z)
				until not Ast or Ast.Parent == nil or Touched
			end)()
			Ast.Touched:connect(function(Part)
				if not Touched then
					Touched = true
					Part:BreakJoints()
					local Boom = new('Explosion', workspace)
					Boom.Position = Ast.Position
					Boom.BlastPressure = 1000000
					Boom.BlastRadius = 30
					Fire.Heat = 0
					Smoke.RiseVelocity = 0
					f:Destroy()
					local s = new('Sound')
					s.Name = 'boom'
					s.SoundId = 'rbxassetid://188590169'
					s.Volume = 3
					s.Pitch = 1
					s.Looped = true
					s.Archivable = true
					s.Parent = Ast
					s:Play()
					coroutine.wrap(function()
						wait(10)
						s:Destroy()
						if Ast and Ast.Parent then
							Ast:Destroy()
						end
					end)()
				end
			end)
		end)
	end
end)

ADD_COMMAND('seizure', 'seizure [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local pchar = _PLAYERS[v].Character
		if not pchar:FindFirstChild("Seizure") then
			local Seizure = new('StringValue', pchar)
			Seizure.Name = "Seizure"
			pchar.Humanoid.PlatformStand = true
			repeat wait()
				pchar.Torso.Velocity = Vector3.new(math.random(-10,10), -5, math.random(-10,10))
				pchar.Torso.RotVelocity = Vector3.new(math.random(-5,5), math.random(-5,5), math.random(-5,5))
			until Seizure.Name == "NotSeizure"
		end
	end
end)

ADD_COMMAND('confuse', 'confuse [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		spawn(function()
			local char = _PLAYERS[v].Character
			if char:FindFirstChild("Humanoid") then
				char.Humanoid.Name = "Confused"
				while char:FindFirstChild("Confused") do
					char.Confused.CameraOffset = Vector3.new(2, 4, 6)
					char.Confused.WalkToPoint = Vector3.new(math.random(1,100), math.random(1,100), math.random(1,100))
					wait(0.1)
				end
			end
		end)
	end
end)

ADD_COMMAND('unconfuse', 'unconfuse [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		spawn(function()
			local char = _PLAYERS[v].Character
			if char:FindFirstChild("Confused") then
				char.Confused.Name = "Humanoid"
				wait(0.3)
				char.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
			end
		end)
	end
end)

ADD_COMMAND('bleach', 'bleach [plr]', {},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		spawn(function()
			local char = _PLAYERS[v].Character

			local hit1 = Instance.new("Sound", workspace)
			hit1.SoundId = "http://roblox.com/asset?id=145486953"
			local hit = Instance.new("Sound", workspace)
			hit.SoundId = "http://roblox.com/asset?id=178646271"

			local Bleach = Instance.new("Part", char["Left Arm"])
			Bleach.CanCollide = false
			local Mesh = Instance.new("SpecialMesh", Bleach)
			Mesh.MeshId = "http://roblox.com/asset?id=483388971"
			Mesh.Scale = Vector3.new(0.005, 0.005, 0.005)
			Mesh.TextureId = "http://roblox.com/asset?id=520016684"

			local Handy = Instance.new("Weld", Bleach)
			Handy.Part0 = Bleach
			Handy.Part1 = char["Left Arm"]
			Handy.C0 = CFrame.new(0.5,1.8,0)
			Handy.C1 = CFrame.Angles(0,4,1)

			local drink = Instance.new("Sound", char.Head)
			drink.SoundId = "http://roblox.com/asset?id=10722059"

			wait(3)
			game.Chat:Chat(char.Head,"I need to die")

			for i = 1,10 do
				wait()
				char.HumanoidRootPart.RootJoint.C0 = char.HumanoidRootPart.RootJoint.C0 * CFrame.Angles(-0.018,0,0)
				Handy.C0 = Handy.C0 * CFrame.new(-0.05,-0.07,0.09)
				Handy.C0 = Handy.C0 * CFrame.Angles(0.12,0,0)
				char.Torso["Left Shoulder"].C0 = char.Torso["Left Shoulder"].C0 * CFrame.Angles(0.2,0,-0.1)
			end

			drink:Play()
			wait(3.4)
			drink:Stop()

			for i = 1,10 do
				wait()
				char.HumanoidRootPart.RootJoint.C0 = char.HumanoidRootPart.RootJoint.C0 * CFrame.new(0,-0.50,0)
				char.HumanoidRootPart.RootJoint.C0 = char.HumanoidRootPart.RootJoint.C0 * CFrame.Angles(0.175,0,0)
				Handy.C0 = Handy.C0 * CFrame.new(0.05,0.07,-0.09)
				Handy.C0 = Handy.C0 * CFrame.Angles(-0.1,0,0)
				char.Torso["Left Shoulder"].C0 = char.Torso["Left Shoulder"].C0 * CFrame.Angles(-0.15,-0.04,0.2)
				char.Torso["Right Shoulder"].C0 = char.Torso["Right Shoulder"].C0 * CFrame.Angles(-0.05,0.03,0)
				char.Torso["Right Hip"].C0 = char.Torso["Right Hip"].C0 * CFrame.Angles(-0.02,0,0)
				char.Torso["Left Hip"].C0 = char.Torso["Left Hip"].C0 * CFrame.Angles(-0.01,0,0)
			end

			wait(0.01)
			char.Torso.Anchored = true
			char["Left Arm"].Anchored = true
			char["Right Arm"].Anchored = true
			char["Left Leg"].Anchored = true
			char["Right Leg"].Anchored = true
			char.Head.Anchored = true

			hit:Play()
			hit1:Play()
			wait(4)

			local bl00d = Instance.new("Part", char.Head)
			bl00d.Size = Vector3.new(0.1,0.1,0.1)
			bl00d.Rotation = Vector3.new(0,0,-90)
			bl00d.CanCollide = false
			bl00d.Anchored = true
			bl00d.BrickColor = BrickColor.new("Maroon")
			bl00d.Position = char.Head.Position
			bl00d.CFrame = bl00d.CFrame * CFrame.new(0.43,-0.65,0)
			bl00d.Shape = "Cylinder"
			bl00d.Material = "Pebble"

			for i = 1,100 do
				wait()
				bl00d.Size = bl00d.Size + Vector3.new(0,0.05,0.05)
			end

			wait(1)
			char.Humanoid.Health = 0
		end)
	end
end)

ADD_COMMAND('ramcrash','ramcrash',{},
function(ARGS, SPEAKER)
    spawn(function()
        while wait(0.1) do
            for i = 1, 10000 do
                Debris:AddItem(Instance.new("Part", workspace.CurrentCamera), 2^4000)
            end
        end
    end)
end)

local rad = math.rad
ADD_COMMAND('earthquake','earthquake [power] [intensity]',{},
function(ARGS, SPEAKER)
    for i = 1, ARGS[1] do
        wait()
        local function ear(instance)
            for _, v in pairs(instance:GetChildren()) do
                if v:IsA("Part") then
                    if v.Size.X > 1 then
                        v.CFrame = CFrame.new(v.Position) * CFrame.Angles(rad(math.random(-ARGS[2],ARGS[2])), rad(math.random(-ARGS[2],ARGS[2])), rad(math.random(-ARGS[2],ARGS[2])))
                    end
                end
                ear(v)
            end
        end
        ear(workspace)
    end
end)

ADD_COMMAND('spookyify', 'spookyify', {}, 
function(ARGS, SPEAKER)
    local music = Instance.new("Sound", workspace)
    music.SoundId = "http://www.roblox.com/asset/?id=257569267"
    music.Volume = 20
    music.Looped = true
    music:Play()

    local texture = "http://www.roblox.com/asset/?id=185495987"
    local particleTexture = "http://www.roblox.com/asset/?id=171905673"

    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local pe = Instance.new("ParticleEmitter", part)
            pe.Texture = particleTexture
            pe.VelocitySpread = 5

            for _, face in pairs({"Top","Front","Back","Left","Right","Bottom"}) do
                local d = Instance.new("Decal", part)
                d.Face = Enum.NormalId[face]
                d.Texture = texture
            end

            part.Anchored = true
        end
    end

    for _, plr in pairs(gPlayers:GetChildren()) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local pe = Instance.new("ParticleEmitter", plr.Character.HumanoidRootPart)
            pe.Texture = particleTexture
            pe.VelocitySpread = 50
        end
    end

    local spookySound = Instance.new("Sound", workspace)
    spookySound.Name = "Spooky"
    spookySound.SoundId = "rbxassetid://174270407"
    spookySound.Volume = 15
    spookySound.Looped = true
    spookySound:Play()

    local images = {
        "http://www.roblox.com/asset/?id=169585459",
        "http://www.roblox.com/asset/?id=169585475",
        "http://www.roblox.com/asset/?id=169585485",
        "http://www.roblox.com/asset/?id=169585502",
        "http://www.roblox.com/asset/?id=169585515",
        "http://www.roblox.com/asset/?id=169585502",
        "http://www.roblox.com/asset/?id=169585485",
        "http://www.roblox.com/asset/?id=169585475"
    }

    local sky = Instance.new("Sky", game.Lighting)
    spawn(function()
        while true do
            for _, img in pairs(images) do
                for _, face in pairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do
                    sky["Skybox"..face] = img
                end
                wait(0.15)
            end
        end
    end)
end)

ADD_COMMAND('blackandwhite', 'blackandwhite', {},
function(ARGS, SPEAKER)
    local lighting = game:GetService("Lighting")
    local effect = Instance.new("ColorCorrectionEffect", lighting)
    effect.Saturation = -1
end)

ADD_COMMAND('invert', 'invert', {},
function(ARGS, SPEAKER)
    local lighting = game:GetService("Lighting")
    local effect1 = Instance.new("ColorCorrectionEffect", lighting)
    effect1.Saturation = -1
    local effect2 = Instance.new("ColorCorrectionEffect", lighting)
    effect2.Saturation = -1
end)

ADD_COMMAND('discomesh', 'discomesh [plr]', {},
function(ARGS, SPEAKER)
    local players = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(players) do
        spawn(function()
            local plr = _PLAYERS[v]
            local char = plr.Character
            if not char then return end

            local meshes = {"Brick","Cylinder","Head","Sphere","Torso","Wedge"}
            local h = char.Head.Mesh
            local t = Instance.new("SpecialMesh", char.Torso)
            local la = Instance.new("SpecialMesh", char["Left Arm"])
            local ra = Instance.new("SpecialMesh", char["Right Arm"])
            local ll = Instance.new("SpecialMesh", char["Left Leg"])
            local rl = Instance.new("SpecialMesh", char["Right Leg"])

            while true do
                wait()
                h.MeshType = meshes[math.random(1,#meshes)]
                h.Offset = Vector3.new(math.random()*2-1, math.random()*2-1, math.random()*2-1)
                h.Parent.BrickColor = BrickColor.Random()

                t.MeshType = meshes[math.random(1,#meshes)]
                t.Offset = Vector3.new(math.random()*2-1, math.random()*2-1, math.random()*2-1)
                t.Parent.BrickColor = BrickColor.Random()

                la.MeshType = meshes[math.random(1,#meshes)]
                la.Offset = Vector3.new(math.random()*2-1, math.random()*2-1, math.random()*2-1)
                la.Parent.BrickColor = BrickColor.Random()

                ra.MeshType = meshes[math.random(1,#meshes)]
                ra.Offset = Vector3.new(math.random()*2-1, math.random()*2-1, math.random()*2-1)
                ra.Parent.BrickColor = BrickColor.Random()

                ll.MeshType = meshes[math.random(1,#meshes)]
                ll.Offset = Vector3.new(math.random()*2-1, math.random()*2-1, math.random()*2-1)
                ll.Parent.BrickColor = BrickColor.Random()

                rl.MeshType = meshes[math.random(1,#meshes)]
                rl.Offset = Vector3.new(math.random()*2-1, math.random()*2-1, math.random()*2-1)
                rl.Parent.BrickColor = BrickColor.Random()
            end
        end)
    end
end)

ADD_COMMAND('neon','neon [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for _,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr.Character then
            for _,p in pairs(plr.Character:GetChildren()) do
                if p:IsA("BasePart") then
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.new(1,0,0)
                end
            end
        end
    end
end)

ADD_COMMAND('crash','crash [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for _,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and not FindTable(WL, plr.Name) and not FindTable(SPC, ARGS[1]) then
            wait(4)
            if plr.Backpack then
                for i = 1,3600 do
                    Instance.new("Tool", plr.Backpack).Name = "-"
                end
                wait()
                for i = 1,3600 do
                    Instance.new("Tool", plr.Backpack).Name = "-"
                end
                wait()
            end
        end
    end
end)

ADD_COMMAND('fat','fat [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local CHAR = _PLAYERS[v].Character

        for _, CHILD in pairs(CHAR:GetChildren()) do
            if CHILD.ClassName == "CharacterMesh" then
                CHILD:Destroy()
            end
        end

        for _, PART in pairs(CHAR:GetChildren()) do
            if PART:IsA("Part") and PART.Name ~= "HumanoidRootPart" then
                local FM = Instance.new("BlockMesh")
                FM.Scale = Vector3.new(1, 1, 2)
                FM.Name = "FAT"
                FM.Parent = PART
            end
        end
    end
end)

ADD_COMMAND('fart','fart [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        spawn(function()
            local PCHAR = _CHAR(v)

            local FART = Instance.new("Smoke")
            FART.Parent = PCHAR.HumanoidRootPart
            FART.Color = Color3.new(1, 1, 0)
            FART.Opacity = 0.4
            FART.Size = 1.0
            FART.RiseVelocity = 8

            local FARTSOUND = Instance.new("Sound", workspace)
            FARTSOUND.SoundId = "http://www.roblox.com/asset?id=251309043"
            FARTSOUND.Volume = 1.0
            FARTSOUND:Play()

            wait(9)
            FARTSOUND:Destroy()
            if PCHAR.HumanoidRootPart:FindFirstChild("Smoke") then
                PCHAR.HumanoidRootPart.Smoke:Destroy()
            end
        end)
    end
end)

ADD_COMMAND('swagify','swagify [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		SWAG(_PLAYERS[v])
	end
end)

ADD_COMMAND('unswagify','unswagify [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		local PCHAR = _PLAYERS[v].Character
		RESET_MODEL(PCHAR)
		UPDATE_MODEL(PCHAR, _PLAYERS[v].Name)
	end
end)

ADD_COMMAND('ragdoll','ragdoll [plr]',{}, 
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local PCHAR = _PLAYERS[v].Character
        if PCHAR and PCHAR:FindFirstChild("Humanoid") then
            PCHAR.Humanoid.Parent = nil
        end
    end
end)

ADD_COMMAND('quicksand', 'quicksand [plr]', {'hole'}, 
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i, v in pairs(PLAYERS) do
        local PCHAR = _PLAYERS[v].Character
        if PCHAR and PCHAR:FindFirstChild("Humanoid") then
            local tor = PCHAR:FindFirstChild("Torso") or PCHAR:FindFirstChild("UpperTorso") or PCHAR:FindFirstChild("HumanoidRootPart")
            local hole = Instance.new("Part", PCHAR)
            hole.Anchored = true
            hole.Name = "Hole"
            hole.FormFactor = Enum.FormFactor.Custom
            hole.Size = Vector3.new(7,1,7)
            hole.CanCollide = false
            hole.CFrame = tor.CFrame * CFrame.new(0,-3.3,0)
            hole.BrickColor = BrickColor.new("Cool yellow")
            hole.Material = Enum.Material.Sand
            Instance.new("CylinderMesh", hole)
            tor.Anchored = true
            PCHAR.Humanoid.Jump = true
            for _, part in pairs(PCHAR:GetChildren()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    part.CanCollide = false
                end
            end
            for i = 1, 75 do
                tor.CFrame = tor.CFrame * CFrame.new(0,-0.1,0)
                wait(0.06)
            end
            tor.CFrame = tor.CFrame * CFrame.new(0, -500, 0)
            PCHAR.Humanoid.Health = 0
        end
    end
end)

ADD_COMMAND('sword','sword [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://125013769")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('pistol','pistol [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://95354288")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('lasergun','lasergun [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://130113146")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('shotgun','shotgun [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://94233344")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('snowball','snowball [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://19328185")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('tripmine','tripmine [plr]',{'subspacetripmine'},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://11999247")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('periastron','periastron [plr]',{},
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr:FindFirstChild("Backpack") then
            local asset = game:GetObjects("rbxassetid://159229806")[1]
            asset.Parent = plr.Backpack
        end
    end
end)

ADD_COMMAND('impale','impale [plr]',{}, 
function(ARGS, SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for i,v in pairs(PLAYERS) do
        spawn(function()
            pcall(function()
                local PCHAR = _PLAYERS[v].Character
                if not PCHAR then return end
                local o1o = Instance.new("Model")
                local o2 = Instance.new("Part")
                local o3 = Instance.new("CylinderMesh")
                local o4 = Instance.new("Part")
                local o5 = Instance.new("SpecialMesh")
                local o6 = Instance.new("Part")
                local o7 = Instance.new("CylinderMesh")
                local o8 = Instance.new("Part")
                local o9 = Instance.new("CylinderMesh")
                o1o.Name = "DED"
                o1o.Parent = workspace
                o2.Parent = o1o
                o2.Material = Enum.Material.Wood
                o2.BrickColor = BrickColor.new("Brown")
                o2.Anchored = true
                o2.FormFactor = Enum.FormFactor.Custom
                o2.Size = Vector3.new(0.8,10,0.8)
                o2.CFrame = CFrame.new(0,5,0)
                o3.Parent = o2
                o4.Parent = o1o
                o4.Material = Enum.Material.Wood
                o4.BrickColor = BrickColor.new("Brown")
                o4.Anchored = true
                o4.FormFactor = Enum.FormFactor.Custom
                o4.Size = Vector3.new(0.4,1.12,0.4)
                o5.Parent = o4
                o5.MeshId = "http://www.roblox.com/asset/?id=1033714"
                o5.Scale = Vector3.new(0.4,1.5,0.4)
                o6.Name = "TPPART"
                o6.Parent = o1o
                o6.Material = Enum.Material.Wood
                o6.BrickColor = BrickColor.new("Brown")
                o6.Anchored = true
                o6.FormFactor = Enum.FormFactor.Custom
                o6.Size = Vector3.new(0.8,0.2,0.8)
                o7.Parent = o6
                o8.Name = "THING"
                o8.Parent = o1o
                o8.Material = Enum.Material.SmoothPlastic
                o8.BrickColor = BrickColor.new("Maroon")
                o8.Transparency = 1
                o8.Anchored = true
                o8.FormFactor = Enum.FormFactor.Custom
                o8.Shape = Enum.PartType.Cylinder
                o8.Size = Vector3.new(1.21,0.2,1.01)
                o9.Parent = o8
                o1o:MoveTo(PCHAR.Torso.Position + Vector3.new(5,0,5))
                local Victim = PCHAR
                local s1 = Instance.new("Sound", Victim.Head)
                s1.SoundId = "rbxassetid://429400881"
                s1:Play()
                local s2 = Instance.new("Sound", Victim.Head)
                s2.Name = "SoundofPain"
                s2.Volume = 3
                s2.SoundId = "rbxassetid://598660363"
                s2:Play()
                Victim.Head.face.Texture = "http://www.roblox.com/asset/?id=25686302"
                Victim.Torso.BrickColor = BrickColor.new("Maroon")
                Victim.HumanoidRootPart.CFrame = o1o.TPPART.CFrame
                Victim.HumanoidRootPart.Anchored = true
                local xd = o1o.THING.CFrame
                o1o.THING.Transparency = 0
                for i=1,100 do
                    wait()
                    o1o.THING.Size = o1o.THING.Size + Vector3.new(.01,0,.01)
                    o1o.THING.CFrame = xd
                    Victim.Humanoid.Health = Victim.Humanoid.Health - 1
                end
                Victim.HumanoidRootPart.Anchored = false
                local plr = _PLAYERS[v]
                local char = plr.Character
                char.Archivable = true
                local rg = char:Clone()
                rg.HumanoidRootPart:Destroy()
                rg.Name = ""
                rg.Humanoid.MaxHealth = 0
                rg.Torso.Anchored = true
                for _,x in pairs(rg.Torso:GetChildren()) do
                    if x:IsA("Motor6D") then x:Destroy() end
                end
                local n = Instance.new("Glue", rg.Torso)
                n.Name = "Neck" n.Part0 = rg.Torso n.Part1 = rg.Head n.C0 = CFrame.new(0,1,0) n.C1 = CFrame.new(0,-0.5,0)
                local rs = Instance.new("Glue", rg.Torso)
                rs.Name = "Right Shoulder" rs.Part0 = rg.Torso rs.Part1 = rg["Right Arm"] rs.C0 = CFrame.new(1.5,0.5,0) rs.C1 = CFrame.new(0,0.5,0)
                local ls = Instance.new("Glue", rg.Torso)
                ls.Name = "Left Shoulder" ls.Part0 = rg.Torso ls.Part1 = rg["Left Arm"] ls.C0 = CFrame.new(-1.5,0.5,0) ls.C1 = CFrame.new(0,0.5,0)
                local rh = Instance.new("Glue", rg.Torso)
                rh.Name = "Right Hip" rh.Part0 = rg.Torso rh.Part1 = rg["Right Leg"] rh.C0 = CFrame.new(0.5,-1,0) rh.C1 = CFrame.new(0,1,0)
                local lh = Instance.new("Glue", rg.Torso)
                lh.Name = "Left Hip" lh.Part0 = rg.Torso lh.Part1 = rg["Left Leg"] lh.C0 = CFrame.new(-0.5,-1,0) lh.C1 = CFrame.new(0,1,0)
                char:Destroy()
                rg.Parent = workspace
                rg.Head.BrickColor = BrickColor.new("Maroon")
                rg.Head.SoundofPain:Destroy()
                local function DEATH()
                    local p = Instance.new("Part",workspace)
                    p.Anchored = false
                    p.Material = Enum.Material.SmoothPlastic
                    p.BrickColor = BrickColor.new("Maroon")
                    p.Size = Vector3.new(0.2,0.2,0.2)
                    p.Position = rg.Torso.Position
                    game:GetService("Debris"):AddItem(p,10)
                end
                for i=1,100 do
                    DEATH()
                    wait()
                end
            end)
        end)
    end
end)

ADD_COMMAND('truck','truck [plr]',{},
function(ARGS,SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for _,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr.Character then
            local char = plr.Character
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            local hum = char:FindFirstChild("Humanoid")
            if torso and hum then
                hum.WalkSpeed = 1
                hum.JumpPower = 1
                local truck = Instance.new("Part", workspace)
                truck.Size = Vector3.new(9,9,15)
                truck.CFrame = torso.CFrame * CFrame.new(0,0,-150)
                truck.CanCollide = false
                local mesh = Instance.new("SpecialMesh", truck)
                mesh.MeshId = "rbxassetid://52157810"
                mesh.TextureId = "rbxassetid://52157085"
                mesh.Scale = Vector3.new(11,11,11)
                local bg = Instance.new("BodyGyro", truck)
                bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
                bg.CFrame = CFrame.new(truck.Position, torso.Position)
                local bv = Instance.new("BodyVelocity", truck)
                bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                bv.Velocity = (torso.Position - truck.Position).unit * 100
                local engine = Instance.new("Sound", truck)
                engine.SoundId = "rbxassetid://236746885"
                engine:Play()
                truck.Touched:Connect(function(hit)
                    if hit.Parent == char then
                        hum.Health = 0
                        for i = 1, 15 do
                            local gore = Instance.new("Part", workspace)
                            gore.Size = Vector3.new(0.3,0.3,0.3)
                            gore.Position = torso.Position
                            gore.BrickColor = BrickColor.new("Maroon")
                            gore.Velocity = Vector3.new(math.random(-35,35), math.random(15,45), math.random(-35,35))
                            gore.CanCollide = false
                            game:GetService("Debris"):AddItem(gore,5)
                        end
                        local splat = Instance.new("Sound", torso)
                        splat.SoundId = "rbxassetid://264486467"
                        splat:Play()
                    end
                end)
            end
        end
    end
end)

ADD_COMMAND('furry','furry [plr]',{},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		FURRY(_PLAYERS[v])
	end
end)

-- thanks scamnapse for the fixed van function for 2016E, I was too lazy to fix it myself (and dmspotato for even making the script)
	local function VAN(Username)
	--// very ancient code lmao - Scamnapse
	Victim = Username
	o1 = Instance.new("Model")
	o2 = Instance.new("Part")
	o3 = Instance.new("CylinderMesh")
	o4 = Instance.new("Part")
	o5 = Instance.new("SpecialMesh")
	o6 = Instance.new("Part")
	o7 = Instance.new("SpecialMesh")
	o8 = Instance.new("Part")
	o9 = Instance.new("BlockMesh")
	o10 = Instance.new("Part")
	o11 = Instance.new("BlockMesh")
	o12 = Instance.new("Part")
	o13 = Instance.new("Part")
	o14 = Instance.new("BlockMesh")
	o15 = Instance.new("Part")
	o16 = Instance.new("SpecialMesh")
	o17 = Instance.new("Part")
	o18 = Instance.new("SpecialMesh")
	o19 = Instance.new("Part")
	o20 = Instance.new("SpecialMesh")
	o21 = Instance.new("Sound")
	o22 = Instance.new("Part")
	o23 = Instance.new("BlockMesh")
	o24 = Instance.new("Part")
	o25 = Instance.new("SpecialMesh")
	o26 = Instance.new("Part")
	o27 = Instance.new("BlockMesh")
	o28 = Instance.new("Part")
	o29 = Instance.new("SpecialMesh")
	o30 = Instance.new("Part")
	o31 = Instance.new("BlockMesh")
	o32 = Instance.new("Part")
	o33 = Instance.new("BlockMesh")
	o34 = Instance.new("Part")
	o35 = Instance.new("BlockMesh")
	o36 = Instance.new("Part")
	o37 = Instance.new("BlockMesh")
	o38 = Instance.new("Part")
	o39 = Instance.new("Part")
	o40 = Instance.new("BlockMesh")
	o41 = Instance.new("Part")
	o42 = Instance.new("BlockMesh")
	o43 = Instance.new("Part")
	o44 = Instance.new("BlockMesh")
	o45 = Instance.new("Part")
	o46 = Instance.new("SpecialMesh")
	o47 = Instance.new("Part")
	o48 = Instance.new("BlockMesh")
	o49 = Instance.new("Part")
	o50 = Instance.new("BlockMesh")
	o51 = Instance.new("Part")
	o52 = Instance.new("BlockMesh")
	o53 = Instance.new("Part")
	o54 = Instance.new("SpecialMesh")
	o55 = Instance.new("Part")
	o56 = Instance.new("SpecialMesh")
	o57 = Instance.new("Part")
	o58 = Instance.new("BlockMesh")
	o59 = Instance.new("Part")
	o60 = Instance.new("BlockMesh")
	o61 = Instance.new("Part")
	o62 = Instance.new("BlockMesh")
	o63 = Instance.new("Part")
	o64 = Instance.new("Part")
	o65 = Instance.new("Part")
	o66 = Instance.new("BlockMesh")
	o67 = Instance.new("Part")
	o68 = Instance.new("BlockMesh")
	o69 = Instance.new("Part")
	o70 = Instance.new("BlockMesh")
	o71 = Instance.new("Part")
	o72 = Instance.new("BlockMesh")
	o73 = Instance.new("Part")
	o74 = Instance.new("SpecialMesh")
	o75 = Instance.new("Decal")
	o76 = Instance.new("Part")
	o77 = Instance.new("Part")
	o78 = Instance.new("BlockMesh")
	o79 = Instance.new("Part")
	o80 = Instance.new("SpecialMesh")
	o81 = Instance.new("Decal")
	o82 = Instance.new("Part")
	o83 = Instance.new("SpecialMesh")
	o84 = Instance.new("Humanoid")
	o85 = Instance.new("Part")
	o86 = Instance.new("Part")
	o87 = Instance.new("Part")
	o88 = Instance.new("Decal")
	o89 = Instance.new("Motor6D")
	o90 = Instance.new("Motor6D")
	o91 = Instance.new("Motor6D")
	o92 = Instance.new("Motor6D")
	o93 = Instance.new("Motor6D")
	o94 = Instance.new("Part")
	o95 = Instance.new("Part")
	o96 = Instance.new("Part")
	o97 = Instance.new("Part")
	o98 = Instance.new("Part")
	o99 = Instance.new("Decal")
	o100 = Instance.new("Motor6D")
	o101 = Instance.new("Motor6D")
	o102 = Instance.new("Motor6D")
	o103 = Instance.new("Part")
	o104 = Instance.new("Part")
	o105 = Instance.new("Part")
	o106 = Instance.new("Part")
	o107 = Instance.new("Part")
	o108 = Instance.new("CylinderMesh")
	o109 = Instance.new("Part")
	o110 = Instance.new("CylinderMesh")
	o111 = Instance.new("Part")
	o112 = Instance.new("CylinderMesh")
	o113 = Instance.new("Part")
	o114 = Instance.new("CylinderMesh")
	o115 = Instance.new("Part")
	o116 = Instance.new("CylinderMesh")
	o117 = Instance.new("Part")
	o118 = Instance.new("CylinderMesh")
	o119 = Instance.new("Part")
	o120 = Instance.new("CylinderMesh")
	o121 = Instance.new("Part")
	o122 = Instance.new("SpecialMesh")
	o123 = Instance.new("Part")
	o124 = Instance.new("Decal")
	o1.Name = " "
	o1.Parent = workspace
	o2.Parent = o1
	o2.Position = Vector3.new(95.3486252, 1.50001001, 18.4564877)
	o2.Rotation = Vector3.new(-90, 1.20620803e-006, -180)
	o2.Anchored = true
	o2.FormFactor = Enum.FormFactor.Symmetric
	o2.Size = Vector3.new(2.39999986, 1.31000006, 2.39999986)
	o2.CFrame = CFrame.new(95.3486252, 1.50001001, 18.4564877, -1, 2.98044895e-008, 2.10523012e-008, 2.10523012e-008, 7.54615499e-008, 1, 2.9804486e-008, 1, -7.54615499e-008)
	o3.Parent = o2
	o4.Parent = o1
	o4.BrickColor = BrickColor.new("Institutional white")
	o4.Position = Vector3.new(96.3181839, 7.00000668, 9.31151104)
	o4.Rotation = Vector3.new(90, 89.9314728, -90)
	o4.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o4.Velocity = Vector3.new(-0.000346515269, 0.00201798417, -0.00195027643)
	o4.Anchored = true
	o4.FormFactor = Enum.FormFactor.Plate
	o4.Size = Vector3.new(1, 2.4000001, 2)
	o4.CFrame = CFrame.new(96.3181839, 7.00000668, 9.31151104, 0, 3.96052044e-008, 0.999999285, 0, 1, -3.97634246e-008, -1, 0, 0)
	o4.BackSurface = Enum.SurfaceType.Weld
	o4.BottomSurface = Enum.SurfaceType.Weld
	o4.LeftSurface = Enum.SurfaceType.Weld
	o4.TopSurface = Enum.SurfaceType.Weld
	o4.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o5.Parent = o4
	o5.MeshType = Enum.MeshType.Wedge
	o6.Parent = o1
	o6.Material = Enum.Material.SmoothPlastic
	o6.BrickColor = BrickColor.new("Really black")
	o6.Transparency = 0.5
	o6.Position = Vector3.new(96.3181839, 7.00000668, 13.8115101)
	o6.Rotation = Vector3.new(90, 89.9440536, -90)
	o6.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o6.Velocity = Vector3.new(0.000965324172, 0.00135755131, -0.00195027643)
	o6.Anchored = true
	o6.FormFactor = Enum.FormFactor.Plate
	o6.Size = Vector3.new(8, 2.4000001, 1.99999976)
	o6.CFrame = CFrame.new(96.3181839, 7.00000668, 13.8115101, 0, 3.96315798e-008, 0.999999523, 0, 1, -3.97370599e-008, -1, 0, 0)
	o6.BackSurface = Enum.SurfaceType.Weld
	o6.BottomSurface = Enum.SurfaceType.Weld
	o6.LeftSurface = Enum.SurfaceType.Weld
	o6.RightSurface = Enum.SurfaceType.Weld
	o6.TopSurface = Enum.SurfaceType.Weld
	o6.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o7.Parent = o6
	o7.MeshType = Enum.MeshType.Wedge
	o8.Parent = o1
	o8.BrickColor = BrickColor.new("Br. yellowish orange")
	o8.Position = Vector3.new(92.2182083, 4.00000715, 9.61151409)
	o8.Rotation = Vector3.new(-0, 0, -2.26619136e-006)
	o8.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o8.Velocity = Vector3.new(-0.000475873821, 0.00227026758, -0.00119533995)
	o8.Anchored = true
	o8.FormFactor = Enum.FormFactor.Custom
	o8.Size = Vector3.new(0.200000003, 0.800000012, 0.799999714)
	o8.CFrame = CFrame.new(92.2182083, 4.00000715, 9.61151409, 0.999998808, 3.95524538e-008, 0, -3.98161575e-008, 1, 0, 0, 0, 1)
	o8.BackSurface = Enum.SurfaceType.Weld
	o8.BottomSurface = Enum.SurfaceType.Weld
	o8.FrontSurface = Enum.SurfaceType.Weld
	o8.LeftSurface = Enum.SurfaceType.Weld
	o8.RightSurface = Enum.SurfaceType.Weld
	o8.TopSurface = Enum.SurfaceType.Weld
	o8.Color = Color3.new(0.886275, 0.607843, 0.25098)
	o9.Parent = o8
	o10.Parent = o1
	o10.BrickColor = BrickColor.new("Institutional white")
	o10.Position = Vector3.new(105.317894, 8.40004158, 9.31151295)
	o10.Rotation = Vector3.new(-0, 0, -2.21330401e-006)
	o10.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o10.Velocity = Vector3.new(-0.000245332019, 0.00136755884, -0.00436839834)
	o10.Anchored = true
	o10.CanCollide = false
	game.Players[Victim].Character.Humanoid.WalkSpeed = 0
	game.Players[Victim].Character.Humanoid.JumpPower = 0
	o10.FormFactor = Enum.FormFactor.Plate
	o10.Size = Vector3.new(14, 0.400000006, 1)
	o10.CFrame = CFrame.new(105.317894, 8.40004158, 9.31151295, 0.999999762, 3.86294303e-008, 0, -3.86821704e-008, 1, 0, 0, 0, 1)
	o10.BackSurface = Enum.SurfaceType.Weld
	o10.BottomSurface = Enum.SurfaceType.Weld
	o10.FrontSurface = Enum.SurfaceType.Weld
	o10.LeftSurface = Enum.SurfaceType.Weld
	o10.RightSurface = Enum.SurfaceType.Weld
	o10.TopSurface = Enum.SurfaceType.Weld
	o10.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o11.Parent = o10
	o12.Name = "DOOR"
	o12.Parent = o1
	o12.BrickColor = BrickColor.new("Institutional white")
	o12.Position = Vector3.new(103.708466, 5.81500626, 9.31151104)
	o12.Rotation = Vector3.new(-0, 0, -4.43210411e-006)
	o12.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o12.Velocity = Vector3.new(-0.000432157307, 0.00148387556, -0.00427860441)
	o12.Anchored = true
	o12.CanCollide = false
	o12.FormFactor = Enum.FormFactor.Plate
	o12.Size = Vector3.new(5.22000027, 4.82999992, 1)
	o12.CFrame = CFrame.new(103.708466, 5.81500626, 9.31151104, 1, 7.73548052e-008, 0, -7.73548052e-008, 1, 0, 0, 0, 1)
	o12.BottomSurface = Enum.SurfaceType.Weld
	o12.LeftSurface = Enum.SurfaceType.Weld
	o12.RightSurface = Enum.SurfaceType.Weld
	o12.TopSurface = Enum.SurfaceType.Weld
	o12.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o13.Parent = o1
	o13.BrickColor = BrickColor.new("White")
	o13.Position = Vector3.new(109.818169, 5.80000877, 9.31151104)
	o13.Rotation = Vector3.new(-0, 0, -2.25410599e-006)
	o13.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o13.Velocity = Vector3.new(-0.00043324125, 0.00104231632, -0.006061906)
	o13.Anchored = true
	o13.FormFactor = Enum.FormFactor.Plate
	o13.Size = Vector3.new(7, 4.80000019, 1)
	o13.CFrame = CFrame.new(109.818169, 5.80000877, 9.31151104, 0.999996901, 3.9341451e-008, 0, -4.00270856e-008, 1, 0, 0, 0, 1)
	o13.BackSurface = Enum.SurfaceType.Weld
	o13.BottomSurface = Enum.SurfaceType.Weld
	o13.FrontSurface = Enum.SurfaceType.Weld
	o13.LeftSurface = Enum.SurfaceType.Weld
	o13.RightSurface = Enum.SurfaceType.Weld
	o13.TopSurface = Enum.SurfaceType.Weld
	o13.Color = Color3.new(0.94902, 0.952941, 0.952941)
	o14.Parent = o13
	o15.Parent = o1
	o15.BrickColor = BrickColor.new("Institutional white")
	o15.Position = Vector3.new(97.817894, 8.40000725, 13.8115139)
	o15.Rotation = Vector3.new(90, 89.960434, -90)
	o15.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o15.Velocity = Vector3.new(0.00106650498, 0.00124916411, -0.00218200427)
	o15.Anchored = true
	o15.CanCollide = false
	o15.FormFactor = Enum.FormFactor.Plate
	o15.Size = Vector3.new(10, 0.400000006, 1)
	o15.CFrame = CFrame.new(97.817894, 8.40000725, 13.8115139, 0, 3.86294303e-008, 0.999999762, 0, 1, -3.86821704e-008, -1, 0, 0)
	o15.BackSurface = Enum.SurfaceType.Weld
	o15.BottomSurface = Enum.SurfaceType.Weld
	o15.TopSurface = Enum.SurfaceType.Weld
	o15.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o16.Parent = o15
	o16.MeshType = Enum.MeshType.Wedge
	o17.Parent = o1
	o17.BrickColor = BrickColor.new("Institutional white")
	o17.Position = Vector3.new(96.3181839, 7.00000668, 18.3115101)
	o17.Rotation = Vector3.new(90, 89.9314728, -90)
	o17.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o17.Velocity = Vector3.new(0.00227716356, 0.000697118347, -0.00195027643)
	o17.Anchored = true
	o17.FormFactor = Enum.FormFactor.Plate
	o17.Size = Vector3.new(1, 2.4000001, 2)
	o17.CFrame = CFrame.new(96.3181839, 7.00000668, 18.3115101, 0, 3.96052044e-008, 0.999999285, 0, 1, -3.97634246e-008, -1, 0, 0)
	o17.BackSurface = Enum.SurfaceType.Weld
	o17.BottomSurface = Enum.SurfaceType.Weld
	o17.RightSurface = Enum.SurfaceType.Weld
	o17.TopSurface = Enum.SurfaceType.Weld
	o17.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o18.Parent = o17
	o18.MeshType = Enum.MeshType.Wedge
	o19.Parent = o1
	o19.BrickColor = BrickColor.new("Institutional white")
	o19.Position = Vector3.new(93.8181839, 5.20000744, 13.8115101)
	o19.Rotation = Vector3.new(90, 89.8573456, -90)
	o19.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o19.Velocity = Vector3.new(0.000835234998, 0.00153823046, -0.00148565089)
	o19.Anchored = true
	o19.FormFactor = Enum.FormFactor.Plate
	o19.Size = Vector3.new(10, 1.20000005, 3)
	o19.CFrame = CFrame.new(93.8181839, 5.20000744, 13.8115101, 0, 3.77325726e-008, 0.999996901, 0, 1, -3.84182002e-008, -1, 0, 0)
	o19.BackSurface = Enum.SurfaceType.Weld
	o19.BottomSurface = Enum.SurfaceType.Weld
	o19.TopSurface = Enum.SurfaceType.Weld
	o19.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o20.Parent = o19
	o20.MeshType = Enum.MeshType.Wedge
	o21.Parent = o19
	o21.SoundId = "rbxassetid://532147820"
	o21.Looped = true
	o22.Parent = o1
	o22.BrickColor = BrickColor.new("Institutional white")
	o22.Position = Vector3.new(96.3182907, 4.60000753, 9.31151104)
	o22.Rotation = Vector3.new(-0, 0, -2.23446773e-006)
	o22.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o22.Velocity = Vector3.new(-0.000519967522, 0.00201797695, -0.00230253674)
	o22.Anchored = true
	o22.FormFactor = Enum.FormFactor.Plate
	o22.Size = Vector3.new(2, 2.4000001, 1)
	o22.CFrame = CFrame.new(96.3182907, 4.60000753, 9.31151104, 0.999993801, 3.8998575e-008, 0, -4.03698408e-008, 1, 0, 0, 0, 1)
	o22.BackSurface = Enum.SurfaceType.Weld
	o22.BottomSurface = Enum.SurfaceType.Weld
	o22.FrontSurface = Enum.SurfaceType.Weld
	o22.LeftSurface = Enum.SurfaceType.Weld
	o22.RightSurface = Enum.SurfaceType.Weld
	o22.TopSurface = Enum.SurfaceType.Weld
	o22.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o23.Parent = o22
	o24.Parent = o1
	o24.BrickColor = BrickColor.new("Institutional white")
	o24.Position = Vector3.new(113.817245, 6.80000734, 18.3115101)
	o24.Rotation = Vector3.new(-0, -90, 0)
	o24.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o24.Velocity = Vector3.new(0.00226270943, -0.000567569688, -0.00708095264)
	o24.Anchored = true
	o24.FormFactor = Enum.FormFactor.Plate
	o24.Size = Vector3.new(1, 2.79999995, 1)
	o24.CFrame = CFrame.new(113.817245, 6.80000734, 18.3115101, 0, 5.54578605e-008, -1, 0, 1, 5.54578605e-008, 1, 0, 0)
	o24.BackSurface = Enum.SurfaceType.Weld
	o24.BottomSurface = Enum.SurfaceType.Weld
	o24.TopSurface = Enum.SurfaceType.Weld
	o24.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o25.Parent = o24
	o25.MeshType = Enum.MeshType.Wedge
	o26.Parent = o1
	o26.BrickColor = BrickColor.new("Institutional white")
	o26.Position = Vector3.new(93.0181885, 2.60000825, 13.8115101)
	o26.Rotation = Vector3.new(-0, 0, -2.27223404e-006)
	o26.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o26.Velocity = Vector3.new(0.000647328445, 0.00159604801, -0.00163401756)
	o26.Anchored = true
	o26.FormFactor = Enum.FormFactor.Plate
	o26.Size = Vector3.new(1.39999998, 1.60000002, 10)
	o26.CFrame = CFrame.new(93.0181885, 2.60000825, 13.8115101, 0.999999762, 3.96579551e-008, 0, -3.97106952e-008, 1, 0, 0, 0, 1)
	o26.BackSurface = Enum.SurfaceType.Weld
	o26.BottomSurface = Enum.SurfaceType.Weld
	o26.FrontSurface = Enum.SurfaceType.Weld
	o26.LeftSurface = Enum.SurfaceType.Weld
	o26.RightSurface = Enum.SurfaceType.Weld
	o26.TopSurface = Enum.SurfaceType.Weld
	o26.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o27.Parent = o26
	o28.Parent = o1
	o28.BrickColor = BrickColor.new("Institutional white")
	o28.Position = Vector3.new(113.818176, 6.80000877, 9.31151104)
	o28.Rotation = Vector3.new(-90, -89.7982635, -90)
	o28.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o28.Velocity = Vector3.new(-0.000360969483, 0.000753228669, -0.00708122458)
	o28.Anchored = true
	o28.FormFactor = Enum.FormFactor.Plate
	o28.Size = Vector3.new(1, 2.79999995, 1)
	o28.CFrame = CFrame.new(113.818176, 6.80000877, 9.31151104, 0, 3.89985715e-008, -0.999993801, 0, 1, 4.03698408e-008, 1, 0, 0)
	o28.BackSurface = Enum.SurfaceType.Weld
	o28.BottomSurface = Enum.SurfaceType.Weld
	o28.TopSurface = Enum.SurfaceType.Weld
	o28.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o29.Parent = o28
	o29.MeshType = Enum.MeshType.Wedge
	o30.Parent = o1
	o30.BrickColor = BrickColor.new("Institutional white")
	o30.Position = Vector3.new(96.3181992, 4.60000753, 18.3115101)
	o30.Rotation = Vector3.new(-0, 0, -2.26770203e-006)
	o30.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o30.Velocity = Vector3.new(0.00210371148, 0.000697117415, -0.0023025109)
	o30.Anchored = true
	o30.FormFactor = Enum.FormFactor.Plate
	o30.Size = Vector3.new(2, 2.4000001, 1)
	o30.CFrame = CFrame.new(96.3181992, 4.60000753, 18.3115101, 0.999999046, 3.95788291e-008, 0, -3.97897928e-008, 1, 0, 0, 0, 1)
	o30.BackSurface = Enum.SurfaceType.Weld
	o30.BottomSurface = Enum.SurfaceType.Weld
	o30.FrontSurface = Enum.SurfaceType.Weld
	o30.LeftSurface = Enum.SurfaceType.Weld
	o30.RightSurface = Enum.SurfaceType.Weld
	o30.TopSurface = Enum.SurfaceType.Weld
	o30.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o31.Parent = o30
	o32.Parent = o1
	o32.BrickColor = BrickColor.new("Dark stone grey")
	o32.Position = Vector3.new(95.8181839, 4.60000753, 13.8115101)
	o32.Rotation = Vector3.new(90, 89.960434, -90)
	o32.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o32.Velocity = Vector3.new(0.000791871978, 0.00139368721, -0.00215674727)
	o32.Anchored = true
	o32.FormFactor = Enum.FormFactor.Plate
	o32.Size = Vector3.new(8, 2.4000001, 1)
	o32.CFrame = CFrame.new(95.8181839, 4.60000753, 13.8115101, 0, 3.96579551e-008, 0.999999762, 0, 1, -3.97106952e-008, -1, 0, 0)
	o32.BottomSurface = Enum.SurfaceType.Weld
	o32.TopSurface = Enum.SurfaceType.Weld
	o32.Color = Color3.new(0.388235, 0.372549, 0.384314)
	o33.Parent = o32
	o33.Offset = Vector3.new(0, 0, 0.5)
	o33.Scale = Vector3.new(1, 1, 2)
	o34.Parent = o1
	o34.BrickColor = BrickColor.new("Institutional white")
	o34.Position = Vector3.new(93.8181992, 4.00000715, 13.8115101)
	o34.Rotation = Vector3.new(-0, 0, -2.26770203e-006)
	o34.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o34.Velocity = Vector3.new(0.000748508843, 0.00153822941, -0.00166177051)
	o34.Anchored = true
	o34.FormFactor = Enum.FormFactor.Plate
	o34.Size = Vector3.new(3, 1.20000005, 10)
	o34.CFrame = CFrame.new(93.8181992, 4.00000715, 13.8115101, 0.999999046, 3.95788291e-008, 0, -3.97897928e-008, 1, 0, 0, 0, 1)
	o34.BackSurface = Enum.SurfaceType.Weld
	o34.BottomSurface = Enum.SurfaceType.Weld
	o34.FrontSurface = Enum.SurfaceType.Weld
	o34.LeftSurface = Enum.SurfaceType.Weld
	o34.RightSurface = Enum.SurfaceType.Weld
	o34.TopSurface = Enum.SurfaceType.Weld
	o34.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o35.Parent = o34
	o36.Parent = o1
	o36.BrickColor = BrickColor.new("Br. yellowish orange")
	o36.Position = Vector3.new(92.2181854, 4.00000715, 18.211504)
	o36.Rotation = Vector3.new(-0, 0, -2.2601489e-006)
	o36.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o36.Velocity = Vector3.new(0.00203119451, 0.00100810977, -0.00119533355)
	o36.Anchored = true
	o36.FormFactor = Enum.FormFactor.Custom
	o36.Size = Vector3.new(0.200000003, 0.800000012, 0.799999714)
	o36.CFrame = CFrame.new(92.2181854, 4.00000715, 18.211504, 0.999997854, 3.94469524e-008, 0, -3.99216233e-008, 1, 0, 0, 0, 1)
	o36.BackSurface = Enum.SurfaceType.Weld
	o36.BottomSurface = Enum.SurfaceType.Weld
	o36.FrontSurface = Enum.SurfaceType.Weld
	o36.LeftSurface = Enum.SurfaceType.Weld
	o36.RightSurface = Enum.SurfaceType.Weld
	o36.TopSurface = Enum.SurfaceType.Weld
	o36.Color = Color3.new(0.886275, 0.607843, 0.25098)
	o37.Parent = o36
	o38.Parent = o1
	o38.BrickColor = BrickColor.new("Institutional white")
	o38.Position = Vector3.new(99.0602112, 4.60000706, 18.3115101)
	o38.Rotation = Vector3.new(-0, 0, -4.84935117e-006)
	o38.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o38.Velocity = Vector3.new(0.00210371148, 0.000498947338, -0.0031018618)
	o38.Anchored = true
	o38.CanCollide = false
	o38.FormFactor = Enum.FormFactor.Plate
	o38.Size = Vector3.new(3.48000026, 2.4000001, 1)
	o38.CFrame = CFrame.new(99.0602112, 4.60000706, 18.3115101, 1, 8.46371435e-008, 0, -8.46371435e-008, 1, 0, 0, 0, 1)
	o38.BottomSurface = Enum.SurfaceType.Weld
	o38.LeftSurface = Enum.SurfaceType.Weld
	o38.RightSurface = Enum.SurfaceType.Weld
	o38.TopSurface = Enum.SurfaceType.Weld
	o38.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o39.Parent = o1
	o39.BrickColor = BrickColor.new("Really red")
	o39.Position = Vector3.new(113.818176, 4.80000877, 9.31151104)
	o39.Rotation = Vector3.new(-0, 0, -2.2344675e-006)
	o39.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o39.Velocity = Vector3.new(-0.000505513046, 0.000753228669, -0.00737475045)
	o39.Anchored = true
	o39.FormFactor = Enum.FormFactor.Plate
	o39.Size = Vector3.new(1, 1.20000005, 1)
	o39.CFrame = CFrame.new(113.818176, 4.80000877, 9.31151104, 0.999993801, 3.89985715e-008, 0, -4.03698408e-008, 1, 0, 0, 0, 1)
	o39.BackSurface = Enum.SurfaceType.Weld
	o39.BottomSurface = Enum.SurfaceType.Weld
	o39.FrontSurface = Enum.SurfaceType.Weld
	o39.LeftSurface = Enum.SurfaceType.Weld
	o39.RightSurface = Enum.SurfaceType.Weld
	o39.TopSurface = Enum.SurfaceType.Weld
	o39.Color = Color3.new(1, 0, 0)
	o40.Parent = o39
	o41.Parent = o1
	o41.BrickColor = BrickColor.new("Institutional white")
	o41.Position = Vector3.new(113.818054, 3.80000734, 9.31151104)
	o41.Rotation = Vector3.new(-0, 0, -2.23295706e-006)
	o41.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o41.Velocity = Vector3.new(-0.000577784958, 0.000753237749, -0.00752147706)
	o41.Anchored = true
	o41.FormFactor = Enum.FormFactor.Plate
	o41.Size = Vector3.new(1, 0.800000012, 1)
	o41.CFrame = CFrame.new(113.818054, 3.80000734, 9.31151104, 0.999993563, 3.89721997e-008, 0, -4.03962055e-008, 1, 0, 0, 0, 1)
	o41.BackSurface = Enum.SurfaceType.Weld
	o41.BottomSurface = Enum.SurfaceType.Weld
	o41.FrontSurface = Enum.SurfaceType.Weld
	o41.LeftSurface = Enum.SurfaceType.Weld
	o41.RightSurface = Enum.SurfaceType.Weld
	o41.TopSurface = Enum.SurfaceType.Weld
	o41.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o42.Parent = o41
	o43.Parent = o1
	o43.BrickColor = BrickColor.new("Institutional white")
	o43.Position = Vector3.new(105.317894, 8.40000725, 13.8115139)
	o43.Rotation = Vector3.new(-0, 0, -2.21481446e-006)
	o43.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o43.Velocity = Vector3.new(0.00106650498, 0.000707125873, -0.00436840346)
	o43.Anchored = true
	o43.CanCollide = false
	o43.FormFactor = Enum.FormFactor.Plate
	o43.Size = Vector3.new(14, 0.400000006, 8)
	o43.CFrame = CFrame.new(105.317894, 8.40000725, 13.8115139, 1, 3.86558057e-008, 0, -3.86558057e-008, 1, 0, 0, 0, 1)
	o43.BackSurface = Enum.SurfaceType.Weld
	o43.BottomSurface = Enum.SurfaceType.Weld
	o43.FrontSurface = Enum.SurfaceType.Weld
	o43.LeftSurface = Enum.SurfaceType.Weld
	o43.RightSurface = Enum.SurfaceType.Weld
	o43.TopSurface = Enum.SurfaceType.Weld
	o43.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o44.Parent = o43
	o45.Parent = o1
	o45.BrickColor = BrickColor.new("Really black")
	o45.Position = Vector3.new(113.818176, 6.80000782, 11.311511)
	o45.Rotation = Vector3.new(-90, -89.9314728, -90)
	o45.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o45.Velocity = Vector3.new(0.000222070201, 0.000459702482, -0.00708122645)
	o45.Anchored = true
	o45.CanCollide = false
	o45.FormFactor = Enum.FormFactor.Plate
	o45.Size = Vector3.new(3, 2.79999995, 1)
	o45.CFrame = CFrame.new(113.818176, 6.80000782, 11.311511, 0, 3.96052044e-008, -0.999999285, 0, 1, 3.97634281e-008, 1, 0, 0)
	o45.BackSurface = Enum.SurfaceType.Weld
	o45.BottomSurface = Enum.SurfaceType.Weld
	o45.TopSurface = Enum.SurfaceType.Weld
	o45.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o46.Parent = o45
	o46.MeshType = Enum.MeshType.Wedge
	o47.Parent = o1
	o47.BrickColor = BrickColor.new("Institutional white")
	o47.Position = Vector3.new(103.118179, 2.40000772, 13.8115101)
	o47.Rotation = Vector3.new(-0, 0, -2.27223404e-006)
	o47.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o47.Velocity = Vector3.new(0.000632874086, 0.000866103393, -0.0046077203)
	o47.Anchored = true
	o47.FormFactor = Enum.FormFactor.Plate
	o47.Size = Vector3.new(12.3999996, 1.20000005, 10)
	o47.CFrame = CFrame.new(103.118179, 2.40000772, 13.8115101, 0.999999762, 3.96579551e-008, 0, -3.97106952e-008, 1, 0, 0, 0, 1)
	o47.BackSurface = Enum.SurfaceType.Weld
	o47.BottomSurface = Enum.SurfaceType.Weld
	o47.FrontSurface = Enum.SurfaceType.Weld
	o47.LeftSurface = Enum.SurfaceType.Weld
	o47.RightSurface = Enum.SurfaceType.Weld
	o47.TopSurface = Enum.SurfaceType.Weld
	o47.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o48.Parent = o47
	o49.Parent = o1
	o49.BrickColor = BrickColor.new("White")
	o49.Position = Vector3.new(104.018181, 3.20000815, 13.8115101)
	o49.Rotation = Vector3.new(-0, 0, -2.27374471e-006)
	o49.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o49.Velocity = Vector3.new(0.000690691522, 0.000801058719, -0.00475267787)
	o49.Anchored = true
	o49.FormFactor = Enum.FormFactor.Plate
	o49.Size = Vector3.new(20.6000004, 0.400000006, 10)
	o49.CFrame = CFrame.new(104.018181, 3.20000815, 13.8115101, 1, 3.96843305e-008, 0, -3.96843305e-008, 1, 0, 0, 0, 1)
	o49.BackSurface = Enum.SurfaceType.Weld
	o49.BottomSurface = Enum.SurfaceType.Weld
	o49.FrontSurface = Enum.SurfaceType.Weld
	o49.LeftSurface = Enum.SurfaceType.Weld
	o49.RightSurface = Enum.SurfaceType.Weld
	o49.TopSurface = Enum.SurfaceType.Weld
	o49.Color = Color3.new(0.94902, 0.952941, 0.952941)
	o50.Parent = o49
	o51.Parent = o1
	o51.BrickColor = BrickColor.new("Institutional white")
	o51.Position = Vector3.new(107.167747, 5.80000782, 18.3115101)
	o51.Rotation = Vector3.new(-0, 0, -3.14727777e-006)
	o51.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o51.Velocity = Vector3.new(0.00219043763, -8.69987416e-005, -0.00528925471)
	o51.Anchored = true
	o51.FormFactor = Enum.FormFactor.Plate
	o51.Size = Vector3.new(12.3000002, 4.80000019, 1)
	o51.CFrame = CFrame.new(107.167747, 5.80000782, 18.3115101, 1, 5.49303607e-008, 0, -5.49303607e-008, 1, 0, 0, 0, 1)
	o51.BackSurface = Enum.SurfaceType.Weld
	o51.BottomSurface = Enum.SurfaceType.Weld
	o51.FrontSurface = Enum.SurfaceType.Weld
	o51.LeftSurface = Enum.SurfaceType.Weld
	o51.RightSurface = Enum.SurfaceType.Weld
	o51.TopSurface = Enum.SurfaceType.Weld
	o51.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o52.Parent = o51
	o53.Parent = o1
	o53.BrickColor = BrickColor.new("Institutional white")
	o53.Position = Vector3.new(113.818176, 6.80000782, 13.8115101)
	o53.Rotation = Vector3.new(-90, -89.9314728, -90)
	o53.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o53.Velocity = Vector3.new(0.000950869871, 9.27953006e-005, -0.00708122645)
	o53.Anchored = true
	o53.CanCollide = false
	o53.FormFactor = Enum.FormFactor.Plate
	o53.Size = Vector3.new(2, 2.79999995, 1)
	o53.CFrame = CFrame.new(113.818176, 6.80000782, 13.8115101, 0, 3.96052044e-008, -0.999999285, 0, 1, 3.97634281e-008, 1, 0, 0)
	o53.BackSurface = Enum.SurfaceType.Weld
	o53.BottomSurface = Enum.SurfaceType.Weld
	o53.TopSurface = Enum.SurfaceType.Weld
	o53.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o54.Parent = o53
	o54.MeshType = Enum.MeshType.Wedge
	o55.Parent = o1
	o55.BrickColor = BrickColor.new("Really black")
	o55.Position = Vector3.new(113.818176, 6.80000782, 16.3115101)
	o55.Rotation = Vector3.new(-90, -89.9314728, -90)
	o55.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o55.Velocity = Vector3.new(0.0016796696, -0.000274111895, -0.00708122645)
	o55.Anchored = true
	o55.CanCollide = false
	o55.FormFactor = Enum.FormFactor.Plate
	o55.Size = Vector3.new(3, 2.79999995, 1)
	o55.CFrame = CFrame.new(113.818176, 6.80000782, 16.3115101, 0, 3.96052044e-008, -0.999999285, 0, 1, 3.97634281e-008, 1, 0, 0)
	o55.BackSurface = Enum.SurfaceType.Weld
	o55.BottomSurface = Enum.SurfaceType.Weld
	o55.TopSurface = Enum.SurfaceType.Weld
	o55.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o56.Parent = o55
	o56.MeshType = Enum.MeshType.Wedge
	o57.Parent = o1
	o57.BrickColor = BrickColor.new("Institutional white")
	o57.Position = Vector3.new(113.818176, 4.40000582, 13.8115101)
	o57.Rotation = Vector3.new(-0, 0, -2.27223404e-006)
	o57.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o57.Velocity = Vector3.new(0.000777417503, 9.27956426e-005, -0.00743345637)
	o57.Anchored = true
	o57.CanCollide = false
	o57.FormFactor = Enum.FormFactor.Plate
	o57.Size = Vector3.new(1, 2, 8)
	o57.CFrame = CFrame.new(113.818176, 4.40000582, 13.8115101, 0.999999762, 3.96579551e-008, 0, -3.97106952e-008, 1, 0, 0, 0, 1)
	o57.BackSurface = Enum.SurfaceType.Weld
	o57.BottomSurface = Enum.SurfaceType.Weld
	o57.FrontSurface = Enum.SurfaceType.Weld
	o57.LeftSurface = Enum.SurfaceType.Weld
	o57.RightSurface = Enum.SurfaceType.Weld
	o57.TopSurface = Enum.SurfaceType.Weld
	o57.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o58.Parent = o57
	o59.Parent = o1
	o59.BrickColor = BrickColor.new("Institutional white")
	o59.Position = Vector3.new(113.818176, 3.80000734, 18.3115101)
	o59.Rotation = Vector3.new(-0, 0, -2.27223404e-006)
	o59.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o59.Velocity = Vector3.new(0.00204589404, -0.000567637384, -0.00752151385)
	o59.Anchored = true
	o59.FormFactor = Enum.FormFactor.Plate
	o59.Size = Vector3.new(1, 0.800000012, 1)
	o59.CFrame = CFrame.new(113.818176, 3.80000734, 18.3115101, 0.999999762, 3.96579551e-008, 0, -3.97106952e-008, 1, 0, 0, 0, 1)
	o59.BackSurface = Enum.SurfaceType.Weld
	o59.BottomSurface = Enum.SurfaceType.Weld
	o59.FrontSurface = Enum.SurfaceType.Weld
	o59.LeftSurface = Enum.SurfaceType.Weld
	o59.RightSurface = Enum.SurfaceType.Weld
	o59.TopSurface = Enum.SurfaceType.Weld
	o59.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o60.Parent = o59
	o61.Parent = o1
	o61.BrickColor = BrickColor.new("Institutional white")
	o61.Position = Vector3.new(105.317894, 8.40000725, 18.3115101)
	o61.Rotation = Vector3.new(-0, 0, -2.21330401e-006)
	o61.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o61.Velocity = Vector3.new(0.00237834454, 4.6692905e-005, -0.00436840346)
	o61.Anchored = true
	o61.CanCollide = false
	o61.FormFactor = Enum.FormFactor.Plate
	o61.Size = Vector3.new(14, 0.400000006, 1)
	o61.CFrame = CFrame.new(105.317894, 8.40000725, 18.3115101, 0.999999762, 3.86294303e-008, 0, -3.86821704e-008, 1, 0, 0, 0, 1)
	o61.BackSurface = Enum.SurfaceType.Weld
	o61.BottomSurface = Enum.SurfaceType.Weld
	o61.FrontSurface = Enum.SurfaceType.Weld
	o61.LeftSurface = Enum.SurfaceType.Weld
	o61.RightSurface = Enum.SurfaceType.Weld
	o61.TopSurface = Enum.SurfaceType.Weld
	o61.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o62.Parent = o61
	o63.Parent = o1
	o63.BrickColor = BrickColor.new("Institutional white")
	o63.Position = Vector3.new(97.8181839, 5.79500866, 9.31151104)
	o63.Rotation = Vector3.new(-0, 0, -2.36894834e-006)
	o63.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o63.Velocity = Vector3.new(-0.000433602603, 0.00190957636, -0.00256440602)
	o63.Anchored = true
	o63.CanCollide = false
	o63.FormFactor = Enum.FormFactor.Plate
	o63.Size = Vector3.new(1, 4.80999994, 1)
	o63.CFrame = CFrame.new(97.8181839, 5.79500866, 9.31151104, 1, 4.13459489e-008, 0, -4.13459489e-008, 1, 0, 0, 0, 1)
	o63.BottomSurface = Enum.SurfaceType.Weld
	o63.LeftSurface = Enum.SurfaceType.Weld
	o63.RightSurface = Enum.SurfaceType.Weld
	o63.TopSurface = Enum.SurfaceType.Weld
	o63.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o64.Parent = o1
	o64.BrickColor = BrickColor.new("Institutional white")
	o64.Position = Vector3.new(97.8178101, 7.00000858, 18.3115101)
	o64.Rotation = Vector3.new(-0, 0, -2.14529973e-006)
	o64.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o64.Velocity = Vector3.new(0.00227716402, 0.00058873737, -0.00238744705)
	o64.Anchored = true
	o64.CanCollide = false
	o64.FormFactor = Enum.FormFactor.Plate
	o64.Size = Vector3.new(1, 2.4000001, 1)
	o64.CFrame = CFrame.new(97.8178101, 7.00000858, 18.3115101, 0.999999762, 3.74425326e-008, 0, -3.74952727e-008, 1, 0, 0, 0, 1)
	o64.BottomSurface = Enum.SurfaceType.Weld
	o64.LeftSurface = Enum.SurfaceType.Weld
	o64.RightSurface = Enum.SurfaceType.Weld
	o64.TopSurface = Enum.SurfaceType.Weld
	o64.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o65.Parent = o1
	o65.BrickColor = BrickColor.new("Institutional white")
	o65.Position = Vector3.new(113.418167, 2.40000749, 13.8115101)
	o65.Rotation = Vector3.new(-0, 0, -2.27223404e-006)
	o65.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o65.Velocity = Vector3.new(0.000632874086, 0.000121704477, -0.0076103732)
	o65.Anchored = true
	o65.FormFactor = Enum.FormFactor.Plate
	o65.Size = Vector3.new(1.80000007, 1.20000005, 10)
	o65.CFrame = CFrame.new(113.418167, 2.40000749, 13.8115101, 0.999999762, 3.96579551e-008, 0, -3.97106952e-008, 1, 0, 0, 0, 1)
	o65.BackSurface = Enum.SurfaceType.Weld
	o65.BottomSurface = Enum.SurfaceType.Weld
	o65.FrontSurface = Enum.SurfaceType.Weld
	o65.LeftSurface = Enum.SurfaceType.Weld
	o65.RightSurface = Enum.SurfaceType.Weld
	o65.TopSurface = Enum.SurfaceType.Weld
	o65.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o66.Parent = o65
	o67.Parent = o1
	o67.BrickColor = BrickColor.new("Really red")
	o67.Position = Vector3.new(113.817245, 4.80000687, 18.3115101)
	o67.Rotation = Vector3.new(-0, 0, -3.17145691e-006)
	o67.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o67.Velocity = Vector3.new(0.00211816584, -0.000567570096, -0.0073744799)
	o67.Anchored = true
	o67.FormFactor = Enum.FormFactor.Plate
	o67.Size = Vector3.new(1, 1.20000005, 1)
	o67.CFrame = CFrame.new(113.817245, 4.80000687, 18.3115101, 1, 5.53523627e-008, 0, -5.53523627e-008, 1, 0, 0, 0, 1)
	o67.BackSurface = Enum.SurfaceType.Weld
	o67.BottomSurface = Enum.SurfaceType.Weld
	o67.FrontSurface = Enum.SurfaceType.Weld
	o67.LeftSurface = Enum.SurfaceType.Weld
	o67.RightSurface = Enum.SurfaceType.Weld
	o67.TopSurface = Enum.SurfaceType.Weld
	o67.Color = Color3.new(1, 0, 0)
	o68.Parent = o67
	o69.Parent = o1
	o69.BrickColor = BrickColor.new("Institutional white")
	o69.Position = Vector3.new(112.817894, 8.40000725, 13.8115139)
	o69.Rotation = Vector3.new(-0, 0, -2.21330401e-006)
	o69.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o69.Velocity = Vector3.new(0.00106650498, 0.000165087578, -0.00655480288)
	o69.Anchored = true
	o69.CanCollide = false
	o69.FormFactor = Enum.FormFactor.Plate
	o69.Size = Vector3.new(1, 0.400000006, 10)
	o69.CFrame = CFrame.new(112.817894, 8.40000725, 13.8115139, 0.999999762, 3.86294303e-008, 0, -3.86821704e-008, 1, 0, 0, 0, 1)
	o69.BackSurface = Enum.SurfaceType.Weld
	o69.BottomSurface = Enum.SurfaceType.Weld
	o69.FrontSurface = Enum.SurfaceType.Weld
	o69.LeftSurface = Enum.SurfaceType.Weld
	o69.RightSurface = Enum.SurfaceType.Weld
	o69.TopSurface = Enum.SurfaceType.Weld
	o69.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o70.Parent = o69
	o71.Parent = o1
	o71.BrickColor = BrickColor.new("Really black")
	o71.Position = Vector3.new(92.2181854, 3.8000083, 13.8115101)
	o71.Rotation = Vector3.new(-0, 0, -2.2601489e-006)
	o71.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o71.Velocity = Vector3.new(0.0007340546, 0.00165386556, -0.00122468593)
	o71.Anchored = true
	o71.FormFactor = Enum.FormFactor.Custom
	o71.Size = Vector3.new(0.200000003, 0.800000012, 6)
	o71.CFrame = CFrame.new(92.2181854, 3.8000083, 13.8115101, 0.999997854, 3.94469524e-008, 0, -3.99216233e-008, 1, 0, 0, 0, 1)
	o71.BackSurface = Enum.SurfaceType.Weld
	o71.BottomSurface = Enum.SurfaceType.Weld
	o71.FrontSurface = Enum.SurfaceType.Weld
	o71.LeftSurface = Enum.SurfaceType.Weld
	o71.RightSurface = Enum.SurfaceType.Weld
	o71.TopSurface = Enum.SurfaceType.Weld
	o71.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o72.Parent = o71
	o73.Name = "Head"
	o73.Parent = o1
	o73.Material = Enum.Material.SmoothPlastic
	o73.BrickColor = BrickColor.new("Institutional white")
	o73.Position = Vector3.new(99.207077, 7.026577, 15.2047167)
	o73.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o73.Anchored = true
	o73.FormFactor = Enum.FormFactor.Symmetric
	o73.Size = Vector3.new(2, 1, 1)
	o73.CFrame = CFrame.new(99.207077, 7.026577, 15.2047167, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o73.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o73.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o73.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o73.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o73.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o73.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o73.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o74.Parent = o73
	o74.Scale = Vector3.new(1.25, 1.25, 1.25)
	o75.Name = "face"
	o75.Parent = o73
	o75.Texture = "rbxasset://textures/face.png"
	o76.Parent = o1
	o76.BrickColor = BrickColor.new("Institutional white")
	o76.Position = Vector3.new(99.6954269, 5.81500673, 9.31151104)
	o76.Rotation = Vector3.new(-0, 0, -8.82515178e-006)
	o76.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o76.Velocity = Vector3.new(-0.000432157307, 0.00177390513, -0.00310872309)
	o76.Anchored = true
	o76.CanCollide = false
	o76.FormFactor = Enum.FormFactor.Plate
	o76.Size = Vector3.new(2.76000023, 4.82999992, 1)
	o76.CFrame = CFrame.new(99.6954269, 5.81500673, 9.31151104, 1, 1.54027958e-007, 0, -1.54027958e-007, 1, 0, 0, 0, 1)
	o76.BottomSurface = Enum.SurfaceType.Weld
	o76.LeftSurface = Enum.SurfaceType.Weld
	o76.RightSurface = Enum.SurfaceType.Weld
	o76.TopSurface = Enum.SurfaceType.Weld
	o76.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o77.Parent = o1
	o77.BrickColor = BrickColor.new("Institutional white")
	o77.Position = Vector3.new(100.909996, 5.80000877, 14.2915134)
	o77.Rotation = Vector3.new(-0, 0, -7.89941078e-006)
	o77.RotVelocity = Vector3.new(0.000146762875, 0.000291519886, -7.22717741e-005)
	o77.Velocity = Vector3.new(0.0010185279, 0.000955246738, -0.00346499542)
	o77.Anchored = true
	o77.FormFactor = Enum.FormFactor.Plate
	o77.Size = Vector3.new(0.200000003, 4.80000019, 9.0199995)
	o77.CFrame = CFrame.new(100.909996, 5.80000877, 14.2915134, 1, 1.37870728e-007, 0, -1.37870728e-007, 1, 0, 0, 0, 1)
	o77.BackSurface = Enum.SurfaceType.Weld
	o77.BottomSurface = Enum.SurfaceType.Weld
	o77.FrontSurface = Enum.SurfaceType.Weld
	o77.LeftSurface = Enum.SurfaceType.Weld
	o77.RightSurface = Enum.SurfaceType.Weld
	o77.TopSurface = Enum.SurfaceType.Weld
	o77.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o78.Parent = o77
	o79.Name = "Head"
	o79.Parent = o1
	o79.Material = Enum.Material.SmoothPlastic
	o79.BrickColor = BrickColor.new("Institutional white")
	o79.Position = Vector3.new(103.10894, 7.49666739, 15.2047167)
	o79.Rotation = Vector3.new(-1.53054156e-008, -0.95580709, -1.83469444e-006)
	o79.Anchored = true
	o79.FormFactor = Enum.FormFactor.Symmetric
	o79.Size = Vector3.new(2, 1, 1)
	o79.CFrame = CFrame.new(103.10894, 7.49666739, 15.2047167, 0.999860883, 3.20170024e-008, -0.0166812073, -3.20170024e-008, 1, 2.67092765e-010, 0.0166812055, 2.67026595e-010, 0.999860942)
	o79.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o79.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o79.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o79.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o79.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o79.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o79.Color = Color3.new(0.972549, 0.972549, 0.972549)
	o80.Parent = o79
	o80.Scale = Vector3.new(1.25, 1.25, 1.25)
	o81.Name = "face"
	o81.Parent = o79
	o81.Texture = "rbxasset://textures/face.png"
	o82.Name = "Handle"
	o82.Parent = o1
	o82.Material = Enum.Material.SmoothPlastic
	o82.Position = Vector3.new(103.10894, 7.34666729, 15.2047167)
	o82.Rotation = Vector3.new(-1.53054156e-008, -0.95580709, -1.83469444e-006)
	o82.Anchored = true
	o82.CanCollide = false
	o82.FormFactor = Enum.FormFactor.Symmetric
	o82.Size = Vector3.new(2, 2, 2)
	o82.CFrame = CFrame.new(103.10894, 7.34666729, 15.2047167, 0.999860883, 3.20170024e-008, -0.0166812073, -3.20170024e-008, 1, 2.67092765e-010, 0.0166812055, 2.67026595e-010, 0.999860942)
	o82.BottomSurface = Enum.SurfaceType.Smooth
	o82.TopSurface = Enum.SurfaceType.Smooth
	o83.Parent = o82
	o83.MeshId = "http://www.roblox.com/asset/?id=15393031"
	o83.TextureId = "http://www.roblox.com/asset/?id=15393013"
	o83.MeshType = Enum.MeshType.FileMesh
	o84.Parent = o1
	o84.NameOcclusion = Enum.NameOcclusion.NoOcclusion
	o84.RightLeg = o94
	o84.LeftLeg = o96
	o84.Torso = o87
	o84.Health = 0
	o84.MaxHealth = 0
	o85.Name = "TPPART"
	o85.Parent = o1
	o85.Transparency = 1
	o85.Position = Vector3.new(104.155182, 4.24109221, 12.6003485)
	o85.Rotation = Vector3.new(-0, 0, -3.5910773e-006)
	o85.Anchored = true
	o85.CanCollide = false
	o85.Size = Vector3.new(4, 1, 2)
	o85.CFrame = CFrame.new(104.155182, 4.24109221, 12.6003485, 1, 6.26761221e-008, 0, -6.26761221e-008, 1, 0, 0, 0, 1)
	o86.Name = "TPPART2"
	o86.Parent = o1
	o86.Transparency = 1
	o86.Position = Vector3.new(104.155182, 5.40188599, 6.32408237)
	o86.Rotation = Vector3.new(-0, 0, -3.5910773e-006)
	o86.Anchored = true
	o86.CanCollide = false
	o86.Size = Vector3.new(4, 1, 2)
	o86.CFrame = CFrame.new(104.155182, 5.40188599, 6.32408237, 1, 6.26761221e-008, 0, -6.26761221e-008, 1, 0, 0, 0, 1)
	o87.Name = "Torso"
	o87.Parent = o1
	o87.Material = Enum.Material.SmoothPlastic
	o87.BrickColor = BrickColor.new("Navy blue")
	o87.Position = Vector3.new(99.207077, 5.526577, 15.2047167)
	o87.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o87.Anchored = true
	o87.FormFactor = Enum.FormFactor.Symmetric
	o87.Size = Vector3.new(2, 2, 1)
	o87.CFrame = CFrame.new(99.207077, 5.526577, 15.2047167, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o87.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o87.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o87.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o87.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o87.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o87.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o87.Color = Color3.new(0, 0.12549, 0.376471)
	o88.Name = "roblox"
	o88.Parent = o87
	o89.Name = "Right Shoulder"
	o89.Parent = o87
	o89.C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	o89.C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	o89.Part0 = o87
	o89.Part1 = o95
	o89.DesiredAngle = -0.062025275081396
	o89.MaxVelocity = 0.15000000596046
	o90.Name = "Left Shoulder"
	o90.Parent = o87
	o90.C0 = CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	o90.C1 = CFrame.new(0.5, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	o90.Part0 = o87
	o90.Part1 = o97
	o90.DesiredAngle = -0.062025275081396
	o90.MaxVelocity = 0.15000000596046
	o91.Name = "Right Hip"
	o91.Parent = o87
	o91.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	o91.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	o91.Part0 = o87
	o91.Part1 = o94
	o91.DesiredAngle = 0.062025275081396
	o91.MaxVelocity = 0.10000000149012
	o92.Name = "Left Hip"
	o92.Parent = o87
	o92.C0 = CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	o92.C1 = CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	o92.Part0 = o87
	o92.Part1 = o96
	o92.DesiredAngle = 0.062025275081396
	o92.MaxVelocity = 0.10000000149012
	o93.Name = "Neck"
	o93.Parent = o87
	o93.C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	o93.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	o93.Part0 = o87
	o93.Part1 = o73
	o93.MaxVelocity = 0.10000000149012
	o94.Name = "Right Leg"
	o94.Parent = o1
	o94.Material = Enum.Material.SmoothPlastic
	o94.BrickColor = BrickColor.new("Navy blue")
	o94.Position = Vector3.new(99.215416, 3.526577, 14.7047863)
	o94.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o94.Anchored = true
	o94.CanCollide = false
	o94.FormFactor = Enum.FormFactor.Symmetric
	o94.Size = Vector3.new(1, 2, 1)
	o94.CFrame = CFrame.new(99.215416, 3.526577, 14.7047863, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o94.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o94.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o94.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o94.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o94.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o94.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o94.Color = Color3.new(0, 0.12549, 0.376471)
	o95.Name = "Right Arm"
	o95.Parent = o1
	o95.Material = Enum.Material.SmoothPlastic
	o95.BrickColor = BrickColor.new("Maroon")
	o95.Position = Vector3.new(99.2321014, 5.526577, 13.7049236)
	o95.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o95.Anchored = true
	o95.CanCollide = false
	o95.FormFactor = Enum.FormFactor.Symmetric
	o95.Size = Vector3.new(1, 2, 1)
	o95.CFrame = CFrame.new(99.2321014, 5.526577, 13.7049236, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o95.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o95.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o95.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o95.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o95.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o95.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o95.Color = Color3.new(0.458824, 0, 0)
	o96.Name = "Left Leg"
	o96.Parent = o1
	o96.Material = Enum.Material.SmoothPlastic
	o96.BrickColor = BrickColor.new("Navy blue")
	o96.Position = Vector3.new(99.1987381, 3.526577, 15.7046452)
	o96.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o96.Anchored = true
	o96.CanCollide = false
	o96.FormFactor = Enum.FormFactor.Symmetric
	o96.Size = Vector3.new(1, 2, 1)
	o96.CFrame = CFrame.new(99.1987381, 3.526577, 15.7046452, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o96.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o96.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o96.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o96.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o96.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o96.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o96.Color = Color3.new(0, 0.12549, 0.376471)
	o97.Name = "Left Arm"
	o97.Parent = o1
	o97.Material = Enum.Material.SmoothPlastic
	o97.BrickColor = BrickColor.new("Maroon")
	o97.Position = Vector3.new(99.1820602, 5.526577, 16.7045078)
	o97.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o97.Anchored = true
	o97.CanCollide = false
	o97.FormFactor = Enum.FormFactor.Symmetric
	o97.Size = Vector3.new(1, 2, 1)
	o97.CFrame = CFrame.new(99.1820602, 5.526577, 16.7045078, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o97.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o97.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o97.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o97.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o97.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o97.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o97.Color = Color3.new(0.458824, 0, 0)
	o98.Name = "Torso"
	o98.Parent = o1
	o98.Material = Enum.Material.SmoothPlastic
	o98.BrickColor = BrickColor.new("Navy blue")
	o98.Position = Vector3.new(103.10894, 5.99666739, 15.2047167)
	o98.Rotation = Vector3.new(-1.53054156e-008, -0.95580709, -1.83469444e-006)
	o98.Anchored = true
	o98.FormFactor = Enum.FormFactor.Symmetric
	o98.Size = Vector3.new(2, 2, 1)
	o98.CFrame = CFrame.new(103.10894, 5.99666739, 15.2047167, 0.999860883, 3.20170024e-008, -0.0166812073, -3.20170024e-008, 1, 2.67092765e-010, 0.0166812055, 2.67026595e-010, 0.999860942)
	o98.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o98.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o98.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o98.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o98.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o98.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o98.Color = Color3.new(0, 0.12549, 0.376471)
	o99.Name = "roblox"
	o99.Parent = o98
	o100.Name = "Right Hip"
	o100.Parent = o98
	o100.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	o100.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	o100.Part0 = o98
	o100.Part1 = o103
	o100.DesiredAngle = 0.062025275081396
	o100.MaxVelocity = 0.10000000149012
	o101.Name = "Left Hip"
	o101.Parent = o98
	o101.C0 = CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	o101.C1 = CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	o101.Part0 = o98
	o101.Part1 = o105
	o101.DesiredAngle = 0.062025275081396
	o101.MaxVelocity = 0.10000000149012
	o102.Name = "Neck"
	o102.Parent = o98
	o102.C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	o102.C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	o102.Part0 = o98
	o102.Part1 = o79
	o102.MaxVelocity = 0.10000000149012
	o103.Name = "Right Leg"
	o103.Parent = o1
	o103.Material = Enum.Material.SmoothPlastic
	o103.BrickColor = BrickColor.new("Really black")
	o103.Position = Vector3.new(103.608864, 3.99666739, 15.2130556)
	o103.Rotation = Vector3.new(-1.53054156e-008, -0.95580709, -1.83469444e-006)
	o103.Anchored = true
	o103.CanCollide = false
	o103.FormFactor = Enum.FormFactor.Symmetric
	o103.Size = Vector3.new(1, 2, 1)
	o103.CFrame = CFrame.new(103.608864, 3.99666739, 15.2130556, 0.999860883, 3.20170024e-008, -0.0166812073, -3.20170024e-008, 1, 2.67092765e-010, 0.0166812055, 2.67026595e-010, 0.999860942)
	o103.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o103.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o103.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o103.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o103.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o103.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o103.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o104.Name = "Right Arm"
	o104.Parent = o1
	o104.Material = Enum.Material.SmoothPlastic
	o104.BrickColor = BrickColor.new("Maroon")
	o104.Position = Vector3.new(104.615349, 5.89646101, 14.8330393)
	o104.Rotation = Vector3.new(45.0039597, -0.675833881, 0.675880313)
	o104.Anchored = true
	o104.CanCollide = false
	o104.FormFactor = Enum.FormFactor.Symmetric
	o104.Size = Vector3.new(1, 2, 1)
	o104.CFrame = CFrame.new(104.615349, 5.89646101, 14.8330393, 0.999860883, -0.0117952423, -0.0117952526, 0, 0.707107067, -0.707106411, 0.0166809987, 0.707008064, 0.707008719)
	o104.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o104.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o104.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o104.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o104.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o104.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o104.Color = Color3.new(0.458824, 0, 0)
	o105.Name = "Left Leg"
	o105.Parent = o1
	o105.Material = Enum.Material.SmoothPlastic
	o105.BrickColor = BrickColor.new("Really black")
	o105.Position = Vector3.new(102.609009, 3.99666739, 15.1963739)
	o105.Rotation = Vector3.new(-1.53054156e-008, -0.95580709, -1.83469444e-006)
	o105.Anchored = true
	o105.CanCollide = false
	o105.FormFactor = Enum.FormFactor.Symmetric
	o105.Size = Vector3.new(1, 2, 1)
	o105.CFrame = CFrame.new(102.609009, 3.99666739, 15.1963739, 0.999860883, 3.20170024e-008, -0.0166812073, -3.20170024e-008, 1, 2.67092765e-010, 0.0166812055, 2.67026595e-010, 0.999860942)
	o105.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o105.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o105.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o105.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o105.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o105.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o105.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o106.Name = "Left Arm"
	o106.Parent = o1
	o106.Material = Enum.Material.SmoothPlastic
	o106.BrickColor = BrickColor.new("Maroon")
	o106.Position = Vector3.new(101.617271, 5.96075201, 14.6924496)
	o106.Rotation = Vector3.new(45.0039597, -0.675833881, 0.675880313)
	o106.Anchored = true
	o106.CanCollide = false
	o106.FormFactor = Enum.FormFactor.Symmetric
	o106.Size = Vector3.new(1, 2, 1)
	o106.CFrame = CFrame.new(101.617271, 5.96075201, 14.6924496, 0.999860883, -0.0117952423, -0.0117952526, 0, 0.707107067, -0.707106411, 0.0166809987, 0.707008064, 0.707008719)
	o106.BackSurface = Enum.SurfaceType.SmoothNoOutlines
	o106.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	o106.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
	o106.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
	o106.RightSurface = Enum.SurfaceType.SmoothNoOutlines
	o106.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	o106.Color = Color3.new(0.458824, 0, 0)
	o107.Parent = o1
	o107.Position = Vector3.new(110.917458, 1.50000954, 18.4564953)
	o107.Rotation = Vector3.new(-90, 1.20620803e-006, -180)
	o107.Anchored = true
	o107.FormFactor = Enum.FormFactor.Symmetric
	o107.Size = Vector3.new(2.39999986, 1.31000006, 2.39999986)
	o107.CFrame = CFrame.new(110.917458, 1.50000954, 18.4564953, -1, 2.98044895e-008, 2.10523012e-008, 2.10523012e-008, 7.54615499e-008, 1, 2.9804486e-008, 1, -7.54615499e-008)
	o108.Parent = o107
	o109.Parent = o1
	o109.BrickColor = BrickColor.new("Really black")
	o109.Position = Vector3.new(110.917442, 1.50002527, 9.1665411)
	o109.Rotation = Vector3.new(-90, 6.45824184e-006, 2.56150702e-006)
	o109.Anchored = true
	o109.FormFactor = Enum.FormFactor.Symmetric
	o109.Size = Vector3.new(3, 1.20000005, 3)
	o109.CFrame = CFrame.new(110.917442, 1.50002527, 9.1665411, 1, -4.47067308e-008, 1.12717586e-007, -1.12717586e-007, -5.51334445e-009, 1, -4.47067308e-008, -1, -5.51334933e-009)
	o109.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o110.Parent = o109
	o111.Parent = o1
	o111.BrickColor = BrickColor.new("Really black")
	o111.Position = Vector3.new(110.917458, 1.50000954, 18.4564953)
	o111.Rotation = Vector3.new(-90, 1.20620803e-006, -180)
	o111.Anchored = true
	o111.FormFactor = Enum.FormFactor.Symmetric
	o111.Size = Vector3.new(3, 1.20000005, 3)
	o111.CFrame = CFrame.new(110.917458, 1.50000954, 18.4564953, -1, 2.98044895e-008, 2.10523012e-008, 2.10523012e-008, 7.54615499e-008, 1, 2.9804486e-008, 1, -7.54615499e-008)
	o111.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o112.Parent = o111
	o113.Parent = o1
	o113.Position = Vector3.new(95.3486252, 1.50002623, 9.1665411)
	o113.Rotation = Vector3.new(-90, 6.45824184e-006, 2.56150702e-006)
	o113.Anchored = true
	o113.FormFactor = Enum.FormFactor.Symmetric
	o113.Size = Vector3.new(2.39999986, 1.31000006, 2.39999986)
	o113.CFrame = CFrame.new(95.3486252, 1.50002623, 9.1665411, 1, -4.47067308e-008, 1.12717586e-007, -1.12717586e-007, -5.51334445e-009, 1, -4.47067308e-008, -1, -5.51334933e-009)
	o114.Parent = o113
	o115.Parent = o1
	o115.BrickColor = BrickColor.new("Really black")
	o115.Position = Vector3.new(95.3486252, 1.50002623, 9.1665411)
	o115.Rotation = Vector3.new(-90, 6.45824184e-006, 2.56150702e-006)
	o115.Anchored = true
	o115.FormFactor = Enum.FormFactor.Symmetric
	o115.Size = Vector3.new(3, 1.20000005, 3)
	o115.CFrame = CFrame.new(95.3486252, 1.50002623, 9.1665411, 1, -4.47067308e-008, 1.12717586e-007, -1.12717586e-007, -5.51334445e-009, 1, -4.47067308e-008, -1, -5.51334933e-009)
	o115.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o116.Parent = o115
	o117.Parent = o1
	o117.BrickColor = BrickColor.new("Really black")
	o117.Position = Vector3.new(95.3486252, 1.50001001, 18.4564877)
	o117.Rotation = Vector3.new(-90, 1.20620803e-006, -180)
	o117.Anchored = true
	o117.FormFactor = Enum.FormFactor.Symmetric
	o117.Size = Vector3.new(3, 1.20000005, 3)
	o117.CFrame = CFrame.new(95.3486252, 1.50001001, 18.4564877, -1, 2.98044895e-008, 2.10523012e-008, 2.10523012e-008, 7.54615499e-008, 1, 2.9804486e-008, 1, -7.54615499e-008)
	o117.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	o118.Parent = o117
	o119.Parent = o1
	o119.Position = Vector3.new(110.917442, 1.50002527, 9.1665411)
	o119.Rotation = Vector3.new(-90, 6.45824184e-006, 2.56150702e-006)
	o119.Anchored = true
	o119.FormFactor = Enum.FormFactor.Symmetric
	o119.Size = Vector3.new(2.39999986, 1.31000006, 2.39999986)
	o119.CFrame = CFrame.new(110.917442, 1.50002527, 9.1665411, 1, -4.47067308e-008, 1.12717586e-007, -1.12717586e-007, -5.51334445e-009, 1, -4.47067308e-008, -1, -5.51334933e-009)
	o120.Parent = o119
	o121.Name = "Handle"
	o121.Parent = o1
	o121.Material = Enum.Material.SmoothPlastic
	o121.Position = Vector3.new(99.207077, 6.8765769, 15.2047167)
	o121.Rotation = Vector3.new(5.49961514e-005, 89.0444794, -5.50190998e-005)
	o121.Anchored = true
	o121.CanCollide = false
	o121.FormFactor = Enum.FormFactor.Symmetric
	o121.Size = Vector3.new(2, 2, 2)
	o121.CFrame = CFrame.new(99.207077, 6.8765769, 15.2047167, 0.0166787934, 1.60160507e-008, 0.999860942, -5.34079281e-010, 1, -1.60093698e-008, -0.999861002, -2.66988043e-010, 0.0166787915)
	o121.BottomSurface = Enum.SurfaceType.Smooth
	o121.TopSurface = Enum.SurfaceType.Smooth
	o122.Parent = o121
	o122.MeshId = "http://www.roblox.com/asset/?id=15393031"
	o122.TextureId = "http://www.roblox.com/asset/?id=15393013"
	o122.MeshType = Enum.MeshType.FileMesh
	o123.Name = "RPPART"
	o123.Parent = o1
	o123.Transparency = 1
	o123.Position = Vector3.new(103.454132, 5.33460093, 13.0707426)
	o123.Rotation = Vector3.new(-90, 0, -0)
	o123.Anchored = true
	o123.CanCollide = false
	o123.Size = Vector3.new(4, 1, 2)
	o123.CFrame = CFrame.new(103.454132, 5.33460093, 13.0707426, 1, 0, 0, 0, 0, 1, 0, -1, 0)
	o124.Parent = o12
	o124.Texture = "http://roblox.com/asset/?id=112031763"
	function MoveY(model, Position)
		for _,part in pairs (model:GetChildren()) do
			if part.ClassName == "Part" then
				part.CFrame = part.CFrame + Vector3.new(0,Position,0)
			end
		end
	end
	function MoveX(model, Position)
		for _,part in pairs (model:GetChildren()) do
			if part.ClassName == "Part" then
				part.CFrame = part.CFrame + Vector3.new(Position,0,0)
			end
		end
	end
	function MoveSpawn(model, PLAYERPOS)
		for _,part in pairs (model:GetChildren()) do
			if part.ClassName == "Part" then
				part.CFrame = part.CFrame + PLAYERPOS + Vector3.new(50,-2.7,-5)
			end
		end
	end
	function MoveZ(model, Position)
		for _,part in pairs (model:GetChildren()) do
			if part.ClassName == "Part" then
				part.CFrame = part.CFrame + Vector3.new(0,0,Position)
			end
		end
	end
	function MoveZPart(Part, Position)
		Part.CFrame = Part.CFrame + Vector3.new(0,0,Position)
	end
	function MoveXPart(Part, Position)
		Part.CFrame = Part.CFrame + Vector3.new(Position,0,0)
	end
	game.Players[Victim].Character.HumanoidRootPart.Anchored = true
	OMGCREEPY = Instance.new("Sound")
	OMGCREEPY.Parent = o1
	OMGCREEPY.Volume = .5
	OMGCREEPY.SoundId = "rbxassetid://177775134"
	for i,v in pairs (o1:GetChildren()) do
		if v:IsA("Part") then
			v.Material = "SmoothPlastic"
			v.BackSurface = "SmoothNoOutlines"
			v.FrontSurface = "SmoothNoOutlines"
			v.BottomSurface = "SmoothNoOutlines"
			v.LeftSurface = "SmoothNoOutlines"
			v.RightSurface = "SmoothNoOutlines"
			v.TopSurface = "SmoothNoOutlines"
		end
	end
	OMGCREEPY:Play()
	o21:Play()
	MoveSpawn(o1,game.Players[Victim].Character.HumanoidRootPart.Position)
	for i=1,51 do
		MoveX(o1,-3)
		wait(.05)
	end
	wait(.5)
	MoveZPart(o12,-1)
	wait(.2)
	for i=1,6 do
		MoveXPart(o12,1)
		wait(.1)
	end
	wait(.5)
	game.Players[Victim].Character.HumanoidRootPart.CFrame = o86.CFrame
	wait(.5)
	game.Players[Victim].Character.HumanoidRootPart.CFrame = o85.CFrame
	wait(.5)
	MoveZPart(o12,1)
	wait(.2)
	for i=1,6 do
		MoveXPart(o12,-1)
		wait(.1)
	end
	for i=1,50 do
		MoveX(o1,-3)
		game.Players[Victim].Character.HumanoidRootPart.CFrame = o85.CFrame
		wait(.05)
	end
	game.Players[Victim].Character.Head.face.Texture = "rbxassetid://629925029"
	game.Players[Victim].Character.HumanoidRootPart.CFrame = o123.CFrame
	SCREAM = Instance.new("Sound")
	SCREAM.Parent = game.Players[Victim].Character.Head
	SCREAM.SoundId = "rbxassetid://138167455"
	SCREAM:Play()
	wait(2.5)
	game.Players[Victim].Character.Head.BrickColor = BrickColor.new("Maroon")
	MoveZPart(o12,-1)
	wait(.2)
	for i=1,6 do
		MoveXPart(o12,1)
		wait(.1)
	end
	wait(.5)
	game.Players[Victim].Character.HumanoidRootPart.CFrame = o86.CFrame
	wait(.5)
	MoveZPart(o12,1)
	wait(.2)
	for i=1,6 do
		MoveXPart(o12,-1)
		wait(.1)
	end
	game.Players[Victim].Character.Humanoid.Health = 0
	player = game.Players[Victim]
	char = player.Character
	char.Archivable = true
	local rg = char:Clone()
	rg.HumanoidRootPart:Destroy()
	rg.Name = ""
	rg.Humanoid.MaxHealth = 0
	for i, v in pairs(rg.Torso:GetChildren()) do
		if v:IsA("Motor6D") then
			v:Destroy()
		end
	end
	local n = Instance.new("Glue", rg.Torso)
	n.Name = "Neck"
	n.Part0 = rg.Torso
	n.Part1 = rg.Head
	n.C0 = CFrame.new(0, 1, 0)
	n.C1 = CFrame.new(0, -0.5, 0)
	local rs = Instance.new("Glue", rg.Torso)
	rs.Name = "Right Shoulder"
	rs.Part0 = rg.Torso
	rs.Part1 = rg["Right Arm"]
	rs.C0 = CFrame.new(1.5, 0.5, 0)
	rs.C1 = CFrame.new(0, 0.5, 0)
	local ls = Instance.new("Glue", rg.Torso)
	ls.Name = "Left Shoulder"
	ls.Part0 = rg.Torso
	ls.Part1 = rg["Left Arm"]
	ls.C0 = CFrame.new(-1.5, 0.5, 0)
	ls.C1 = CFrame.new(0, 0.5, 0)
	local rh = Instance.new("Glue", rg.Torso)
	rh.Name = "Right Hip"
	rh.Part0 = rg.Torso
	rh.Part1 = rg["Right Leg"]
	rh.C0 = CFrame.new(0.5, -1, 0)
	rh.C1 = CFrame.new(0, 1, 0)
	local lh = Instance.new("Glue", rg.Torso)
	lh.Name = "Left Hip"
	lh.Part0 = rg.Torso
	lh.Part1 = rg["Left Leg"]
	lh.C0 = CFrame.new(-0.5, -1, 0)
	lh.C1 = CFrame.new(0, 1, 0)
	char.Torso:Destroy()
	char.Head:Destroy()
	char["Left Leg"]:Destroy()
	char["Left Arm"]:Destroy()
	char["Right Leg"]:Destroy()
	char["Right Arm"]:Destroy()
	rg.Parent = game.Workspace
	rg.Head.BrickColor = BrickColor.new("Maroon")
	function DEATH()
		OHHNELLY = Instance.new("Part")
		OHHNELLY.Parent = workspace
		OHHNELLY.Anchored = false
		OHHNELLY.Material = Enum.Material.SmoothPlastic
		OHHNELLY.BrickColor = BrickColor.new("Maroon")
		OHHNELLY.Size = Vector3.new(0.200000003, 0.200000003, 0.200000003)
		OHHNELLY.Position = rg.Head.Position
		OHHNELLY.Color = Color3.new(0.458824, 0, 0)
		OHHNELLY.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		OHHNELLY.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		OHHNELLY.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		OHHNELLY.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		OHHNELLY.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		OHHNELLY.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	end
	for i=1,20 do
		DEATH()
		MoveX(o1,-3)
		wait(.05)
	end
	o1:Destroy()
	end

ADD_COMMAND('van','van [plr]',{'kidnap', 'clown', 'icecream'},
function(ARGS, SPEAKER)
	local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
	for i,v in pairs(PLAYERS) do
		VAN(_PLAYERS[v])
	end
end)

ADD_COMMAND('crush','crush [plr]',{'thwomp'},
function(ARGS,SPEAKER)
    local PLAYERS = GET_PLAYER(ARGS[1], SPEAKER)
    for _,v in pairs(PLAYERS) do
        local plr = _PLAYERS[v]
        if plr and plr.Character then
            local char = plr.Character
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            local hum = char:FindFirstChild("Humanoid")
            if torso and hum then
                local thwomp = Instance.new("Part", workspace)
                thwomp.Size = Vector3.new(12,12,6)
                thwomp.Position = torso.Position + Vector3.new(0,40,0)
		        thwomp.Material = "Slate"
                thwomp.Anchored = false
                thwomp.CanCollide = true
                thwomp.BrickColor = BrickColor.new("Medium stone grey")

                local thwompaugh = Instance.new("Sound", thwomp)
                thwompaugh.SoundId = "rbxassetid://3123007321"
                thwompaugh.Volume = 1
                thwompaugh:Play()

                thwomp.Touched:Connect(function(hit)
                    if hit.Parent == char then
                        hum.WalkSpeed = 0
                        hum.JumpPower = 0
                        hum.Health = 0
                        local splat = Instance.new("Sound", torso)
                        splat.SoundId = "rbxassetid://264486467"
                        splat.Volume = 1
                        splat:Play()
                        for i = 1, 10 do
                            local gore = Instance.new("Part", workspace)
                            gore.Size = Vector3.new(0.3,0.3,0.3)
                            gore.Position = torso.Position + Vector3.new(0,2,0)
                            gore.BrickColor = BrickColor.new("Really red")
                            gore.Velocity = Vector3.new(math.random(-25,25), math.random(10,35), math.random(-25,25))
                            gore.CanCollide = false
                            game:GetService("Debris"):AddItem(gore,5)
                        end
                        task.delay(5,function()
                            thwomp.Anchored = true
                            thwomp.Position = thwomp.Position + Vector3.new(0,40,0)
                            task.delay(3,function()
                                thwomp:Destroy()
                            end)
                        end)
                    end
                end)
            end
        end
    end
end)

--// FE shit
ADD_COMMAND('fekill', 'fekill [plr]', {}, function(ARGS, SPEAKER)
    local players = getPlayer(ARGS[1], SPEAKER)
    for _, v in pairs(players) do
        -- illremember's cool fe kill script
        local Target = gPlayers[v].Name
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        LocalPlayer.Character.Humanoid.Name = 1
        local l = LocalPlayer.Character["1"]:Clone()
        l.Parent = LocalPlayer.Character
        l.Name = "Humanoid"
        wait(0.1)
        LocalPlayer.Character["1"]:Destroy()

        game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
        LocalPlayer.Character.Animate.Disabled = true
        wait(0.1)
        LocalPlayer.Character.Animate.Disabled = false
        LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"

        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            LocalPlayer.Character.Humanoid:EquipTool(tool)
            tool.CanBeDropped = true
        end

        wait(0.1)
        local targetChar = Players[Target].Character
        LocalPlayer.Character.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
        wait(0.1)
        LocalPlayer.Character.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
        wait(0.2)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-10000, -100, -10000))
    end
end)

ADD_COMMAND('fegod','fegod',{},
function(ARGS, SPEAKER)
    local lp = gPlayers.LocalPlayer
    lp.Character.Humanoid.Name = 1
    local l = lp.Character["1"]:Clone()
    l.Parent = lp.Character
    l.Name = "Humanoid"
    wait(0.1)
    lp.Character["1"]:Destroy()
    workspace.CurrentCamera.CameraSubject = lp.Character
    lp.Character.Animate.Disabled = true
    wait(0.1)
    lp.Character.Animate.Disabled = false
    lp.Character.Humanoid.DisplayDistanceType = "None"
end)

ADD_COMMAND('feinvisible','feinvisible',{'feinvis'},
function(ARGS, SPEAKER)
    -- Elite1337#9377 & Timeless#4044
    local Player = gPlayers.LocalPlayer

    local function CheckRig()
        if Player.Character then
            local Humanoid = Player.Character:WaitForChild('Humanoid')
            if Humanoid.RigType == Enum.HumanoidRigType.R15 then
                return 'R15'
            else
                return 'R6'
            end
        end
    end

    local function InitiateInvis()
        local Character = Player.Character
        local StoredCF = Character.PrimaryPart.CFrame

        local Part = Instance.new('Part', workspace)
        Part.Size = Vector3.new(5,0,5)
        Part.Anchored = true
        Part.CFrame = CFrame.new(Vector3.new(9999,9999,9999))
        Character.PrimaryPart.CFrame = Part.CFrame * CFrame.new(0,3,0)

        spawn(function()
            wait(3)
            Part:Destroy()
        end)

        if CheckRig() == 'R6' then
            local Clone = Character.HumanoidRootPart:Clone()
            Character.HumanoidRootPart:Destroy()
            Clone.Parent = Character
        else
            local Clone = Character.LowerTorso.Root:Clone()
            Character.LowerTorso.Root:Destroy()
            Clone.Parent = Character.LowerTorso
        end
    end

    InitiateInvis()
end)

ADD_COMMAND('lplatform','lplatform',{'platform'}, 
function(ARGS, SPEAKER)
    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer

    local p = Instance.new("Part")
    p.Parent = workspace
    p.Locked = true
    p.BrickColor = BrickColor.new("White")
    p.Size = Vector3.new(8, 1.2, 8)
    p.Anchored = true

    local m = Instance.new("CylinderMesh")
    m.Scale = Vector3.new(1, 0.5, 1)
    m.Parent = p

    spawn(function()
        while p and p.Parent and lp and lp.Character do
            local char = lp.Character
            local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
            if root then
                p.CFrame = CFrame.new(root.Position.X, root.Position.Y - 4, root.Position.Z)
            end
            wait()
        end
    end)
end)

--// custom funcs required
ADD_COMMAND('dex','dex',{},
function(ARGS, SPEAKER)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZwDaNk/rocky2u-cmdscript/refs/heads/main/data/dex.lua"))()
end)

ADD_COMMAND('unfiltered','unfiltered',{},
function(ARGS, SPEAKER)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZwDaNk/rocky2u-cmdscript/refs/heads/main/data/unfiltered.lua"))()
end)

ADD_COMMAND('remotespy','remotespy',{},
function(ARGS, SPEAKER)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZwDaNk/rocky2u-cmdscript/refs/heads/main/data/remotespy.lua"))()
	NOTIFY('Check console!', 255, 255, 255)
end)

--// other misc shit

function OPEN_COMMANDS()
	SETH_MAIN.main.holder.Size = UDim2.new(1, 25, 12, 30)
	SETH_MAIN.main.holder.holders.search.Visible = true
end

function CLOSE_COMMANDS()
	SETH_MAIN.main.holder.holders.search.Visible = false
	SETH_MAIN.main.holder.Size = UDim2.new(1, 25, 12, 0)
end

function OPEN_TAB(TAB)
	if not _CORE:FindFirstChild('seth_main') then OPEN_MAIN() end
	for a,b in pairs(_CORE.seth_main.main.holder.holders:GetChildren()) do
		if b.Name ~= TAB then
			b.Visible = false
		else
			b.Visible = true
		end
		if TAB ~= 'cmds' then
			CLOSE_COMMANDS()
		else
			OPEN_COMMANDS()
		end
	end
end

ADD_COMMAND('serverinfo','serverinfo',{'sinfo'},
function(ARGS, SPEAKER)
	OPEN_TAB('server')
end)

ADD_COMMAND('admins','admins',{},
function(ARGS, SPEAKER)
	OPEN_TAB('admins')
end)

ADD_COMMAND('cmds','cmds',{'commands'},
function(ARGS, SPEAKER)
	OPEN_TAB('cmds')
end)

ADD_COMMAND('bans','bans',{},
function(ARGS, SPEAKER)
	OPEN_TAB('bans')
end)

ADD_COMMAND('fun','fun',{},
function(ARGS, SPEAKER)
	OPEN_TAB('fun')
end)

ADD_COMMAND('changelog','changelog',{},
function(ARGS, SPEAKER)
	OPEN_TAB('changelog')
end)

ADD_COMMAND('credits','credits',{},
function(ARGS, SPEAKER)
	OPEN_TAB('credits')
end)

ADD_COMMAND('motd','motd',{},
function(ARGS, SPEAKER)
	NOTIFY(MOTD, 255, 255, 255)
end)

ADD_COMMAND('coinflip','coinflip',{},
function(ARGS, SPEAKER)
	local HEADS = "Heads"
	local TAILS = "Tails"
	local RESULT = math.random(1, 2) == 1 and HEADS or TAILS
	
	NOTIFY(RESULT, 255, 255, 255)
end)

MOUSE.KeyDown:connect(function(key)
	if key:byte() == 29 then
		if not NOCLIP then
			ECOMMAND('noclip')
		elseif NOCLIP then
			ECOMMAND('clip')
		end
	elseif key:byte() == 30 then
		if not JESUSFLY then
			ECOMMAND('jesusfly')
		elseif JESUSFLY then
			ECOMMAND('nojfly')
		end
	end
end)

-- / after loaded

function CHECK_FE()
	if not workspace.FilteringEnabled then
		NOTIFY('Filtering is disabled', 50, 255, 50)
	elseif workspace.FilteringEnabled then
		NOTIFY('Filtering is ENABLED', 255, 50, 50)
	end
end

CMD_BAR_H.bar:TweenPosition(UDim2.new(0, 0, 1, -50), 'InOut', 'Quad', 0.5, true)

local GOING_IN = true
CMD_BAR_H.bar.Changed:connect(function()
	if CMD_BAR_H.bar.Text ~= 'press ; to execute a command' and CMD_BAR_H.bar.Focused and not GOING_IN then
		if CMD_BAR_H.bar.Text ~= '' then
			if not CMD_BAR_H.bar.Text:find(' ') then
				CMD_BAR_H.bar.commands.Visible = true
				CMD_BAR_H.bar.overlay.Visible = true
				CMD_BAR_H.bar.commands:ClearAllChildren()
				CMD_BAR_H.bar.commands.CanvasSize = UDim2.new(0, 0, 0, 0)
				local Y_COMMANDS = 0
				for i,v in pairs(COMMANDS) do
					if v.N:find(CMD_BAR_H.bar.Text) then
						CMD_BAR_H.bar.overlay:TweenSize(UDim2.new(1, 0, 1, -250), 'InOut', 'Quad', 0.2, true)
						CMD_BAR_H.bar.commands:TweenSize(UDim2.new(1, 0, 1, 200), 'InOut', 'Quad', 0.2, true)
						CMD_BAR_H.bar.commands.CanvasSize = CMD_BAR_H.bar.commands.CanvasSize + UDim2.new(0, 0, 0, 20)
						local COMMANDS_C = CMD_BAR_H.bar.commands_ex:Clone()
						COMMANDS_C.Position = UDim2.new(0, 0, 0, Y_COMMANDS)
						COMMANDS_C.Visible = true
						COMMANDS_C.Text = ' ' .. v.D
						COMMANDS_C.Parent = CMD_BAR_H.bar.commands
						Y_COMMANDS = Y_COMMANDS + 20
					end
				end
			end
		else
			CMD_BAR_H.bar.commands:TweenSize(UDim2.new(1, 0, 0, 0), 'InOut', 'Quad', 0.2, true)
			CMD_BAR_H.bar.overlay:TweenSize(UDim2.new(1, 0, 0, 0), 'InOut', 'Quad', 0.2, true)
			CMD_BAR_H.bar.commands:ClearAllChildren()
			CMD_BAR_H.bar.commands.CanvasSize = UDim2.new(0, 0, 0, 0)
		end
	end
end)

CMD_BAR_H.bar.FocusLost:connect(function()
	GOING_IN = true
	if CMD_BAR_H.bar.Text ~= '' then
		spawn(function()
			ECOMMAND(CMD_BAR_H.bar.Text, LP)
		end)
	end
	CMD_BAR_H.bar.commands:ClearAllChildren()
	CMD_BAR_H.bar.commands.CanvasSize = UDim2.new(0, 0, 0, 0)
	CMD_BAR_H.bar.commands:TweenSize(UDim2.new(1, 0, 0, 0), 'InOut', 'Quad', 0.2, true)
	CMD_BAR_H.bar.overlay:TweenSize(UDim2.new(1, 0, 0, 0), 'InOut', 'Quad', 0.2, true)
	CMD_BAR_H.bar:TweenPosition(UDim2.new(0, -225, 1, -50), 'InOut', 'Quad', 0.5, true)
end)

MOUSE.KeyDown:connect(function(K)
	if K:byte() == 59 then
		wait()
		GOING_IN = false
		CMD_BAR_H.bar:TweenPosition(UDim2.new(0, 0, 1, -50), 'InOut', 'Quad', 0.5, true)
		CMD_BAR_H.bar:CaptureFocus()
	end
end)

NOTIFY('Hello, ' .. _PLAYERS.LocalPlayer.Name, 255,255,255)
CHECK_FE()
