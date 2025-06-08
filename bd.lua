-- Memuat script utama
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/DeathBall/refs/heads/main/main.lua"))()

local userInputService = game:GetService("UserInputService")
local attach = true
local mode = 2 -- Default Mode
local RB = Color3.new(1, 0, 0)

-- Fungsi untuk mengaktifkan mode
local function CLC()
    if attach then
        game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
        attach = false
        prev = 0
        rad = 0
    end
end

-- Menangkap input tombol E untuk mengaktifkan mode 2
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
        mode = 2
        print("Mode 2 diaktifkan melalui tombol E!")
    end
end)

-- GUI untuk memilih mode
local Gui = Instance.new("ScreenGui") 
Gui.Parent = game.Players.LocalPlayer.PlayerGui

local Normal = Instance.new("TextButton") 
Normal.Parent = Gui
Normal.Size = UDim2.new(0, 50, 0, 50) 
Normal.Position = UDim2.new(1, -250, 0, 50) 
Normal.Text = "2"

Normal.Activated:Connect(function() 
    Normal.TextColor3 = Color3.new(0, 1, 0) 
    mode = 2
end) 

-- Loop utama untuk eksekusi mode
while true do
    wait(0.05) 
    local ball = game.Workspace:WaitForChild("Part") 

    if ball.Highlight.FillColor == RB then
        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local pos = 0

        -- Menghitung jarak dari bola ke pemain
        for _, axis in ipairs({"X", "Y", "Z"}) do
            local diff = math.abs(ball.CFrame[axis] - playerPos[axis])
            pos = pos + diff
        end

        -- Logika mode
        if mode == 2 and pos < 50 then
            CLC()
        end

        -- Reset jika bola tidak berwarna merah
    elseif not (ball.Highlight.FillColor == RB) then
        attach = true
    end
end

