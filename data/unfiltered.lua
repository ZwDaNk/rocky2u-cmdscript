-- Unfiltered v1.0 by SultanOfSwing --
-- GUI base by louknt --
-- Script generated with Gui2016Lua v1.0.0 by q (@queue on v3rmillion) --

local ScreenGui1 = Instance.new('ScreenGui')
ScreenGui1.Name = "GUI"
ScreenGui1.Parent = game:GetService('CoreGui')

local Frame1 = Instance.new('Frame')
Frame1.Name = "Main"
Frame1.Size = UDim2.new(0, 382, 0, 325)
Frame1.Position = UDim2.new(0.277140707, 0, 0.0885627493, 0)
Frame1.BorderSizePixel = 0
Frame1.BorderColor3 = Color3.new(0, 0, 0)
Frame1.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame1.Parent = ScreenGui1

local Frame2 = Instance.new('Frame')
Frame2.Name = "Material_Top"
Frame2.Size = UDim2.new(1, 0, 0, 15)
Frame2.BorderSizePixel = 0
Frame2.BorderColor3 = Color3.new(0, 0, 0)
Frame2.BackgroundColor3 = Color3.new(0.815686, 0.270588, 0)
Frame2.Parent = Frame1

local TextButton1 = Instance.new('TextButton')
TextButton1.Name = "Material_Close"
TextButton1.Size = UDim2.new(0, 15, 0, 15)
TextButton1.Position = UDim2.new(1, -15, 0, 0)
TextButton1.BorderSizePixel = 0
TextButton1.BorderColor3 = Color3.new(0, 0, 0)
TextButton1.BackgroundTransparency = 1
TextButton1.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton1.TextScaled = true
TextButton1.TextWrapped = true
TextButton1.TextColor3 = Color3.new(1, 1, 1)
TextButton1.Text = "X"
TextButton1.FontSize = Enum.FontSize.Size14
TextButton1.Font = Enum.Font.SourceSans
TextButton1.Parent = Frame2

local Frame3 = Instance.new('Frame')
Frame3.Name = "Material_Middle"
Frame3.Size = UDim2.new(1, 0, 0, 40)
Frame3.Position = UDim2.new(0, 0, 0, 15)
Frame3.BorderSizePixel = 0
Frame3.BorderColor3 = Color3.new(0, 0, 0)
Frame3.BackgroundColor3 = Color3.new(1, 0.333333, 0)
Frame3.Parent = Frame1

local TextLabel1 = Instance.new('TextLabel')
TextLabel1.Name = "Title"
TextLabel1.Size = UDim2.new(0, 200, 0, 30)
TextLabel1.Position = UDim2.new(0, 6, 0, 7)
TextLabel1.BorderSizePixel = 0
TextLabel1.BorderColor3 = Color3.new(0, 0, 0)
TextLabel1.BackgroundTransparency = 1
TextLabel1.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel1.TextScaled = true
TextLabel1.TextXAlignment = Enum.TextXAlignment.Left
TextLabel1.TextWrapped = true
TextLabel1.TextColor3 = Color3.new(1, 1, 1)
TextLabel1.Text = "Unfiltered v1.0"
TextLabel1.FontSize = Enum.FontSize.Size14
TextLabel1.Font = Enum.Font.SourceSans
TextLabel1.Parent = Frame3

local Frame4 = Instance.new('Frame')
Frame4.Name = "Material_Tabs"
Frame4.Size = UDim2.new(1, 0, 0, 20)
Frame4.Position = UDim2.new(0, 0, 0, 55)
Frame4.BorderSizePixel = 0
Frame4.BorderColor3 = Color3.new(0, 0, 0)
Frame4.BackgroundColor3 = Color3.new(1, 0.333333, 0)
Frame4.Parent = Frame1

local TextButton2 = Instance.new('TextButton')
TextButton2.Name = "TabOne"
TextButton2.Size = UDim2.new(0, 70, 1, 0)
TextButton2.Position = UDim2.new(0, 5, 0, 0)
TextButton2.BorderSizePixel = 0
TextButton2.BorderColor3 = Color3.new(0, 0, 0)
TextButton2.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton2.TextWrapped = true
TextButton2.TextColor3 = Color3.new(1, 1, 1)
TextButton2.Text = "SERVER"
TextButton2.FontSize = Enum.FontSize.Size18
TextButton2.Font = Enum.Font.SourceSans
TextButton2.Parent = Frame4

local Frame5 = Instance.new('Frame')
Frame5.Name = "ActiveFrame"
Frame5.Size = UDim2.new(1, -6, 0, 1)
Frame5.Position = UDim2.new(0, 3, 1, -1)
Frame5.BorderSizePixel = 0
Frame5.BorderColor3 = Color3.new(0, 0, 0)
Frame5.BackgroundColor3 = Color3.new(1, 1, 1)
Frame5.Parent = TextButton2

local TextButton3 = Instance.new('TextButton')
TextButton3.Name = "TabTwo"
TextButton3.Size = UDim2.new(0, 80, 1, 0)
TextButton3.Position = UDim2.new(0, 75, 0, 0)
TextButton3.BorderSizePixel = 0
TextButton3.BorderColor3 = Color3.new(0, 0, 0)
TextButton3.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton3.TextWrapped = true
TextButton3.TextTransparency = 0.25
TextButton3.TextColor3 = Color3.new(1, 1, 1)
TextButton3.Text = "CHARACTER"
TextButton3.FontSize = Enum.FontSize.Size18
TextButton3.Font = Enum.Font.SourceSans
TextButton3.Parent = Frame4

local TextButton4 = Instance.new('TextButton')
TextButton4.Name = "TabThree"
TextButton4.Size = UDim2.new(0, 65, 1, 0)
TextButton4.Position = UDim2.new(0, 160, 0, 0)
TextButton4.BorderSizePixel = 0
TextButton4.BorderColor3 = Color3.new(0, 0, 0)
TextButton4.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton4.TextWrapped = true
TextButton4.TextTransparency = 0.25
TextButton4.TextColor3 = Color3.new(1, 1, 1)
TextButton4.Text = "CREDITS"
TextButton4.FontSize = Enum.FontSize.Size18
TextButton4.Font = Enum.Font.SourceSans
TextButton4.Parent = Frame4

local Frame6 = Instance.new('Frame')
Frame6.Name = "Material_Base"
Frame6.Size = UDim2.new(1, 0, 1, -70)
Frame6.Position = UDim2.new(0, 0, 0, 75)
Frame6.BorderSizePixel = 0
Frame6.BorderColor3 = Color3.new(0, 0, 0)
Frame6.BackgroundTransparency = 1
Frame6.BackgroundColor3 = Color3.new(1, 1, 1)
Frame6.Parent = Frame1

local Frame7 = Instance.new('Frame')
Frame7.Name = "TabOne"
Frame7.Size = UDim2.new(1, 0, 1, 0)
Frame7.BorderSizePixel = 0
Frame7.BorderColor3 = Color3.new(0, 0, 0)
Frame7.BackgroundTransparency = 1
Frame7.BackgroundColor3 = Color3.new(1, 1, 1)
Frame7.Parent = Frame6

local TextButton5 = Instance.new('TextButton')
TextButton5.Name = "JumpAll"
TextButton5.Size = UDim2.new(0, 80, 0, 30)
TextButton5.Position = UDim2.new(0.0415287502, 180, 0.0629215613, 0)
TextButton5.BorderSizePixel = 0
TextButton5.BorderColor3 = Color3.new(0, 0, 0)
TextButton5.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton5.TextColor3 = Color3.new(1, 1, 1)
TextButton5.Text = "Jump All"
TextButton5.FontSize = Enum.FontSize.Size18
TextButton5.Font = Enum.Font.SourceSans
TextButton5.Parent = Frame7

local TextButton6 = Instance.new('TextButton')
TextButton6.Name = "PlaySounds"
TextButton6.Size = UDim2.new(0, 80, 0, 30)
TextButton6.Position = UDim2.new(0.0418848172, 0, 0.0627451017, 0)
TextButton6.BorderSizePixel = 0
TextButton6.BorderColor3 = Color3.new(0, 0, 0)
TextButton6.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton6.TextColor3 = Color3.new(1, 1, 1)
TextButton6.Text = "Play Sounds"
TextButton6.FontSize = Enum.FontSize.Size18
TextButton6.Font = Enum.Font.SourceSans
TextButton6.Parent = Frame7

local TextButton7 = Instance.new('TextButton')
TextButton7.Name = "SitAll"
TextButton7.Size = UDim2.new(0, 80, 0, 30)
TextButton7.Position = UDim2.new(0.0415287502, 90, 0.0629215613, 0)
TextButton7.BorderSizePixel = 0
TextButton7.BorderColor3 = Color3.new(0, 0, 0)
TextButton7.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton7.TextColor3 = Color3.new(1, 1, 1)
TextButton7.Text = "Sit All"
TextButton7.FontSize = Enum.FontSize.Size18
TextButton7.Font = Enum.Font.SourceSans
TextButton7.Parent = Frame7

local TextButton8 = Instance.new('TextButton')
TextButton8.Name = "KillAll"
TextButton8.Size = UDim2.new(0, 80, 0, 30)
TextButton8.Position = UDim2.new(0.0415289104, 270, 0.0629215613, 0)
TextButton8.BorderSizePixel = 0
TextButton8.BorderColor3 = Color3.new(0, 0, 0)
TextButton8.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton8.TextColor3 = Color3.new(1, 1, 1)
TextButton8.Text = "Kill All"
TextButton8.FontSize = Enum.FontSize.Size18
TextButton8.Font = Enum.Font.SourceSans
TextButton8.Parent = Frame7

local TextButton9 = Instance.new('TextButton')
TextButton9.Name = "BringAll"
TextButton9.Size = UDim2.new(0, 80, 0, 30)
TextButton9.Position = UDim2.new(0.0419999994, 0, 0.063000001, 40)
TextButton9.BorderSizePixel = 0
TextButton9.BorderColor3 = Color3.new(0, 0, 0)
TextButton9.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton9.TextColor3 = Color3.new(1, 1, 1)
TextButton9.Text = "Bring All"
TextButton9.FontSize = Enum.FontSize.Size18
TextButton9.Font = Enum.Font.SourceSans
TextButton9.Parent = Frame7

local TextButton10 = Instance.new('TextButton')
TextButton10.Name = "CrashServer"
TextButton10.Size = UDim2.new(0, 80, 0, 30)
TextButton10.Position = UDim2.new(0.2749843, 0, 0.0630000085, 40)
TextButton10.BorderSizePixel = 0
TextButton10.BorderColor3 = Color3.new(0, 0, 0)
TextButton10.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton10.TextColor3 = Color3.new(1, 1, 1)
TextButton10.Text = "Crash Server"
TextButton10.FontSize = Enum.FontSize.Size18
TextButton10.Font = Enum.Font.SourceSans
TextButton10.Parent = Frame7

local TextButton11 = Instance.new('TextButton')
TextButton11.Name = "LagRCC"
TextButton11.Size = UDim2.new(0, 80, 0, 30)
TextButton11.Position = UDim2.new(0.510586321, 0, 0.0630000085, 40)
TextButton11.BorderSizePixel = 0
TextButton11.BorderColor3 = Color3.new(0, 0, 0)
TextButton11.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton11.TextColor3 = Color3.new(1, 1, 1)
TextButton11.Text = "Lag RCC"
TextButton11.FontSize = Enum.FontSize.Size18
TextButton11.Font = Enum.Font.SourceSans
TextButton11.Parent = Frame7

local TextButton12 = Instance.new('TextButton')
TextButton12.Name = "AnimAll"
TextButton12.Size = UDim2.new(0, 80, 0, 30)
TextButton12.Position = UDim2.new(0.748806238, 0, 0.0630000085, 40)
TextButton12.BorderSizePixel = 0
TextButton12.BorderColor3 = Color3.new(0, 0, 0)
TextButton12.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton12.TextColor3 = Color3.new(1, 1, 1)
TextButton12.Text = "Anim All"
TextButton12.FontSize = Enum.FontSize.Size18
TextButton12.Font = Enum.Font.SourceSans
TextButton12.Parent = Frame7

local TextBox1 = Instance.new('TextBox')
TextBox1.Name = "AnimId"
TextBox1.Size = UDim2.new(0, 100, 0, 25)
TextBox1.Position = UDim2.new(0.698952973, 0, 0.831372559, 0)
TextBox1.BorderSizePixel = 0
TextBox1.BorderColor3 = Color3.new(0, 0, 0)
TextBox1.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox1.TextColor3 = Color3.new(0, 0, 0)
TextBox1.Text = ""
TextBox1.FontSize = Enum.FontSize.Size14
TextBox1.Font = Enum.Font.SourceSans
TextBox1.Parent = Frame7

local TextLabel2 = Instance.new('TextLabel')
TextLabel2.Name = "Placeholder"
TextLabel2.Size = UDim2.new(1, 0, 1, 0)
TextLabel2.BorderSizePixel = 0
TextLabel2.BorderColor3 = Color3.new(0, 0, 0)
TextLabel2.BackgroundTransparency = 1
TextLabel2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel2.TextColor3 = Color3.new(0.65, 0.65, 0.65)
TextLabel2.Text = "Animation ID"
TextLabel2.FontSize = Enum.FontSize.Size14
TextLabel2.Font = Enum.Font.SourceSans
TextLabel2.Parent = TextBox1

local TextBox2 = Instance.new('TextBox')
TextBox2.Name = "AnimSpeed"
TextBox2.Size = UDim2.new(0, 100, 0, 25)
TextBox2.Position = UDim2.new(0.403141439, 0, 0.831372559, 0)
TextBox2.BorderSizePixel = 0
TextBox2.BorderColor3 = Color3.new(0, 0, 0)
TextBox2.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox2.TextColor3 = Color3.new(0, 0, 0)
TextBox2.Text = ""
TextBox2.FontSize = Enum.FontSize.Size14
TextBox2.Font = Enum.Font.SourceSans
TextBox2.Parent = Frame7

local TextLabel3 = Instance.new('TextLabel')
TextLabel3.Name = "Placeholder"
TextLabel3.Size = UDim2.new(1, 0, 1, 0)
TextLabel3.BorderSizePixel = 0
TextLabel3.BorderColor3 = Color3.new(0, 0, 0)
TextLabel3.BackgroundTransparency = 1
TextLabel3.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel3.TextColor3 = Color3.new(0.65, 0.65, 0.65)
TextLabel3.Text = "Animation Speed"
TextLabel3.FontSize = Enum.FontSize.Size14
TextLabel3.Font = Enum.Font.SourceSans
TextLabel3.Parent = TextBox2

local Frame8 = Instance.new('Frame')
Frame8.Name = "TabTwo"
Frame8.Visible = false
Frame8.Size = UDim2.new(1, 0, 1, 0)
Frame8.BorderSizePixel = 0
Frame8.BorderColor3 = Color3.new(0, 0, 0)
Frame8.BackgroundTransparency = 1
Frame8.BackgroundColor3 = Color3.new(1, 1, 1)
Frame8.Parent = Frame6

local TextBox3 = Instance.new('TextBox')
TextBox3.Name = "Value"
TextBox3.Size = UDim2.new(0, 100, 0, 25)
TextBox3.Position = UDim2.new(0.698952973, 0, 0.831372559, 0)
TextBox3.BorderSizePixel = 0
TextBox3.BorderColor3 = Color3.new(0, 0, 0)
TextBox3.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox3.TextColor3 = Color3.new(0, 0, 0)
TextBox3.Text = ""
TextBox3.FontSize = Enum.FontSize.Size14
TextBox3.Font = Enum.Font.SourceSans
TextBox3.Parent = Frame8

local TextLabel4 = Instance.new('TextLabel')
TextLabel4.Name = "Placeholder"
TextLabel4.Size = UDim2.new(1, 0, 1, 0)
TextLabel4.BorderSizePixel = 0
TextLabel4.BorderColor3 = Color3.new(0, 0, 0)
TextLabel4.BackgroundTransparency = 1
TextLabel4.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel4.TextColor3 = Color3.new(0.65, 0.65, 0.65)
TextLabel4.Text = "Value"
TextLabel4.FontSize = Enum.FontSize.Size14
TextLabel4.Font = Enum.Font.SourceSans
TextLabel4.Parent = TextBox3

local TextButton13 = Instance.new('TextButton')
TextButton13.Name = "WalkSpeed"
TextButton13.Size = UDim2.new(0, 80, 0, 30)
TextButton13.Position = UDim2.new(0.0418848172, 0, 0.0627451017, 0)
TextButton13.BorderSizePixel = 0
TextButton13.BorderColor3 = Color3.new(0, 0, 0)
TextButton13.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton13.TextColor3 = Color3.new(1, 1, 1)
TextButton13.Text = "WalkSpeed"
TextButton13.FontSize = Enum.FontSize.Size18
TextButton13.Font = Enum.Font.SourceSans
TextButton13.Parent = Frame8

local TextButton14 = Instance.new('TextButton')
TextButton14.Name = "JumpPower"
TextButton14.Size = UDim2.new(0, 80, 0, 30)
TextButton14.Position = UDim2.new(0.0415287502, 90, 0.0629215613, 0)
TextButton14.BorderSizePixel = 0
TextButton14.BorderColor3 = Color3.new(0, 0, 0)
TextButton14.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton14.TextColor3 = Color3.new(1, 1, 1)
TextButton14.Text = "JumpPower"
TextButton14.FontSize = Enum.FontSize.Size18
TextButton14.Font = Enum.Font.SourceSans
TextButton14.Parent = Frame8

local TextButton15 = Instance.new('TextButton')
TextButton15.Name = "HipHeight"
TextButton15.Size = UDim2.new(0, 80, 0, 30)
TextButton15.Position = UDim2.new(0.0415287502, 180, 0.0629215613, 0)
TextButton15.BorderSizePixel = 0
TextButton15.BorderColor3 = Color3.new(0, 0, 0)
TextButton15.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton15.TextColor3 = Color3.new(1, 1, 1)
TextButton15.Text = "HipHeight"
TextButton15.FontSize = Enum.FontSize.Size18
TextButton15.Font = Enum.Font.SourceSans
TextButton15.Parent = Frame8

local TextButton16 = Instance.new('TextButton')
TextButton16.Name = "JFly"
TextButton16.Size = UDim2.new(0, 80, 0, 30)
TextButton16.Position = UDim2.new(0.277130842, 180, 0.0629215613, 0)
TextButton16.BorderSizePixel = 0
TextButton16.BorderColor3 = Color3.new(0, 0, 0)
TextButton16.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton16.TextColor3 = Color3.new(1, 1, 1)
TextButton16.Text = "JFly"
TextButton16.FontSize = Enum.FontSize.Size18
TextButton16.Font = Enum.Font.SourceSans
TextButton16.Parent = Frame8

local TextButton17 = Instance.new('TextButton')
TextButton17.Name = "AirSwim"
TextButton17.Size = UDim2.new(0, 80, 0, 30)
TextButton17.Position = UDim2.new(0.0419999994, 0, 0.063000001, 40)
TextButton17.BorderSizePixel = 0
TextButton17.BorderColor3 = Color3.new(0, 0, 0)
TextButton17.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton17.TextColor3 = Color3.new(1, 1, 1)
TextButton17.Text = "AirSwim"
TextButton17.FontSize = Enum.FontSize.Size18
TextButton17.Font = Enum.Font.SourceSans
TextButton17.Parent = Frame8

local TextButton18 = Instance.new('TextButton')
TextButton18.Name = "SuperJump"
TextButton18.Size = UDim2.new(0, 80, 0, 30)
TextButton18.Position = UDim2.new(0.2749843, 0, 0.0630000085, 40)
TextButton18.BorderSizePixel = 0
TextButton18.BorderColor3 = Color3.new(0, 0, 0)
TextButton18.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton18.TextColor3 = Color3.new(1, 1, 1)
TextButton18.Text = "SuperJump"
TextButton18.FontSize = Enum.FontSize.Size18
TextButton18.Font = Enum.Font.SourceSans
TextButton18.Parent = Frame8

local TextButton19 = Instance.new('TextButton')
TextButton19.Name = "Noclip"
TextButton19.Size = UDim2.new(0, 80, 0, 30)
TextButton19.Position = UDim2.new(0.5105865, 0, 0.0630000085, 40)
TextButton19.BorderSizePixel = 0
TextButton19.BorderColor3 = Color3.new(0, 0, 0)
TextButton19.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton19.TextColor3 = Color3.new(1, 1, 1)
TextButton19.Text = "Noclip"
TextButton19.FontSize = Enum.FontSize.Size18
TextButton19.Font = Enum.Font.SourceSans
TextButton19.Parent = Frame8

local TextButton20 = Instance.new('TextButton')
TextButton20.Name = "AirWalk"
TextButton20.Size = UDim2.new(0, 80, 0, 30)
TextButton20.Position = UDim2.new(0.748806357, 0, 0.0630000085, 40)
TextButton20.BorderSizePixel = 0
TextButton20.BorderColor3 = Color3.new(0, 0, 0)
TextButton20.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton20.TextColor3 = Color3.new(1, 1, 1)
TextButton20.Text = "AirWalk"
TextButton20.FontSize = Enum.FontSize.Size18
TextButton20.Font = Enum.Font.SourceSans
TextButton20.Parent = Frame8

local TextButton21 = Instance.new('TextButton')
TextButton21.Name = "Ragdoll"
TextButton21.Size = UDim2.new(0, 80, 0, 30)
TextButton21.Position = UDim2.new(0.0419999994, 0, 0.063000001, 80)
TextButton21.BorderSizePixel = 0
TextButton21.BorderColor3 = Color3.new(0, 0, 0)
TextButton21.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton21.TextColor3 = Color3.new(1, 1, 1)
TextButton21.Text = "Ragdoll"
TextButton21.FontSize = Enum.FontSize.Size18
TextButton21.Font = Enum.Font.SourceSans
TextButton21.Parent = Frame8

local TextButton22 = Instance.new('TextButton')
TextButton22.Name = "DisableHumStateShit"
TextButton22.Size = UDim2.new(0, 80, 0, 30)
TextButton22.Position = UDim2.new(0.2749843, 0, 0.0630000085, 80)
TextButton22.BorderSizePixel = 0
TextButton22.BorderColor3 = Color3.new(0, 0, 0)
TextButton22.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton22.TextColor3 = Color3.new(1, 1, 1)
TextButton22.Text = "Reset State"
TextButton22.FontSize = Enum.FontSize.Size18
TextButton22.Font = Enum.Font.SourceSans
TextButton22.Parent = Frame8

local TextButton23 = Instance.new('TextButton')
TextButton23.Name = "NoHatMesh"
TextButton23.Size = UDim2.new(0, 80, 0, 30)
TextButton23.Position = UDim2.new(0.5105865, 0, 0.0630000085, 80)
TextButton23.BorderSizePixel = 0
TextButton23.BorderColor3 = Color3.new(0, 0, 0)
TextButton23.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton23.TextColor3 = Color3.new(1, 1, 1)
TextButton23.Text = "NoHatMesh"
TextButton23.FontSize = Enum.FontSize.Size18
TextButton23.Font = Enum.Font.SourceSans
TextButton23.Parent = Frame8

local TextButton24 = Instance.new('TextButton')
TextButton24.Name = "DropHats"
TextButton24.Size = UDim2.new(0, 80, 0, 30)
TextButton24.Position = UDim2.new(0.746188581, 0, 0.0630000085, 80)
TextButton24.BorderSizePixel = 0
TextButton24.BorderColor3 = Color3.new(0, 0, 0)
TextButton24.BackgroundColor3 = Color3.new(1, 0.333333, 0)
TextButton24.TextColor3 = Color3.new(1, 1, 1)
TextButton24.Text = "Drop Hats"
TextButton24.FontSize = Enum.FontSize.Size18
TextButton24.Font = Enum.Font.SourceSans
TextButton24.Parent = Frame8

local Frame9 = Instance.new('Frame')
Frame9.Name = "TabThree"
Frame9.Visible = false
Frame9.Size = UDim2.new(1, 0, 1, 0)
Frame9.BorderSizePixel = 0
Frame9.BorderColor3 = Color3.new(0, 0, 0)
Frame9.BackgroundTransparency = 1
Frame9.BackgroundColor3 = Color3.new(1, 1, 1)
Frame9.Parent = Frame6

local TextLabel5 = Instance.new('TextLabel')
TextLabel5.Name = "UnfilteredCredits"
TextLabel5.Size = UDim2.new(0, 200, 0, 25)
TextLabel5.Position = UDim2.new(0, 91, 0, 25)
TextLabel5.BorderSizePixel = 0
TextLabel5.BorderColor3 = Color3.new(0, 0, 0)
TextLabel5.BackgroundTransparency = 1
TextLabel5.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel5.TextColor3 = Color3.new(1, 1, 1)
TextLabel5.Text = "Unfiltered by SultanOfSwing"
TextLabel5.FontSize = Enum.FontSize.Size24
TextLabel5.Font = Enum.Font.SourceSans
TextLabel5.Parent = Frame9

local TextLabel6 = Instance.new('TextLabel')
TextLabel6.Name = "MaterialSkinBaseCredits"
TextLabel6.Size = UDim2.new(0, 200, 0, 25)
TextLabel6.Position = UDim2.new(0, 91, 0, 50)
TextLabel6.BorderSizePixel = 0
TextLabel6.BorderColor3 = Color3.new(0, 0, 0)
TextLabel6.BackgroundTransparency = 1
TextLabel6.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel6.TextColor3 = Color3.new(1, 1, 1)
TextLabel6.Text = "GUI Base (MaterialSkinBase) by louknt"
TextLabel6.FontSize = Enum.FontSize.Size24
TextLabel6.Font = Enum.Font.SourceSans
TextLabel6.Parent = Frame9

local TextLabel7 = Instance.new('TextLabel')
TextLabel7.Name = "LSFScriptCredits"
TextLabel7.Size = UDim2.new(0, 200, 0, 25)
TextLabel7.Position = UDim2.new(0, 91, 0, 75)
TextLabel7.BorderSizePixel = 0
TextLabel7.BorderColor3 = Color3.new(0, 0, 0)
TextLabel7.BackgroundTransparency = 1
TextLabel7.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel7.TextColor3 = Color3.new(1, 1, 1)
TextLabel7.Text = "Some buttons use scripts from LSF by LSFrox"
TextLabel7.FontSize = Enum.FontSize.Size24
TextLabel7.Font = Enum.Font.SourceSans
TextLabel7.Parent = Frame9

local TextLabel8 = Instance.new('TextLabel')
TextLabel8.Name = "RCCLaggerCredits"
TextLabel8.Size = UDim2.new(0, 200, 0, 25)
TextLabel8.Position = UDim2.new(0, 91, 0, 100)
TextLabel8.BorderSizePixel = 0
TextLabel8.BorderColor3 = Color3.new(0, 0, 0)
TextLabel8.BackgroundTransparency = 1
TextLabel8.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel8.TextColor3 = Color3.new(1, 1, 1)
TextLabel8.Text = "RCC Lagger by louknt"
TextLabel8.FontSize = Enum.FontSize.Size24
TextLabel8.Font = Enum.Font.SourceSans
TextLabel8.Parent = Frame9

local TextLabel9 = Instance.new('TextLabel')
TextLabel9.Name = "Title"
TextLabel9.Size = UDim2.new(0, 200, 0, 25)
TextLabel9.Position = UDim2.new(0, 91, 0, 0)
TextLabel9.BorderSizePixel = 0
TextLabel9.BorderColor3 = Color3.new(0, 0, 0)
TextLabel9.BackgroundTransparency = 1
TextLabel9.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel9.TextColor3 = Color3.new(1, 1, 1)
TextLabel9.Text = "Unfiltered (FE GUI) - Credits:"
TextLabel9.FontSize = Enum.FontSize.Size24
TextLabel9.Font = Enum.Font.SourceSans
TextLabel9.Parent = Frame9

local Frame10 = Instance.new('Frame')
Frame10.Name = "Material_Div"
Frame10.Size = UDim2.new(1, 0, 0, 1)
Frame10.Position = UDim2.new(0, 0, 0.0941176489, 0)
Frame10.BorderSizePixel = 0
Frame10.BorderColor3 = Color3.new(0, 0, 0)
Frame10.BackgroundColor3 = Color3.new(1, 1, 1)
Frame10.Parent = Frame9

local LocalScript1 = Instance.new('LocalScript')
LocalScript1.Name = "Material_Main"
LocalScript1.Parent = Frame1

-- Script @ StarterGui.GUI.Main.Material_Main
coroutine.wrap(function()
local script = LocalScript1
-- MaterialSkinBase by louknt
-- Definitely not my best work, but it works I guess?

local main = script.Parent
local top = main.Material_Top
local base = main.Material_Base
local tabs = main.Material_Tabs

local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")

-- Roblox's builtin assert isn't properly optimized for string concatinations. This is a compromise.
local function assert(x, f, ...)
	if not x then error(f:format(...), 0) end
end

-- Close Button
top.Material_Close.MouseButton1Click:connect(function()
	main.Visible = not main.Visible
end)

-- Tabs
local currentTab = script.Parent.Material_Base.TabOne
for _, tab in ipairs(tabs:GetChildren()) do
	if tab:IsA("TextButton") then
		tab.MouseButton1Click:connect(function()
			local tabPage = base:FindFirstChild(tab.Name)
			assert(tabPage, "Unable to find tab '%s'!", tab.Name)
			
			local oldTabBtn = tabs:FindFirstChild(currentTab.Name)
			assert(tabPage, "Unable to find button for tab '%s'!", currentTab.Name)
			oldTabBtn.TextTransparency = .25
			oldTabBtn.ActiveFrame.Parent = tab
			
			if currentTab then currentTab.Visible = false end
			tabPage.Visible = true
			tab.TextTransparency = 0
			
			currentTab = tabPage
		end)
	end
end

-- Textbox placeholders
for _, tab in ipairs(base:GetChildren()) do
	for _, tb in ipairs(tab:GetChildren()) do
		if tb:IsA("TextBox") then
			local placeholder = tb:FindFirstChild("Placeholder")
			if placeholder then
				tb.Focused:connect(function() placeholder.Visible = false end)
				tb.FocusLost:connect(function() if tb.Text == "" then placeholder.Visible = true end end)
			end
		end
	end
end

-- Unfiltered edit: util funcs
local function getHum(plr)
	local char = plr.Character
	if not char then return end
	return char:FindFirstChild("Humanoid")
end

local state;
-- End of edit

-- Button callbacks
local callbacks = {
	-- tab 1
	PlaySounds = function() local function audiohax(abc) for e,r in pairs(abc:GetChildren()) do if r:IsA("Sound") then r:Play() end audiohax(r) end end audiohax(workspace) end,
	JumpAll = function() for i,v in pairs(plrs:GetPlayers()) do if getHum(v) then getHum(v).Jump = true end end end,
	SitAll = function() for i,v in pairs(plrs:GetPlayers()) do if getHum(v) then getHum(v).Sit = true end end end,
	KillAll = function() for _,v in pairs(plrs:GetPlayers()) do if v ~= plrs.LocalPlayer then local c = plrs.LocalPlayer.Character if not c then warn("No character") end local t = c:FindFirstChild("Torso") or c:FindFirstChild("HumanoidRootPart") if not t then warn("No torso!") end local w = Instance.new("Weld", t) w.Part0 = t w.Part1 = v.Character.Torso w.C0 = t.CFrame w.C1 = t.CFrame + Vector3.new(0, -10000, 0) coroutine.wrap(function() wait(.25) w:Destroy() end)() end end end, -- skidded from LSF lol
	BringAll = function() for _,v in pairs(plrs:GetPlayers()) do if v ~= plrs.LocalPlayer then local c = plrs.LocalPlayer.Character if not c then warn("No character") end local t = c:FindFirstChild("Torso") or c:FindFirstChild("HumanoidRootPart") if not t then warn("No torso!") end local w = Instance.new("Weld", t) w.Part0 = t w.Part1 = v.Character.Torso w.C0 = t.CFrame w.C1 = t.CFrame coroutine.wrap(function() wait(.25) w:Destroy() end)() end end end, -- also skidded from LSF, shoutout LSFrox
	CrashServer = function() for _,v in pairs(plrs.LocalPlayer.Character:GetChildren()) do if v:IsA("Accoutrement") then sethiddenproperty(v, "BackendAccoutrementState", 0/0) wait(.15) v.Parent = workspace end end end, -- you guessed it.. also skidded from LSF!
	LagRCC = function() for i = 1, 1000000 do game.NetworkClient.ClientReplicator:RequestServerStats(true) end end, -- created by louknt
	AnimAll = function() for i,v in pairs(plrs:GetPlayers()) do local c = v.Character if c and c:FindFirstChild("Humanoid") then local h = c.Humanoid local anim = Instance.new("Animation") anim.AnimationId = "rbxassetid://"..currentTab.AnimId.Text local track = h:LoadAnimation(anim) if tonumber(currentTab.AnimSpeed.Text) then track:AdjustSpeed(tonumber(currentTab.AnimSpeed.Text)) end track:Play() end end end,
	
	-- tab 2
	WalkSpeed = function() if getHum(plrs.LocalPlayer) then getHum(plrs.LocalPlayer).WalkSpeed=tonumber(currentTab.Value.Text) end end,
	JumpPower = function() if getHum(plrs.LocalPlayer) then getHum(plrs.LocalPlayer).JumpPower=tonumber(currentTab.Value.Text) end end,
	HipHeight = function() if getHum(plrs.LocalPlayer) then getHum(plrs.LocalPlayer).HipHeight=tonumber(currentTab.Value.Text) end end,
	JFly = function() state = Enum.HumanoidStateType.Climbing end, -- thanks to louknt for these humanoid state tricks
	AirSwim = function() state = Enum.HumanoidStateType.Swimming end,
	SuperJump = function() state = Enum.HumanoidStateType.Seated end,
	Noclip = function() state = Enum.HumanoidStateType.StrafingNoPhysics end,
	AirWalk = function() state = Enum.HumanoidStateType.RunningNoPhysics end,
	Ragdoll = function() state = Enum.HumanoidStateType.Ragdoll end,
	DisableHumStateShit = function() state = nil end,
	NoHatMesh = function() if not plrs.LocalPlayer.Character then return end for _,v in ipairs(plrs.LocalPlayer.Character:GetChildren()) do if v:IsA("Accoutrement") then local h = v:FindFirstChild("Handle") if h then for _,v in ipairs(h:GetChildren()) do if v:IsA("SpecialMesh") then v:Destroy() end end end end end end,
	DropHats = function() if not plrs.LocalPlayer.Character then return end for _,v in ipairs(plrs.LocalPlayer.Character:GetChildren()) do if v:IsA("Accoutrement") then v.Parent = workspace wait() end end end,
}

for _, tab in ipairs(base:GetChildren()) do
	for _, btn in ipairs(tab:GetChildren()) do
		if btn:IsA("TextButton") then
			local cb = callbacks[btn.Name]
			assert(cb, "Unable to find callback for button '%s'", btn.Name)
			btn.MouseButton1Click:connect(cb)
		end
	end
end

-- Draggable
main.Active = true
main.Draggable = true

-- Keybinds
uis.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.LeftAlt then
		main.Visible = not main.Visible
	end
end)

-- Unfiltered stuff again
print("Unfiltered v1.0 by SultanOfSwing - MaterialSkin UI base by louknt. Special thanks to LSFrox.")
print("Press LeftAlt to toggle the UI")

local rs = game:GetService("RunService")
rs.RenderStepped:connect(function()
	if state then
		local h = getHum(plrs.LocalPlayer)
		if h then
			h:ChangeState(state)
		end
	end
end)

if not sethiddenproperty then
	if setscriptable then
	function sethiddenproperty(obj, prop, value)
		setscriptable(obj, prop, true)
		obj[prop] = value
		setscriptable(obj, prop, false)
		end
	else
		warn("Your exploit is missing 'sethiddenproperty' or 'setscriptable', not all buttons will work.")
	end
end
-- end
end)()

