local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local AdminCommands = {}

local function isAdmin(player)
    local character = player.Character
    if character and character:FindFirstChild("Admin") then
        return true
    end
    return false
end

local function executeCommand(player, command)
    -- Your command execution code here
end

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.Players.LocalPlayer.PlayerGui

    local scrollableFrame = Instance.new("ScrollingFrame")
    scrollableFrame.Parent = gui
    scrollableFrame.Size = UDim2.new(0, 200, 0, 400)
    scrollableFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollableFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    scrollableFrame.BackgroundTransparency = 0.5

    local commandList = Instance.new("UIListLayout")
    commandList.Parent = scrollableFrame
    commandList.Padding = UDim.new(0, 5)
    commandList.FillDirection = Enum.FillDirection.Vertical

    local commands = {}
    for i, command in pairs({
        "/g [fruit name] - Gives you the fruit you typed",
        "/c [fruit name] - Gives you the physical fruit you typed",
        "/f [fighting style] - Switches to the fighting style you typed",
        "/tp [username] - Teleports you to the player you typed",
        "/br [username] - Brings the player you typed to you",
        "/go [username] - Joins the player you typed",
        "/vip [username] - Joins the player you typed in private servers",
        "/heal - Refills your health and energy",
        "/ban [username] - Bans the player you typed",
        "/kick [username] - Kicks the player you typed",
        "/i [accessory] - Gives you the accessory you typed",
        "/i2 [item name] - Gives you the item you typed",
        "/b [amount] - Sets your bounty to the amount you typed",
        "/r [amount] - Sets your honor to the amount you typed",
        "/s [value] - Sets your stats to the value you typed",
        "/rt1 [gear 1] [gear 2] [awakening duration] - Alters your gears and awakening duration",
        "/rt2 - Awakens your race and fills up the awakening bar",
        "/rt3 - Allows you to access the trials by pulling the level",
        "/rt4 - Teleports you to the Mysterious Force",
        "/spawn [NPC] - Spawns the NPC you typed",
        "/aw [Fruit] - Awakens the fruit you typed",
        "/unaw [Fruit] - Unawakens the fruit you typed",
        "/rage - Fills up your rage meter",
        "/all - Adds a set amount of all game items to your inventory",
        "/kill [username] - Kills the player you typed",
        "/krazy - Allows you to use all fruits, including moves and passives, in your inventory",
    }) do
        local commandButton = Instance.new("TextButton")
        commandButton.Parent = commandList
        commandButton.Size = UDim2.new(0, 200, 0, 20)
        commandButton.Text = command
        commandButton.TextSize = 14
        commandButton.TextColor3 = Color3.new(0, 0, 0)
        commandButton.BackgroundColor3 = Color3.new(1, 1, 1)
        commandButton.BackgroundTransparency = 0.5

        table.insert(commands, commandButton)
    end

    local page = 1
    local pageSize = 6
    local currentPageCommands = {}

    local function updateCommands()
        for i, commandButton in pairs(commands) do
            commandButton:Destroy()
        end

        local start = (page - 1) * pageSize + 1
        local endVal = page * pageSize

        for i = start, endVal do
            if i <= #commands then
                local commandButton = commands[i]
                commandButton.Text = commands[i - 1 + start]
                commandButton.Parent = commandList
            end
        end
    end

    local function changePage(newPage)
        page = newPage
        updateCommands()
    end

    local pageButton = Instance.new("TextButton")
    pageButton.Parent = gui
    pageButton.Size = UDim2.new(0, 100, 0, 20pageButton.Text = "Page " .. page .. " of " .. math.ceil(#commands / pageSize)
pageButton.TextSize = 14
pageButton.TextColor3 = Color3.new(0, 0, 0)
pageButton.BackgroundColor3 = Color3.new(1, 1, 1)
pageButton.BackgroundTransparency = 0.5
pageButton.MouseButton1Click:Connect(function()
    page = page + 1
    if page > math.ceil(#commands / pageSize) then
        page = 1
    end
    updateCommands()
end)

local prevPageButton = Instance.new("TextButton")
prevPageButton.Parent = gui
prevPageButton.Size = UDim2.new(0, 100, 0, 20)
prevPageButton.Text = "Previous"
prevPageButton.TextSize = 14
prevPageButton.TextColor3 = Color3.new(0, 0, 0)
prevPageButton.BackgroundColor3 = Color3.new(1, 1, 1)
prevPageButton.BackgroundTransparency = 0.5
prevPageButton.MouseButton1Click:Connect(function()
    page = page - 1
    if page < 1 then
        page = math.ceil(#commands / pageSize)
    end
    updateCommands()
end)

updateCommands()
end

local function isAdmin(player)
    local character = player.Character
    if character and character:FindFirstChild("Admin") then
        return true
    end
    return false
end

local function executeCommand(player, command)
    -- Your command execution code here
end

local function onMessage(player, message)
    if isAdmin(player) then
        local command = message:match("^(%w+)$")
        if command then
            executeCommand(player, command)
        end
    end
end

RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if isAdmin(player) then
            local message = player.Message
            if message then
                onMessage(player, message)
            end
        end
    end
end)
