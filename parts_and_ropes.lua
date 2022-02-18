-- Services
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")

-- Variables
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()


-- Create Menu
local screenGui = Instance.new("ScreenGui", playerGui)

-- Array of text labels/fonts/sizes to output
local labelArray = {
	{text = "BasicResearch", font = Enum.Font.FredokaOne, size = 25},
	{text = "PointsNeeded: 100", font = Enum.Font.FredokaOne, size = 25},
	{text = "Points: 20", font = Enum.Font.FredokaOne, size = 25}
}

-- Create an automatically-sized parent frame
local parentFrame = Instance.new("Frame", screenGui)
parentFrame.AutomaticSize = Enum.AutomaticSize.XY
parentFrame.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
parentFrame.Size = UDim2.fromOffset(25, 100)
parentFrame.Position = UDim2.new(0, mouse.X + 5, 0, mouse.Y + 5) -- UDim2.fromScale(0.1, 0.1)

-- Add a list layout
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = parentFrame

-- Set rounded corners and padding for visual aesthetics
local roundedCorner = Instance.new("UICorner")
roundedCorner.Parent = parentFrame
local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, 5)
uiPadding.PaddingLeft = UDim.new(0, 5)
uiPadding.PaddingRight = UDim.new(0, 5)
uiPadding.PaddingBottom = UDim.new(0, 5)
uiPadding.Parent = parentFrame

for i = 1, #labelArray do
	-- Create an automatically-sized text label from array
	local childLabel = Instance.new("TextLabel")
	childLabel.AutomaticSize = Enum.AutomaticSize.XY
	childLabel.Size = UDim2.fromOffset(75, 15)
	childLabel.Text = labelArray[i]["text"]
	childLabel.Font = labelArray[i]["font"]
	childLabel.TextSize = labelArray[i]["size"]
	childLabel.TextColor3 = Color3.new(1, 1, 1)
	childLabel.Parent = parentFrame

	-- Visual aesthetics
	local roundedCorner = Instance.new("UICorner")
	roundedCorner.Parent = childLabel
	local uiPadding = Instance.new("UIPadding")
	uiPadding.PaddingTop = UDim.new(0, 5)
	uiPadding.PaddingLeft = UDim.new(0, 5)
	uiPadding.PaddingRight = UDim.new(0, 5)
	uiPadding.PaddingBottom = UDim.new(0, 5)
	uiPadding.Parent = childLabel

end


-- create parts
local PART_HEIGHT = 10
local PARTS_DISTANCE = 10
local BASE_POSITION = Vector3.new(0, PART_HEIGHT, 0)

local function createPart(parentID, name) 
	local part = Instance.new("Part")
	part.Parent = game.Workspace
	part.Name = tostring(name)

	if parentID == 0 then
		part.Position = BASE_POSITION
	elseif parentID == 1 then
		part.Position = BASE_POSITION + Vector3.new(PARTS_DISTANCE, 0, 0)
	else
		part.Position = BASE_POSITION + Vector3.new(0, 0, PARTS_DISTANCE)
	end

	part.Anchored = true
	part.TopSurface = Enum.SurfaceType.Smooth
	return part
end

local part1 = createPart(0, "Part1") 
local part2 = createPart(1, "Part2") 
local part3 = createPart(2, "Part3") 

-- create decal
local function drawTexture(part, textureID)
	local textureStr = "rbxassetid://" .. tostring(textureID)
	local decaltop = Instance.new("Decal", part)
	decaltop.Face = Enum.NormalId.Top
	decaltop.Texture = textureStr

	local decal1front = Instance.new("Decal", part)
	decal1front.Face = Enum.NormalId.Front
	decal1front.Texture =  textureStr

	local decalleft = Instance.new("Decal", part)
	decalleft.Face = Enum.NormalId.Left
	decalleft.Texture = textureStr

	local decalright = Instance.new("Decal", part)
	decalright.Face = Enum.NormalId.Right
	decalright.Texture =  textureStr

	local decalback = Instance.new("Decal", part)
	decalback.Face = Enum.NormalId.Back
	decalback.Texture = textureStr

	local decalbottom = Instance.new("Decal", part)
	decalbottom.Face = Enum.NormalId.Bottom
	decalbottom.Texture =  textureStr
end

drawTexture(part1, 3410399301)
drawTexture(part2, 5140821972)
drawTexture(part3, 3410402714)

-- create ropes
local function attachParts(fromPart, toPart, length)
	local rope = Instance.new("RopeConstraint")
	rope.Length = length -- rope.CurrentDistance
	local att1 = Instance.new("Attachment") -- part1
	att1.Parent = fromPart
	local att2 = Instance.new("Attachment") -- part2
	att2.Parent = toPart
	rope.Attachment0 = att1
	rope.Attachment1 = att2
	rope.Parent = game.Workspace
	rope.Visible = true
	return rope
end

local rope1to2 = attachParts(part1, part2, PARTS_DISTANCE)
local rope1to3 = attachParts(part1, part3, PARTS_DISTANCE)


UIS.inputChanged:Connect(function(input)
	-- check if mouse points to an object
	if mouse.Target then 
		print("mouse.Target.Name = [" .. tostring(mouse.Target.Name) .. "]")

		if mouse.Target.Name == part1.Name or 
			mouse.Target.Name == part2.Name or 
			mouse.Target.Name == part3.Name
		then
			print("mouse.Target.Name is " .. tostring(mouse.Target.Name))

			parentFrame.Position = UDim2.new(0, mouse.X + PARTS_DISTANCE, 0, mouse.Y - PARTS_DISTANCE) 

			parentFrame.Visible = true
			parentFrame.Active = true
			
		else
			print("parentFrame is not active")
			parentFrame.Visible = false
			parentFrame.Active = false
		end
	end
end)

