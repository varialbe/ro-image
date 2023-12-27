local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function fetchImageData(imageUrl)
	local requestUrl = "{https://YourWebsite.Com}/{fileName}.php?url={imageURL}" .. HttpService:UrlEncode(imageUrl) -- Add your API URL here.

	local response = HttpService:GetAsync(requestUrl)
	if response then
		return HttpService:JSONDecode(response)
	else
		warn("Failed to fetch image data.")
		return nil
	end
end

local function createPixelFrames(imageData, parent)
	local gridSize = UDim2.new(1 / imageData[1][2], 0, 1 / imageData[1][3], 0)

	for i = 2, #imageData do
		local pixel = imageData[i]
		local x = (i-2) % imageData[1][2] + 1
		local y = math.floor((i-2) / imageData[1][2]) + 1
		local frame = Instance.new("Frame")
		frame.BackgroundColor3 = Color3.fromRGB(pixel[1], pixel[2], pixel[3])
		frame.Size = gridSize
		frame.Position = UDim2.new(gridSize.X.Scale * (x - 1), 0, gridSize.Y.Scale * (y - 1), 0)
		frame.Parent = parent
	end
end

local imageUrl = "imageURL" -- Replace with your image URL
local imageData = fetchImageData(imageUrl)

if imageData then
	local pixelDisplay = Instance.new("Frame")
	pixelDisplay.Size = UDim2.new(0, 200, 0, 200) -- Adjust size as needed
	pixelDisplay.Parent = ReplicatedStorage

	createPixelFrames(imageData, pixelDisplay)
end
