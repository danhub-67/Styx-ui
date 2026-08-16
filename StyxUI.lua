local StyxUI = { Themes = {}, CurrentTheme = nil, Icons = {} }

local DefaultIcons = {
	["home"] = "rbxassetid://10723407389",
	["user"] = "rbxassetid://10747373176",
	["settings"] = "rbxassetid://10734950309",
	["search"] = "rbxassetid://10734934585",
	["bell"] = "rbxassetid://10723045999",
	["chevron-down"] = "rbxassetid://10709790948",
	["check"] = "rbxassetid://10709790644",
	["minus"] = "rbxassetid://10747384394",
	["arrow-up-right"] = "rbxassetid://10709790487",
}

local success, result = pcall(function()
	return game:HttpGet(
		"https://gist.githubusercontent.com/Styx-ui/326e7d2471fca9e908649a19d829f9e3/raw/d037c62a10765eb4f890d8983c27c626630657fd/Icons"
	)
end)

local FetchedIcons = nil
if success and result and result ~= "" then
	local loadSuccess, loadedIcons = pcall(function()
		return loadstring(result)()
	end)
	if loadSuccess and type(loadedIcons) == "table" then
		FetchedIcons = loadedIcons
	end
end

StyxUI.Icons = {}
for key, value in pairs(DefaultIcons) do
	StyxUI.Icons[key] = value
end
if FetchedIcons then
	for key, value in pairs(FetchedIcons) do
		StyxUI.Icons[key] = value
	end
end

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")

local tweenInfoHover = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfoClick = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfoRelease = TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfoPop = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

function StyxUI:Gradient(keys, config)
	local keypoints = {}
	for pos, data in pairs(keys) do
		local p = tonumber(pos) / 100
		table.insert(keypoints, ColorSequenceKeypoint.new(p, data.Color))
	end
	table.sort(keypoints, function(a, b)
		return a.Time < b.Time
	end)
	return {
		Type = "Gradient",
		ColorSequence = ColorSequence.new(keypoints),
		Rotation = config and config.Rotation or 0,
	}
end

StyxUI.Themes.Dark = {
	Name = "Dark",
	Accent = Color3.fromHex("#1c1c1f"),
	Outline = Color3.fromHex("#33333a"),
	Text = Color3.fromHex("#FFFFFF"),
	Placeholder = Color3.fromHex("#8f8f99"),
	Icon = Color3.fromHex("#b4b4bb"),
	Toggle = Color3.fromHex("#34d399"),
	Slider = Color3.fromHex("#38bdf8"),
	ElementBackground = Color3.fromHex("#131316"),
}

StyxUI.Themes.Light = {
	Name = "Light",
	Accent = Color3.fromHex("#eceef1"),
	Outline = Color3.fromHex("#d8dade"),
	Text = Color3.fromHex("#18181b"),
	Placeholder = Color3.fromHex("#7d818a"),
	Icon = Color3.fromHex("#5b5f66"),
	Toggle = Color3.fromHex("#22c55e"),
	Slider = Color3.fromHex("#3b82f6"),
	ElementBackground = Color3.fromHex("#f7f8fa"),
}

StyxUI.Themes.Rose = {
	Name = "Rose",
	Accent = Color3.fromHex("#9d174d"),
	Outline = Color3.fromHex("#fb7185"),
	Text = Color3.fromHex("#fff1f2"),
	Placeholder = Color3.fromHex("#fda4af"),
	Icon = Color3.fromHex("#fda4af"),
	Toggle = Color3.fromHex("#fb7185"),
	Slider = Color3.fromHex("#e11d48"),
	ElementBackground = Color3.fromHex("#500724"),
}

StyxUI.Themes.Plant = {
	Name = "Plant",
	Accent = Color3.fromHex("#166534"),
	Outline = Color3.fromHex("#4ade80"),
	Text = Color3.fromHex("#f0fdf4"),
	Placeholder = Color3.fromHex("#86efac"),
	Icon = Color3.fromHex("#4ade80"),
	Toggle = Color3.fromHex("#4ade80"),
	Slider = Color3.fromHex("#16a34a"),
	ElementBackground = Color3.fromHex("#0f3d24"),
}

StyxUI.Themes.Red = {
	Name = "Red",
	Accent = Color3.fromHex("#991b1b"),
	Outline = Color3.fromHex("#f87171"),
	Text = Color3.fromHex("#fef2f2"),
	Placeholder = Color3.fromHex("#fca5a5"),
	Icon = Color3.fromHex("#f87171"),
	Toggle = Color3.fromHex("#f87171"),
	Slider = Color3.fromHex("#dc2626"),
	ElementBackground = Color3.fromHex("#450a0a"),
}

StyxUI.Themes.Indigo = {
	Name = "Indigo",
	Accent = Color3.fromHex("#3730a3"),
	Outline = Color3.fromHex("#818cf8"),
	Text = Color3.fromHex("#eef2ff"),
	Placeholder = Color3.fromHex("#a5b4fc"),
	Icon = Color3.fromHex("#818cf8"),
	Toggle = Color3.fromHex("#818cf8"),
	Slider = Color3.fromHex("#4f46e5"),
	ElementBackground = Color3.fromHex("#1e1b4b"),
}

StyxUI.Themes.Sky = {
	Name = "Sky",
	Accent = Color3.fromHex("#075985"),
	Outline = Color3.fromHex("#38bdf8"),
	Text = Color3.fromHex("#f0f9ff"),
	Placeholder = Color3.fromHex("#7dd3fc"),
	Icon = Color3.fromHex("#38bdf8"),
	Toggle = Color3.fromHex("#38bdf8"),
	Slider = Color3.fromHex("#0284c7"),
	ElementBackground = Color3.fromHex("#082f49"),
}

StyxUI.Themes.Violet = {
	Name = "Violet",
	Accent = Color3.fromHex("#5b21b6"),
	Outline = Color3.fromHex("#a78bfa"),
	Text = Color3.fromHex("#f5f3ff"),
	Placeholder = Color3.fromHex("#c4b5fd"),
	Icon = Color3.fromHex("#a78bfa"),
	Toggle = Color3.fromHex("#a78bfa"),
	Slider = Color3.fromHex("#7c3aed"),
	ElementBackground = Color3.fromHex("#2e1065"),
}

StyxUI.Themes.Amber = {
	Name = "Amber",
	Accent = StyxUI:Gradient(
		{ ["0"] = { Color = Color3.fromHex("#92400e") }, ["100"] = { Color = Color3.fromHex("#f59e0b") } },
		{ Rotation = 45 }
	),
	Outline = Color3.fromHex("#fbbf24"),
	Text = Color3.fromHex("#fffbeb"),
	Placeholder = Color3.fromHex("#fde68a"),
	Icon = Color3.fromHex("#fbbf24"),
	Toggle = Color3.fromHex("#fbbf24"),
	Slider = Color3.fromHex("#d97706"),
	ElementBackground = Color3.fromHex("#451a03"),
}

StyxUI.Themes.Emerald = {
	Name = "Emerald",
	Accent = Color3.fromHex("#065f46"),
	Outline = Color3.fromHex("#34d399"),
	Text = Color3.fromHex("#ecfdf5"),
	Placeholder = Color3.fromHex("#6ee7b7"),
	Icon = Color3.fromHex("#34d399"),
	Toggle = Color3.fromHex("#34d399"),
	Slider = Color3.fromHex("#059669"),
	ElementBackground = Color3.fromHex("#022c22"),
}

StyxUI.Themes.Midnight = {
	Name = "Midnight",
	Accent = Color3.fromHex("#0f172a"),
	Outline = Color3.fromHex("#475569"),
	Text = Color3.fromHex("#f8fafc"),
	Placeholder = Color3.fromHex("#94a3b8"),
	Icon = Color3.fromHex("#cbd5e1"),
	Toggle = Color3.fromHex("#38bdf8"),
	Slider = Color3.fromHex("#0284c7"),
	ElementBackground = Color3.fromHex("#020617"),
}

StyxUI.Themes.Crimson = {
	Name = "Crimson",
	Accent = Color3.fromHex("#881337"),
	Outline = Color3.fromHex("#fb7185"),
	Text = Color3.fromHex("#fff1f2"),
	Placeholder = Color3.fromHex("#fda4af"),
	Icon = Color3.fromHex("#fb7185"),
	Toggle = Color3.fromHex("#fb7185"),
	Slider = Color3.fromHex("#e11d48"),
	ElementBackground = Color3.fromHex("#4c0519"),
}

StyxUI.Themes["Monokai Pro"] = {
	Name = "Monokai Pro",
	Accent = Color3.fromHex("#2d2a2e"),
	Outline = Color3.fromHex("#ffd866"),
	Text = Color3.fromHex("#fcfcfa"),
	Placeholder = Color3.fromHex("#939293"),
	Icon = Color3.fromHex("#ff6188"),
	Toggle = Color3.fromHex("#a9dc76"),
	Slider = Color3.fromHex("#78dce8"),
	ElementBackground = Color3.fromHex("#221f22"),
}

StyxUI.Themes["Cotton Candy"] = {
	Name = "Cotton Candy",
	Accent = StyxUI:Gradient(
		{ ["0"] = { Color = Color3.fromHex("#f9a8d4") }, ["100"] = { Color = Color3.fromHex("#7dd3fc") } },
		{ Rotation = 90 }
	),
	Outline = Color3.fromHex("#f9a8d4"),
	Text = Color3.fromHex("#fdf2f8"),
	Placeholder = Color3.fromHex("#fbcfe8"),
	Icon = Color3.fromHex("#f9a8d4"),
	Toggle = Color3.fromHex("#7dd3fc"),
	Slider = Color3.fromHex("#f472b6"),
	ElementBackground = Color3.fromHex("#581c87"),
}

StyxUI.Themes.Mellowsi = {
	Name = "Mellowsi",
	Accent = Color3.fromHex("#1e1b18"),
	Outline = Color3.fromHex("#d4a373"),
	Text = Color3.fromHex("#faedcd"),
	Placeholder = Color3.fromHex("#ccd5ae"),
	Icon = Color3.fromHex("#d4a373"),
	Toggle = Color3.fromHex("#e9edc9"),
	Slider = Color3.fromHex("#d4a373"),
	ElementBackground = Color3.fromHex("#282421"),
}

local RainbowGradient = StyxUI:Gradient({
	["0"] = { Color = Color3.fromHex("#ef4444") },
	["20"] = { Color = Color3.fromHex("#f97316") },
	["40"] = { Color = Color3.fromHex("#eab308") },
	["60"] = { Color = Color3.fromHex("#22c55e") },
	["80"] = { Color = Color3.fromHex("#3b82f6") },
	["100"] = { Color = Color3.fromHex("#a855f7") },
}, { Rotation = 45 })

StyxUI.Themes.Rainbow = {
	Name = "Rainbow",
	Accent = RainbowGradient,
	Outline = RainbowGradient,
	Text = Color3.fromHex("#ffffff"),
	Placeholder = Color3.fromHex("#d1d5db"),
	Icon = Color3.fromHex("#ffffff"),
	Toggle = RainbowGradient,
	Slider = RainbowGradient,
	ElementBackground = Color3.fromHex("#18181b"),
}

StyxUI.ThemeOrder = {
	"Dark", "Light", "Rose", "Plant", "Red", "Indigo", "Sky", "Violet", "Amber",
	"Emerald", "Midnight", "Crimson", "Monokai Pro", "Cotton Candy", "Mellowsi", "Rainbow",
}

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "StyxUI_FullEngine"
MainGui.ResetOnSpawn = false
MainGui.Parent = CoreGui

local NotificationHolder = Instance.new("Frame")
NotificationHolder.Size = UDim2.new(0, 240, 1, -20)
NotificationHolder.Position = UDim2.new(1, -250, 0, 10)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.ZIndex = 100
NotificationHolder.Parent = MainGui

local NotifList = Instance.new("UIListLayout")
NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifList.Padding = UDim.new(0, 6)
NotifList.Parent = NotificationHolder

local function AddCorner(radius, parent)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
	return c
end

local function ApplyThemeValue(instance, prop, value)
	if type(value) == "table" and value.Type == "Gradient" then
		instance[prop] = Color3.fromRGB(255, 255, 255)
		local grad = instance:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
		grad.Color = value.ColorSequence
		grad.Rotation = value.Rotation
		grad.Parent = instance
	elseif typeof(value) == "Color3" then
		local grad = instance:FindFirstChildOfClass("UIGradient")
		if grad then
			grad:Destroy()
		end
		instance[prop] = value
	end
end

local function AddButtonAnimation(interactiveInst, targetFrame, scaleAmount, fixedOriginalSize)
	scaleAmount = scaleAmount or 0.96
	local originalSize = fixedOriginalSize or targetFrame.Size

	interactiveInst.MouseEnter:Connect(function()
		TweenService:Create(
			targetFrame,
			tweenInfoHover,
			{ Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, originalSize.Y.Scale, originalSize.Y.Offset) }
		):Play()
		local stroke = targetFrame:FindFirstChildOfClass("UIStroke")
		if stroke then
			TweenService:Create(stroke, tweenInfoHover, { Transparency = 0.2 }):Play()
		end
	end)

	interactiveInst.MouseLeave:Connect(function()
		TweenService:Create(targetFrame, tweenInfoHover, { Size = originalSize }):Play()
		local stroke = targetFrame:FindFirstChildOfClass("UIStroke")
		if stroke then
			TweenService:Create(stroke, tweenInfoHover, { Transparency = 0.5 }):Play()
		end
	end)

	interactiveInst.MouseButton1Down:Connect(function()
		TweenService:Create(targetFrame, tweenInfoClick, {
			Size = UDim2.new(
				originalSize.X.Scale * scaleAmount,
				originalSize.X.Offset * scaleAmount,
				originalSize.Y.Scale * scaleAmount,
				originalSize.Y.Offset * scaleAmount
			),
		}):Play()
	end)

	interactiveInst.MouseButton1Up:Connect(function()
		TweenService:Create(targetFrame, tweenInfoRelease, { Size = originalSize }):Play()
	end)
end

local function NormalizeArgs(first, ...)
	if type(first) == "table" then
		return first
	end
	return nil, first, ...
end

function StyxUI:CreateWindow(config)
	config = config or {}
	local currentThemeName = config.Theme or "Dark"
	local footerTextParam = config.FooterText
	local customTitle = config.Title or "Hub"
	local showThemeSelector = config.CustomThemes == true
	local baseSize = config.Size or Vector2.new(420, 300)
	local fullTitleText = "<font color='#ffffff'><b>"
		.. customTitle
		.. "</b></font> <font color='#c0c0c0'>StyxUI</font>"

	local Theme = StyxUI.Themes[currentThemeName] or StyxUI.Themes.Dark
	StyxUI.CurrentTheme = Theme
	local RegisteredElements = {}
	local hasBgImage = config.BackgroundImage ~= nil and config.BackgroundImage ~= ""
	local mainBgTransparency = hasBgImage and 1 or 0.15

	local widgetTextSize = TextService:GetTextSize(
		customTitle .. " StyxUI",
		13,
		Enum.Font.BuilderSansBold,
		Vector2.new(1000, 20)
	)
	local widgetWidth = math.clamp(widgetTextSize.X + 60, 120, math.max(160, baseSize.X * 0.55))

	local TopWidget = Instance.new("Frame")
	TopWidget.Name = "StyxUI_TopWidget"
	TopWidget.AnchorPoint = Vector2.new(0.5, 0)
	TopWidget.Size = UDim2.fromOffset(widgetWidth, 34)
	TopWidget.Position = UDim2.new(0.5, 0, 0, 15)
	TopWidget.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	TopWidget.BackgroundTransparency = 1
	TopWidget.ClipsDescendants = true
	TopWidget.Active = true
	TopWidget.Visible = false
	TopWidget.Parent = MainGui
	AddCorner(8, TopWidget)

	local TopWidgetScale = Instance.new("UIScale")
	TopWidgetScale.Scale = 0
	TopWidgetScale.Parent = TopWidget

	local TopWidgetStroke = Instance.new("UIStroke")
	TopWidgetStroke.Thickness = 5
	TopWidgetStroke.Parent = TopWidget

	local TopWidgetBg = Instance.new("ImageLabel")
	TopWidgetBg.Size = UDim2.new(1, 0, 1, 0)
	TopWidgetBg.BackgroundTransparency = 1
	TopWidgetBg.Image = config.BackgroundImage or ""
	TopWidgetBg.ImageTransparency = config.BackgroundImageTransparency or 0.5
	TopWidgetBg.ScaleType = Enum.ScaleType.Crop
	TopWidgetBg.ZIndex = 1
	TopWidgetBg.Parent = TopWidget
	AddCorner(8, TopWidgetBg)

	local TopWidgetIcon = Instance.new("ImageLabel")
	TopWidgetIcon.Size = UDim2.fromOffset(16, 16)
	TopWidgetIcon.Position = UDim2.new(0, 10, 0.5, -8)
	TopWidgetIcon.BackgroundTransparency = 1
	TopWidgetIcon.Image = StyxUI.Icons["home"] or ""
	TopWidgetIcon.ZIndex = 2
	TopWidgetIcon.Parent = TopWidget

	local TopWidgetTxt = Instance.new("TextLabel")
	TopWidgetTxt.Text = fullTitleText
	TopWidgetTxt.RichText = true
	TopWidgetTxt.TextSize = 13
	TopWidgetTxt.Font = Enum.Font.BuilderSansBold
	TopWidgetTxt.Position = UDim2.new(0, 32, 0, 0)
	TopWidgetTxt.Size = UDim2.new(1, -42, 1, 0)
	TopWidgetTxt.TextXAlignment = Enum.TextXAlignment.Left
	TopWidgetTxt.TextTruncate = Enum.TextTruncate.AtEnd
	TopWidgetTxt.BackgroundTransparency = 1
	TopWidgetTxt.ZIndex = 2
	TopWidgetTxt.Parent = TopWidget

	local TopWidgetClick = Instance.new("TextButton")
	TopWidgetClick.Size = UDim2.new(1, 0, 1, 0)
	TopWidgetClick.Position = UDim2.new(0, 0, 0, 0)
	TopWidgetClick.BackgroundTransparency = 1
	TopWidgetClick.Text = ""
	TopWidgetClick.ZIndex = 3
	TopWidgetClick.Parent = TopWidget

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.fromOffset(baseSize.X, baseSize.Y)
	MainFrame.Position = UDim2.fromScale(0.5, 0.5)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
	MainFrame.BackgroundTransparency = mainBgTransparency
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = MainGui
	AddCorner(10, MainFrame)
	MainFrame.Size = UDim2.fromOffset(0, 0)
	MainFrame.BackgroundTransparency = 1
	MainFrame.Visible = false

	local BackgroundImage = Instance.new("ImageLabel")
	BackgroundImage.Name = "BackgroundImage"
	BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
	BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
	BackgroundImage.BackgroundTransparency = 1
	BackgroundImage.Image = config.BackgroundImage or ""
	BackgroundImage.ImageTransparency = config.BackgroundImageTransparency or 0.5
	BackgroundImage.ScaleType = Enum.ScaleType.Crop
	BackgroundImage.ZIndex = 1
	BackgroundImage.Parent = MainFrame
	AddCorner(10, BackgroundImage)

	local WindowStroke = Instance.new("UIStroke")
	WindowStroke.Thickness = 5
	WindowStroke.Transparency = 0.2
	WindowStroke.Parent = MainFrame

	local ThemeRipple = Instance.new("Frame")
	ThemeRipple.Name = "ThemeRipple"
	ThemeRipple.AnchorPoint = Vector2.new(0.5, 0.5)
	ThemeRipple.Position = UDim2.fromScale(0.5, 0.5)
	ThemeRipple.Size = UDim2.fromOffset(0, 0)
	ThemeRipple.BackgroundTransparency = 0.65
	ThemeRipple.ZIndex = 40
	ThemeRipple.Visible = false
	ThemeRipple.Parent = MainFrame
	AddCorner(1000, ThemeRipple)

	local ThemeRippleGrad = Instance.new("UIGradient")
	ThemeRippleGrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.4),
		NumberSequenceKeypoint.new(0.5, 0.7),
		NumberSequenceKeypoint.new(1, 1),
	})
	ThemeRippleGrad.Parent = ThemeRipple

	local isUIAnimating = false

	local function Minimize()
		if isUIAnimating then
			return
		end
		isUIAnimating = true
		local closeTween = TweenService:Create(
			MainFrame,
			TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
			{ Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1 }
		)
		closeTween:Play()
		closeTween.Completed:Wait()
		MainFrame.Visible = false

		TopWidget.Position = UDim2.new(0.5, 0, 0, 15)
		TopWidget.BackgroundTransparency = 1
		TopWidgetScale.Scale = 0
		TopWidget.Visible = true
		local popTween = TweenService:Create(TopWidgetScale, tweenInfoPop, { Scale = 1 })
		local fadeTween = TweenService:Create(TopWidget, tweenInfoPop, { BackgroundTransparency = hasBgImage and 1 or 0.15 })
		popTween:Play()
		fadeTween:Play()
		isUIAnimating = false
	end

	local function Restore()
		if isUIAnimating then
			return
		end
		isUIAnimating = true
		local hideTween = TweenService:Create(
			TopWidgetScale,
			TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
			{ Scale = 0 }
		)
		local fadeTween = TweenService:Create(
			TopWidget,
			TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
			{ BackgroundTransparency = 1 }
		)
		hideTween:Play()
		fadeTween:Play()
		hideTween.Completed:Wait()
		TopWidget.Visible = false

		MainFrame.Visible = true
		local openTween = TweenService:Create(
			MainFrame,
			TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{ Size = MainFrame:GetAttribute("StyxUI_LastSize") or UDim2.fromOffset(baseSize.X, baseSize.Y), BackgroundTransparency = mainBgTransparency }
		)
		openTween:Play()
		isUIAnimating = false
	end

	TopWidgetClick.MouseButton1Click:Connect(Restore)
	AddButtonAnimation(TopWidgetClick, TopWidget, 0.97, UDim2.fromOffset(widgetWidth, 34))

	local Topbar = Instance.new("Frame")
	Topbar.Size = UDim2.new(1, 0, 0, 36)
	Topbar.BackgroundTransparency = 1
	Topbar.ZIndex = 2
	Topbar.Parent = MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Text = fullTitleText
	TitleLabel.RichText = true
	TitleLabel.TextSize = 13
	TitleLabel.Font = Enum.Font.BuilderSansBold
	TitleLabel.Position = UDim2.new(0, 14, 0, 0)
	TitleLabel.Size = UDim2.new(0, 200, 1, 0)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.ZIndex = 2
	TitleLabel.Parent = Topbar

	local TopControls = Instance.new("Frame")
	TopControls.Size = UDim2.new(0, 90, 1, 0)
	TopControls.Position = UDim2.new(1, -98, 0, 0)
	TopControls.BackgroundTransparency = 1
	TopControls.ZIndex = 2
	TopControls.Parent = Topbar

	local TopControlsLayout = Instance.new("UIListLayout")
	TopControlsLayout.FillDirection = Enum.FillDirection.Horizontal
	TopControlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	TopControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	TopControlsLayout.Padding = UDim.new(0, 6)
	TopControlsLayout.Parent = TopControls

	local ThemeBtn
	if showThemeSelector then
		ThemeBtn = Instance.new("ImageButton")
		ThemeBtn.Size = UDim2.fromOffset(18, 18)
		ThemeBtn.LayoutOrder = 1
		ThemeBtn.BackgroundTransparency = 1
		ThemeBtn.Image = StyxUI.Icons["settings"] or "rbxassetid://10734950309"
		ThemeBtn.ZIndex = 2
		ThemeBtn.Parent = TopControls
		AddButtonAnimation(ThemeBtn, ThemeBtn, 0.85)
	end

	local MinimizeBtn = Instance.new("ImageButton")
	MinimizeBtn.Size = UDim2.fromOffset(18, 18)
	MinimizeBtn.LayoutOrder = 2
	MinimizeBtn.BackgroundTransparency = 1
	MinimizeBtn.Image = StyxUI.Icons["minus"] or "rbxassetid://10747384394"
	MinimizeBtn.ZIndex = 2
	MinimizeBtn.Parent = TopControls
	AddButtonAnimation(MinimizeBtn, MinimizeBtn, 0.85)

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.fromOffset(18, 18)
	CloseBtn.LayoutOrder = 3
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Text = "X"
	CloseBtn.TextSize = 13
	CloseBtn.Font = Enum.Font.BuilderSansBold
	CloseBtn.ZIndex = 2
	CloseBtn.Parent = TopControls
	AddButtonAnimation(CloseBtn, CloseBtn, 0.85)

	MinimizeBtn.MouseButton1Click:Connect(Minimize)

	local ConfirmOverlay = Instance.new("Frame")
	ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
	ConfirmOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ConfirmOverlay.BackgroundTransparency = hasBgImage and 1 or 0.5
	ConfirmOverlay.Visible = false
	ConfirmOverlay.ZIndex = 50
	ConfirmOverlay.Parent = MainFrame

	local ConfirmBox = Instance.new("Frame")
	ConfirmBox.Size = UDim2.fromOffset(260, 120)
	ConfirmBox.Position = UDim2.fromScale(0.5, 0.5)
	ConfirmBox.AnchorPoint = Vector2.new(0.5, 0.5)
	ConfirmBox.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	ConfirmBox.BackgroundTransparency = hasBgImage and 1 or 0
	ConfirmBox.ZIndex = 51
	ConfirmBox.Parent = ConfirmOverlay
	AddCorner(8, ConfirmBox)

	local ConfirmStroke = Instance.new("UIStroke")
	ConfirmStroke.Thickness = 5
	ConfirmStroke.Parent = ConfirmBox

	local ConfirmTxt = Instance.new("TextLabel")
	ConfirmTxt.Text = "<b>Do you want to close the script?</b>"
	ConfirmTxt.RichText = true
	ConfirmTxt.TextSize = 13
	ConfirmTxt.Font = Enum.Font.BuilderSansBold
	ConfirmTxt.TextColor3 = Color3.fromRGB(240, 240, 240)
	ConfirmTxt.Position = UDim2.new(0, 0, 0, 15)
	ConfirmTxt.Size = UDim2.new(1, 0, 0, 30)
	ConfirmTxt.BackgroundTransparency = 1
	ConfirmTxt.ZIndex = 52
	ConfirmTxt.Parent = ConfirmBox

	local YesBtn = Instance.new("TextButton")
	YesBtn.Size = UDim2.fromOffset(90, 28)
	YesBtn.Position = UDim2.new(0.5, -95, 1, -40)
	YesBtn.BackgroundColor3 = Color3.fromRGB(185, 28, 28)
	YesBtn.Text = "YES"
	YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	YesBtn.Font = Enum.Font.BuilderSansBold
	YesBtn.TextSize = 12
	YesBtn.ZIndex = 52
	YesBtn.Parent = ConfirmBox
	AddCorner(6, YesBtn)

	local NoBtn = Instance.new("TextButton")
	NoBtn.Size = UDim2.fromOffset(90, 28)
	NoBtn.Position = UDim2.new(0.5, 5, 1, -40)
	NoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	NoBtn.Text = "NO"
	NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	NoBtn.Font = Enum.Font.BuilderSansBold
	NoBtn.TextSize = 12
	NoBtn.ZIndex = 52
	NoBtn.Parent = ConfirmBox
	AddCorner(6, NoBtn)

	AddButtonAnimation(YesBtn, YesBtn, 0.93)
	AddButtonAnimation(NoBtn, NoBtn, 0.93)

	CloseBtn.MouseButton1Click:Connect(function()
		ConfirmOverlay.Visible = true
	end)

	NoBtn.MouseButton1Click:Connect(function()
		ConfirmOverlay.Visible = false
	end)

	YesBtn.MouseButton1Click:Connect(function()
		MainGui:Destroy()
	end)

	local ThemePopup = Instance.new("Frame")
	ThemePopup.Size = UDim2.fromOffset(130, 200)
	ThemePopup.Position = UDim2.new(1, -140, 0, 36)
	ThemePopup.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	ThemePopup.BackgroundTransparency = hasBgImage and 1 or 0
	ThemePopup.Visible = false
	ThemePopup.ZIndex = 30
	ThemePopup.Parent = MainFrame
	AddCorner(8, ThemePopup)

	local PopupStroke = Instance.new("UIStroke")
	PopupStroke.Thickness = 5
	PopupStroke.Parent = ThemePopup

	local ThemeList = Instance.new("ScrollingFrame")
	ThemeList.Size = UDim2.new(1, -8, 1, -8)
	ThemeList.Position = UDim2.new(0, 4, 0, 4)
	ThemeList.BackgroundTransparency = 1
	ThemeList.BorderSizePixel = 0
	ThemeList.ScrollBarThickness = 2
	ThemeList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ThemeList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ThemeList.ZIndex = 31
	ThemeList.Parent = ThemePopup

	local PopupLayout = Instance.new("UIListLayout")
	PopupLayout.Padding = UDim.new(0, 3)
	PopupLayout.Parent = ThemeList

	local function UpdateTheme(newThemeName, animate)
		local T = StyxUI.Themes[newThemeName] or StyxUI.Themes.Dark
		StyxUI.CurrentTheme = T

		local function ApplyAllColors()
			ApplyThemeValue(WindowStroke, "Color", T.Outline or T.Accent)
			ApplyThemeValue(TopWidgetStroke, "Color", T.Outline or T.Accent)
			ApplyThemeValue(ConfirmStroke, "Color", T.Outline or T.Accent)
			ApplyThemeValue(PopupStroke, "Color", T.Outline or T.Accent)
			ApplyThemeValue(CloseBtn, "TextColor3", T.Text)
			if ThemeBtn then
				ThemeBtn.ImageColor3 = T.Icon or T.Text
			end
			MinimizeBtn.ImageColor3 = T.Icon or T.Text
			TopWidgetIcon.ImageColor3 = T.Icon or T.Text

			if not config.BackgroundImage and T.Background then
				BackgroundImage.Image = T.Background
				TopWidgetBg.Image = T.Background
			end

			for _, item in ipairs(RegisteredElements) do
				if item.Type == "TabBtn" then
					if hasBgImage then
						item.Instance.BackgroundTransparency = 1
					end
					if item.Active then
						ApplyThemeValue(item.Label, "TextColor3", T.Text)
						if not hasBgImage then
							ApplyThemeValue(item.Instance, "BackgroundColor3", T.Accent)
							item.Instance.BackgroundTransparency = 0
						end
						if item.Icon then
							item.Icon.ImageColor3 = T.Icon or T.Text
						end
					else
						ApplyThemeValue(item.Label, "TextColor3", T.Placeholder)
						item.Instance.BackgroundTransparency = 1
						if item.Icon then
							item.Icon.ImageColor3 = T.Icon or T.Placeholder
						end
					end
				elseif item.Type == "Element" then
					if hasBgImage then
						item.Instance.BackgroundTransparency = 1
					else
						item.Instance.BackgroundTransparency = 0
						ApplyThemeValue(item.Instance, "BackgroundColor3", T.ElementBackground)
					end
					if item.Stroke then
						ApplyThemeValue(item.Stroke, "Color", T.Outline or T.Accent)
					end
					if item.Label then
						ApplyThemeValue(item.Label, "TextColor3", T.Text)
					end
					if item.Icon then
						item.Icon.ImageColor3 = T.Icon or T.Text
					end
					if item.SubColor then
						ApplyThemeValue(item.SubColor, "BackgroundColor3", T.Toggle or T.Slider or T.Accent)
					end
				elseif item.Type == "Section" then
					ApplyThemeValue(item.Label, "TextColor3", T.Placeholder)
				elseif item.Type == "Divider" then
					ApplyThemeValue(item.Instance, "BackgroundColor3", T.Outline or T.Accent)
				end
			end
		end

		if animate then
			ThemeRipple.Size = UDim2.fromOffset(0, 0)
			ThemeRipple.BackgroundTransparency = 0.65
			ApplyThemeValue(ThemeRipple, "BackgroundColor3", T.Outline or T.Accent)

			if type(T.Outline) == "table" and T.Outline.Type == "Gradient" then
				ThemeRippleGrad.Color = T.Outline.ColorSequence
				ThemeRippleGrad.Rotation = T.Outline.Rotation
			elseif type(T.Accent) == "table" and T.Accent.Type == "Gradient" then
				ThemeRippleGrad.Color = T.Accent.ColorSequence
				ThemeRippleGrad.Rotation = T.Accent.Rotation
			else
				local baseCol = T.Outline or T.Accent or Color3.fromRGB(255, 255, 255)
				ThemeRippleGrad.Color = ColorSequence.new(baseCol)
			end

			ThemeRipple.Visible = true
			local expandTween = TweenService:Create(
				ThemeRipple,
				TweenInfo.new(0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Size = UDim2.fromOffset(950, 950) }
			)
			expandTween:Play()
			expandTween.Completed:Connect(function()
				ApplyAllColors()
				local fadeTween = TweenService:Create(
					ThemeRipple,
					TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
					{ BackgroundTransparency = 1 }
				)
				fadeTween:Play()
				fadeTween.Completed:Connect(function()
					ThemeRipple.Visible = false
				end)
			end)
		else
			ApplyAllColors()
		end
	end

	if showThemeSelector then
		for _, tName in ipairs(StyxUI.ThemeOrder) do
			if StyxUI.Themes[tName] then
				local TBtn = Instance.new("TextButton")
				TBtn.Size = UDim2.new(1, 0, 0, 22)
				TBtn.BackgroundTransparency = hasBgImage and 1 or 0.7
				TBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
				TBtn.Text = tName
				TBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
				TBtn.TextSize = 11
				TBtn.Font = Enum.Font.BuilderSansMedium
				TBtn.ZIndex = 32
				TBtn.Parent = ThemeList
				AddCorner(4, TBtn)
				AddButtonAnimation(TBtn, TBtn, 0.95)

				TBtn.MouseButton1Click:Connect(function()
					UpdateTheme(tName, true)
					ThemePopup.Visible = false
				end)
			end
		end

		ThemeBtn.MouseButton1Click:Connect(function()
			ThemePopup.Visible = not ThemePopup.Visible
		end)
	end

	local Sidebar = Instance.new("Frame")
	Sidebar.Size = UDim2.new(0, 120, 1, -66)
	Sidebar.Position = UDim2.new(0, 0, 0, 36)
	Sidebar.BackgroundTransparency = 1
	Sidebar.ZIndex = 2
	Sidebar.Parent = MainFrame

	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Size = UDim2.new(1, -10, 1, -10)
	TabContainer.Position = UDim2.new(0, 5, 0, 5)
	TabContainer.BackgroundTransparency = 1
	TabContainer.BorderSizePixel = 0
	TabContainer.ScrollBarThickness = 0
	TabContainer.ZIndex = 2
	TabContainer.Parent = Sidebar

	local TabList = Instance.new("UIListLayout")
	TabList.Padding = UDim.new(0, 3)
	TabList.Parent = TabContainer

	local Divider = Instance.new("Frame")
	Divider.Size = UDim2.new(0, 1, 1, -74)
	Divider.Position = UDim2.new(0, 120, 0, 40)
	Divider.BackgroundTransparency = 0.5
	Divider.ZIndex = 2
	Divider.Parent = MainFrame

	local HDivider = Instance.new("Frame")
	HDivider.Size = UDim2.new(1, 0, 0, 1)
	HDivider.Position = UDim2.new(0, 0, 1, -30)
	HDivider.BackgroundTransparency = 0.5
	HDivider.ZIndex = 2
	HDivider.Parent = MainFrame

	local Footer = Instance.new("TextLabel")
	Footer.Size = UDim2.new(1, 0, 0, 30)
	Footer.Position = UDim2.new(0, 0, 1, -30)
	Footer.BackgroundTransparency = 1
	Footer.Text = footerTextParam and (" " .. footerTextParam) or ""
	Footer.TextColor3 = Color3.fromRGB(150, 150, 150)
	Footer.TextSize = 12
	Footer.Font = Enum.Font.BuilderSansMedium
	Footer.TextXAlignment = Enum.TextXAlignment.Left
	Footer.ZIndex = 2
	Footer.Parent = MainFrame

	local ContentArea = Instance.new("Frame")
	ContentArea.Size = UDim2.new(1, -121, 1, -66)
	ContentArea.Position = UDim2.new(0, 121, 0, 36)
	ContentArea.BackgroundTransparency = 1
	ContentArea.ZIndex = 2
	ContentArea.Parent = MainFrame

	local function EnableDrag(dragFrame, moveFrame)
		local dragging, dragStart, startPos
		dragFrame.InputBegan:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragging = true
				dragStart = input.Position
				startPos = moveFrame.Position
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if
				dragging
				and (
					input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch
				)
			then
				local delta = input.Position - dragStart
				moveFrame.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragging = false
			end
		end)
	end

	EnableDrag(Topbar, MainFrame)

	local WindowObj = { Tabs = {} }

	function WindowObj:SetBackgroundImage(imageId, transparency)
		BackgroundImage.Image = imageId or ""
		TopWidgetBg.Image = imageId or ""
		if transparency then
			BackgroundImage.ImageTransparency = transparency
			TopWidgetBg.ImageTransparency = transparency
		end
	end

	function WindowObj:Minimize()
		Minimize()
	end

	function WindowObj:Restore()
		Restore()
	end

	function WindowObj:SetTheme(themeName)
		UpdateTheme(themeName, true)
	end

	function WindowObj:Tab(configTab, maybeIcon)
		local cfg = NormalizeArgs(configTab)
		local tabName, tabIconKey

		if cfg then
			tabName = cfg.Title
			tabIconKey = cfg.Icon
		else
			tabName = configTab
			tabIconKey = maybeIcon
		end

		local resolvedIcon = nil
		if tabIconKey then
			resolvedIcon = StyxUI.Icons[tabIconKey] or tabIconKey
		end

		local TabBtn = Instance.new("TextButton")
		TabBtn.Size = UDim2.new(1, 0, 0, 28)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = ""
		TabBtn.ZIndex = 2
		TabBtn.Parent = TabContainer
		AddCorner(6, TabBtn)
		AddButtonAnimation(TabBtn, TabBtn, 0.96)

		local TabIconImg = nil
		if resolvedIcon then
			TabIconImg = Instance.new("ImageLabel")
			TabIconImg.Size = UDim2.fromOffset(16, 16)
			TabIconImg.Position = UDim2.new(0, 8, 0.5, -8)
			TabIconImg.BackgroundTransparency = 1
			TabIconImg.Image = resolvedIcon
			TabIconImg.ZIndex = 2
			TabIconImg.Parent = TabBtn
		end

		local TabLabel = Instance.new("TextLabel")
		TabLabel.Text = tabName
		TabLabel.TextSize = 12
		TabLabel.Font = Enum.Font.BuilderSansMedium
		TabLabel.Position = resolvedIcon and UDim2.new(0, 30, 0, 0) or UDim2.new(0, 10, 0, 0)
		TabLabel.Size = resolvedIcon and UDim2.new(1, -35, 1, 0) or UDim2.new(1, -15, 1, 0)
		TabLabel.TextXAlignment = Enum.TextXAlignment.Left
		TabLabel.BackgroundTransparency = 1
		TabLabel.ZIndex = 2
		TabLabel.Parent = TabBtn

		local TabReg = { Type = "TabBtn", Instance = TabBtn, Label = TabLabel, Icon = TabIconImg, Active = false }
		table.insert(RegisteredElements, TabReg)

		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1, -16, 1, -16)
		Page.Position = UDim2.new(0, 8, 0, 8)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.Visible = false
		Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Page.ScrollBarThickness = 2
		Page.ZIndex = 2
		Page.Parent = ContentArea

		local PageList = Instance.new("UIListLayout")
		PageList.Padding = UDim.new(0, 5)
		PageList.Parent = Page

		local function Select()
			for _, t in ipairs(WindowObj.Tabs) do
				t.Page.Visible = false
				t.Reg.Active = false
				t.Btn.BackgroundTransparency = 1
			end
			Page.Visible = true
			TabReg.Active = true
			TabBtn.BackgroundTransparency = hasBgImage and 1 or 0.8
			UpdateTheme(StyxUI.CurrentTheme.Name, false)
		end

		TabBtn.MouseButton1Click:Connect(Select)
		table.insert(WindowObj.Tabs, { Page = Page, Btn = TabBtn, Reg = TabReg })

		if #WindowObj.Tabs == 1 then
			Select()
		end

		local TabObj = {}

		local function RegisterRow(height)
			local Frame = Instance.new("Frame")
			Frame.Size = UDim2.new(1, 0, 0, height)
			Frame.ZIndex = 2
			Frame.Parent = Page
			AddCorner(6, Frame)

			local Stroke = Instance.new("UIStroke")
			Stroke.Thickness = 5
			Stroke.Transparency = 0.5
			Stroke.Parent = Frame

			return Frame, Stroke
		end

		function TabObj:Section(title)
			local Frame = Instance.new("Frame")
			Frame.Size = UDim2.new(1, 0, 0, 22)
			Frame.BackgroundTransparency = 1
			Frame.ZIndex = 2
			Frame.Parent = Page

			local Txt = Instance.new("TextLabel")
			Txt.Text = string.upper(title or "Section")
			Txt.TextSize = 11
			Txt.Font = Enum.Font.BuilderSansBold
			Txt.Position = UDim2.new(0, 2, 0, 6)
			Txt.Size = UDim2.new(1, -4, 0, 14)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			table.insert(RegisteredElements, { Type = "Section", Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)
			return Frame
		end

		function TabObj:Divider()
			local Frame = Instance.new("Frame")
			Frame.Size = UDim2.new(1, 0, 0, 9)
			Frame.BackgroundTransparency = 1
			Frame.ZIndex = 2
			Frame.Parent = Page

			local Line = Instance.new("Frame")
			Line.Size = UDim2.new(1, 0, 0, 1)
			Line.Position = UDim2.new(0, 0, 0.5, 0)
			Line.BackgroundTransparency = 0.5
			Line.ZIndex = 2
			Line.Parent = Frame

			table.insert(RegisteredElements, { Type = "Divider", Instance = Line })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)
			return Frame
		end

		function TabObj:Paragraph(pConfig, maybeContent)
			local cfg = NormalizeArgs(pConfig)
			local title, content

			if cfg then
				title = cfg.Title or ""
				content = cfg.Content or ""
			else
				title = pConfig or ""
				content = maybeContent or ""
			end

			local Frame = Instance.new("Frame")
			Frame.Size = UDim2.new(1, 0, 0, 0)
			Frame.AutomaticSize = Enum.AutomaticSize.Y
			Frame.ZIndex = 2
			Frame.Parent = Page
			AddCorner(6, Frame)

			local Stroke = Instance.new("UIStroke")
			Stroke.Thickness = 5
			Stroke.Transparency = 0.5
			Stroke.Parent = Frame

			local Layout = Instance.new("UIListLayout")
			Layout.Padding = UDim.new(0, 2)
			Layout.Parent = Frame

			local Pad = Instance.new("UIPadding")
			Pad.PaddingTop = UDim.new(0, 8)
			Pad.PaddingBottom = UDim.new(0, 8)
			Pad.PaddingLeft = UDim.new(0, 10)
			Pad.PaddingRight = UDim.new(0, 10)
			Pad.Parent = Frame

			local TitleLbl = Instance.new("TextLabel")
			TitleLbl.Text = title
			TitleLbl.TextSize = 12
			TitleLbl.Font = Enum.Font.BuilderSansBold
			TitleLbl.Size = UDim2.new(1, 0, 0, 16)
			TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
			TitleLbl.BackgroundTransparency = 1
			TitleLbl.ZIndex = 2
			TitleLbl.Parent = Frame

			local ContentLbl = Instance.new("TextLabel")
			ContentLbl.Text = content
			ContentLbl.TextSize = 11
			ContentLbl.Font = Enum.Font.BuilderSansMedium
			ContentLbl.Size = UDim2.new(1, 0, 0, 0)
			ContentLbl.AutomaticSize = Enum.AutomaticSize.Y
			ContentLbl.TextWrapped = true
			ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
			ContentLbl.BackgroundTransparency = 1
			ContentLbl.ZIndex = 2
			ContentLbl.Parent = Frame

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = TitleLbl })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)
			return Frame
		end

		function TabObj:Label(text)
			local Frame, Stroke = RegisterRow(28)
			Stroke.Transparency = 1

			local Txt = Instance.new("TextLabel")
			Txt.Text = text or ""
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(1, -20, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(newText)
				Txt.Text = newText
			end
			return Control
		end

		function TabObj:Button(btnConfig, maybeIcon, maybeCallback)
			local cfg = NormalizeArgs(btnConfig)
			local title, btnIconKey, callback

			if cfg then
				title = cfg.Title
				btnIconKey = cfg.Icon
				callback = cfg.Callback or function() end
			else
				title = btnConfig
				if type(maybeIcon) == "function" then
					callback = maybeIcon
				else
					btnIconKey = maybeIcon
					callback = maybeCallback or function() end
				end
				callback = callback or function() end
			end

			local resolvedBtnIcon = nil
			if btnIconKey then
				resolvedBtnIcon = StyxUI.Icons[btnIconKey] or btnIconKey
			end

			local Frame, Stroke = RegisterRow(32)

			local BtnIconImg = nil
			if resolvedBtnIcon then
				BtnIconImg = Instance.new("ImageLabel")
				BtnIconImg.Size = UDim2.fromOffset(16, 16)
				BtnIconImg.Position = UDim2.new(0, 10, 0.5, -8)
				BtnIconImg.BackgroundTransparency = 1
				BtnIconImg.Image = resolvedBtnIcon
				BtnIconImg.ZIndex = 2
				BtnIconImg.Parent = Frame
			end

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = resolvedBtnIcon and UDim2.new(0, 32, 0, 0) or UDim2.new(0, 10, 0, 0)
			Txt.Size = resolvedBtnIcon and UDim2.new(1, -42, 1, 0) or UDim2.new(1, -20, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			table.insert(RegisteredElements, {
				Type = "Element",
				Instance = Frame,
				Stroke = Stroke,
				Label = Txt,
				Icon = BtnIconImg,
			})

			local Clicker = Instance.new("TextButton")
			Clicker.Size = UDim2.new(1, 0, 1, 0)
			Clicker.BackgroundTransparency = 1
			Clicker.Text = ""
			Clicker.ZIndex = 2
			Clicker.Parent = Frame

			AddButtonAnimation(Clicker, Frame, 0.95)

			Clicker.MouseButton1Click:Connect(function()
				callback()
			end)

			UpdateTheme(StyxUI.CurrentTheme.Name, false)
			return Frame
		end

		function TabObj:Toggle(togConfig, maybeDefault, maybeCallback)
			local cfg = NormalizeArgs(togConfig)
			local title, val, callback

			if cfg then
				title = cfg.Title or "Toggle"
				val = cfg.Value or false
				callback = cfg.Callback or function() end
			else
				title = togConfig or "Toggle"
				if type(maybeDefault) == "function" then
					callback = maybeDefault
					val = false
				else
					val = maybeDefault or false
					callback = maybeCallback or function() end
				end
			end

			local Frame, Stroke = RegisterRow(32)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(1, -50, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local Switch = Instance.new("Frame")
			Switch.Size = UDim2.fromOffset(32, 16)
			Switch.Position = UDim2.new(1, -40, 0.5, -8)
			Switch.ZIndex = 2
			Switch.Parent = Frame
			AddCorner(8, Switch)

			local SwitchStroke = Instance.new("UIStroke")
			SwitchStroke.Thickness = 1.5
			SwitchStroke.Transparency = hasBgImage and 0.4 or 1
			SwitchStroke.Parent = Switch

			local Circle = Instance.new("Frame")
			Circle.Size = UDim2.fromOffset(12, 12)
			Circle.Position = val and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.ZIndex = 3
			Circle.Parent = Switch
			AddCorner(6, Circle)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt, SubColor = Switch })

			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local activeColor = StyxUI.CurrentTheme.Toggle or Color3.fromRGB(51, 199, 89)
			local inactiveColor = Color3.fromRGB(40, 40, 45)
			Switch.BackgroundColor3 = val and activeColor or inactiveColor
			Switch.BackgroundTransparency = hasBgImage and (val and 0.35 or 1) or 0

			local function SetState(newVal, fireCallback)
				val = newVal
				local targetPos = val and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
				TweenService:Create(Circle, tweenInfo, { Position = targetPos }):Play()

				local targetColor = val and (StyxUI.CurrentTheme.Toggle or activeColor) or inactiveColor
				TweenService:Create(Switch, tweenInfo, {
					BackgroundColor3 = targetColor,
					BackgroundTransparency = hasBgImage and (val and 0.35 or 1) or 0,
				}):Play()

				local squishTween = TweenService:Create(
					Circle,
					TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
					{ Size = UDim2.fromOffset(14, 10) }
				)
				squishTween:Play()
				squishTween.Completed:Connect(function()
					TweenService:Create(
						Circle,
						TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
						{ Size = UDim2.fromOffset(12, 12) }
					):Play()
				end)

				if fireCallback then
					pcall(callback, val)
				end
			end

			local Clicker = Instance.new("TextButton")
			Clicker.Size = UDim2.new(1, 0, 1, 0)
			Clicker.BackgroundTransparency = 1
			Clicker.Text = ""
			Clicker.ZIndex = 2
			Clicker.Parent = Frame

			AddButtonAnimation(Clicker, Frame, 0.95)

			Clicker.MouseButton1Click:Connect(function()
				SetState(not val, true)
			end)

			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(newVal)
				SetState(newVal, false)
			end
			function Control:Get()
				return val
			end
			return Control
		end

		function TabObj:Slider(sldConfig, maybeMin, maybeMax, maybeDefault, maybeCallback)
			local cfg = NormalizeArgs(sldConfig)
			local title, min, max, val, callback

			if cfg then
				title = cfg.Title or "Slider"
				min = cfg.Min or 0
				max = cfg.Max or 100
				val = cfg.Value or min
				callback = cfg.Callback or function() end
			else
				title = sldConfig or "Slider"
				min = maybeMin or 0
				max = maybeMax or 100
				val = maybeDefault or min
				callback = maybeCallback or function() end
			end

			local Frame, Stroke = RegisterRow(42)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 4)
			Txt.Size = UDim2.new(1, -60, 0, 16)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local ValTxt = Instance.new("TextLabel")
			ValTxt.Text = tostring(val)
			ValTxt.TextSize = 11
			ValTxt.Font = Enum.Font.BuilderSans
			ValTxt.Position = UDim2.new(1, -45, 0, 4)
			ValTxt.Size = UDim2.new(0, 35, 0, 16)
			ValTxt.TextXAlignment = Enum.TextXAlignment.Right
			ValTxt.BackgroundTransparency = 1
			ValTxt.ZIndex = 2
			ValTxt.Parent = Frame

			local Track = Instance.new("Frame")
			Track.Size = UDim2.new(1, -20, 0, 5)
			Track.Position = UDim2.new(0, 10, 0, 26)
			Track.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
			Track.BackgroundTransparency = hasBgImage and 1 or 0
			Track.ZIndex = 2
			Track.Parent = Frame
			AddCorner(3, Track)

			local TrackStroke = Instance.new("UIStroke")
			TrackStroke.Thickness = 1
			TrackStroke.Transparency = hasBgImage and 0.4 or 1
			TrackStroke.Parent = Track

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
			Fill.ZIndex = 2
			Fill.Parent = Track
			AddCorner(3, Fill)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt, SubColor = Fill })

			local isDragging = false
			local lastPlayedVal = val

			local function SetState(newVal, fireCallback)
				val = math.clamp(newVal, min, max)
				local pos = (val - min) / (max - min)
				Fill.Size = UDim2.new(pos, 0, 1, 0)
				ValTxt.Text = tostring(val)
				if fireCallback then
					pcall(callback, val)
				end
			end

			local function Update(input)
				local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
				local newVal = math.floor(min + ((max - min) * pos))
				SetState(newVal, true)
				if math.abs(newVal - lastPlayedVal) >= ((max - min) * 0.05) then
					lastPlayedVal = newVal
				end
			end

			Track.InputBegan:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					isDragging = true
					Update(input)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if
					isDragging
					and (
						input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch
					)
				then
					Update(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					isDragging = false
				end
			end)

			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(newVal)
				SetState(newVal, false)
			end
			function Control:Get()
				return val
			end
			return Control
		end

		function TabObj:ProgressBar(pbConfig, maybeMax, maybeValue)
			local cfg = NormalizeArgs(pbConfig)
			local title, max, val

			if cfg then
				title = cfg.Title or "Progress"
				max = cfg.Max or 100
				val = cfg.Value or 0
			else
				title = pbConfig or "Progress"
				max = maybeMax or 100
				val = maybeValue or 0
			end

			local Frame, Stroke = RegisterRow(40)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 4)
			Txt.Size = UDim2.new(1, -20, 0, 16)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local Track = Instance.new("Frame")
			Track.Size = UDim2.new(1, -20, 0, 6)
			Track.Position = UDim2.new(0, 10, 0, 24)
			Track.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
			Track.BackgroundTransparency = hasBgImage and 1 or 0
			Track.ZIndex = 2
			Track.Parent = Frame
			AddCorner(3, Track)

			local TrackStroke = Instance.new("UIStroke")
			TrackStroke.Thickness = 1
			TrackStroke.Transparency = hasBgImage and 0.4 or 1
			TrackStroke.Parent = Track

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.new(math.clamp(val / max, 0, 1), 0, 1, 0)
			Fill.ZIndex = 2
			Fill.Parent = Track
			AddCorner(3, Fill)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt, SubColor = Fill })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(newVal)
				val = math.clamp(newVal, 0, max)
				TweenService:Create(Fill, tweenInfoHover, { Size = UDim2.new(val / max, 0, 1, 0) }):Play()
			end
			function Control:Get()
				return val
			end
			return Control
		end

		function TabObj:Input(inpConfig, maybePlaceholder, maybeCallback)
			local cfg = NormalizeArgs(inpConfig)
			local title, placeholder, value, callback

			if cfg then
				title = cfg.Title or "Input"
				placeholder = cfg.Placeholder or "Type here..."
				value = cfg.Value or ""
				callback = cfg.Callback or function() end
			else
				title = inpConfig or "Input"
				if type(maybePlaceholder) == "function" then
					callback = maybePlaceholder
					placeholder = "Type here..."
				else
					placeholder = maybePlaceholder or "Type here..."
					callback = maybeCallback or function() end
				end
				value = ""
			end

			local Frame, Stroke = RegisterRow(42)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(1, -120, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local TextBoxFrame = Instance.new("Frame")
			TextBoxFrame.Size = UDim2.fromOffset(100, 26)
			TextBoxFrame.Position = UDim2.new(1, -110, 0.5, -13)
			TextBoxFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
			TextBoxFrame.BackgroundTransparency = hasBgImage and 1 or 0
			TextBoxFrame.ZIndex = 2
			TextBoxFrame.Parent = Frame
			AddCorner(4, TextBoxFrame)

			local BoxStroke = Instance.new("UIStroke")
			BoxStroke.Thickness = 1.5
			BoxStroke.Transparency = 0.5
			BoxStroke.Parent = TextBoxFrame

			local TextBox = Instance.new("TextBox")
			TextBox.Size = UDim2.new(1, -10, 1, 0)
			TextBox.Position = UDim2.new(0, 5, 0, 0)
			TextBox.BackgroundTransparency = 1
			TextBox.Text = value
			TextBox.PlaceholderText = placeholder
			TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 11
			TextBox.Font = Enum.Font.BuilderSansMedium
			TextBox.ClearTextOnFocus = false
			TextBox.ZIndex = 2
			TextBox.Parent = TextBoxFrame

			TextBox.FocusLost:Connect(function(enterPressed)
				pcall(callback, TextBox.Text, enterPressed)
			end)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(newText)
				TextBox.Text = newText
			end
			function Control:Get()
				return TextBox.Text
			end
			return Control
		end

		function TabObj:Keybind(kbConfig, maybeDefault, maybeCallback)
			local cfg = NormalizeArgs(kbConfig)
			local title, defaultKey, callback

			if cfg then
				title = cfg.Title or "Keybind"
				defaultKey = cfg.Value
				callback = cfg.Callback or function() end
			else
				title = kbConfig or "Keybind"
				defaultKey = maybeDefault
				callback = maybeCallback or function() end
			end

			local Frame, Stroke = RegisterRow(32)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(1, -90, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local KeyBtn = Instance.new("TextButton")
			KeyBtn.Size = UDim2.fromOffset(70, 24)
			KeyBtn.Position = UDim2.new(1, -80, 0.5, -12)
			KeyBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
			KeyBtn.BackgroundTransparency = hasBgImage and 1 or 0
			KeyBtn.Text = defaultKey and defaultKey.Name or "None"
			KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			KeyBtn.TextSize = 11
			KeyBtn.Font = Enum.Font.BuilderSansBold
			KeyBtn.ZIndex = 2
			KeyBtn.Parent = Frame
			AddCorner(4, KeyBtn)

			local KeyStroke = Instance.new("UIStroke")
			KeyStroke.Thickness = 1.5
			KeyStroke.Transparency = 0.5
			KeyStroke.Parent = KeyBtn

			local listening = false
			local currentKey = defaultKey
			local listenConn = nil

			KeyBtn.MouseButton1Click:Connect(function()
				if listening then
					return
				end
				listening = true
				KeyBtn.Text = "..."
				if listenConn then
					listenConn:Disconnect()
				end
				listenConn = UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						currentKey = input.KeyCode
						KeyBtn.Text = currentKey.Name
						listening = false
						if listenConn then
							listenConn:Disconnect()
							listenConn = nil
						end
						pcall(callback, currentKey)
					end
				end)
			end)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(key)
				currentKey = key
				KeyBtn.Text = key and key.Name or "None"
			end
			function Control:Get()
				return currentKey
			end
			return Control
		end

		function TabObj:Dropdown(ddConfig, maybeOptions, maybeCallback)
			local cfg = NormalizeArgs(ddConfig)
			local title, options, default, callback

			if cfg then
				title = cfg.Title or "Dropdown"
				options = cfg.Options or {}
				default = cfg.Value
				callback = cfg.Callback or function() end
			else
				title = ddConfig or "Dropdown"
				options = maybeOptions or {}
				default = nil
				callback = maybeCallback or function() end
			end

			local Frame, Stroke = RegisterRow(32)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(0.42, -10, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local Selector = Instance.new("TextButton")
			Selector.Size = UDim2.new(0.58, -10, 0, 24)
			Selector.Position = UDim2.new(0.42, 0, 0.5, -12)
			Selector.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
			Selector.BackgroundTransparency = hasBgImage and 1 or 0
			Selector.Text = ""
			Selector.ZIndex = 3
			Selector.Parent = Frame
			AddCorner(4, Selector)

			local SelStroke = Instance.new("UIStroke")
			SelStroke.Thickness = 1.5
			SelStroke.Transparency = 0.5
			SelStroke.Parent = Selector

			local SelLabel = Instance.new("TextLabel")
			SelLabel.Text = default and tostring(default) or "Select..."
			SelLabel.TextSize = 11
			SelLabel.Font = Enum.Font.BuilderSansMedium
			SelLabel.Position = UDim2.new(0, 8, 0, 0)
			SelLabel.Size = UDim2.new(1, -26, 1, 0)
			SelLabel.TextXAlignment = Enum.TextXAlignment.Left
			SelLabel.TextTruncate = Enum.TextTruncate.AtEnd
			SelLabel.BackgroundTransparency = 1
			SelLabel.ZIndex = 4
			SelLabel.Parent = Selector

			local Chevron = Instance.new("ImageLabel")
			Chevron.Size = UDim2.fromOffset(12, 12)
			Chevron.Position = UDim2.new(1, -18, 0.5, -6)
			Chevron.BackgroundTransparency = 1
			Chevron.Image = StyxUI.Icons["chevron-down"] or ""
			Chevron.ZIndex = 4
			Chevron.Parent = Selector

			local List = Instance.new("Frame")
			List.Size = UDim2.new(0.58, -10, 0, 0)
			List.Position = UDim2.new(0.42, 0, 1, 2)
			List.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
			List.ClipsDescendants = true
			List.Visible = false
			List.ZIndex = 20
			List.Parent = Frame
			AddCorner(6, List)

			local ListStroke = Instance.new("UIStroke")
			ListStroke.Thickness = 1.5
			ListStroke.Transparency = 0.4
			ListStroke.Parent = List

			local ListLayout = Instance.new("UIListLayout")
			ListLayout.Parent = List

			local selected = default
			local open = false

			local function BuildOptions()
				for _, c in ipairs(List:GetChildren()) do
					if c:IsA("TextButton") then
						c:Destroy()
					end
				end
				for _, opt in ipairs(options) do
					local OptBtn = Instance.new("TextButton")
					OptBtn.Size = UDim2.new(1, 0, 0, 24)
					OptBtn.BackgroundTransparency = 1
					OptBtn.Text = ""
					OptBtn.ZIndex = 21
					OptBtn.Parent = List

					local OptLbl = Instance.new("TextLabel")
					OptLbl.Text = tostring(opt)
					OptLbl.TextSize = 11
					OptLbl.Font = Enum.Font.BuilderSansMedium
					OptLbl.Position = UDim2.new(0, 8, 0, 0)
					OptLbl.Size = UDim2.new(1, -16, 1, 0)
					OptLbl.TextXAlignment = Enum.TextXAlignment.Left
					OptLbl.BackgroundTransparency = 1
					OptLbl.ZIndex = 22
					OptLbl.Parent = OptBtn

					OptBtn.MouseEnter:Connect(function()
						OptBtn.BackgroundTransparency = 0.85
					end)
					OptBtn.MouseLeave:Connect(function()
						OptBtn.BackgroundTransparency = 1
					end)
					OptBtn.MouseButton1Click:Connect(function()
						selected = opt
						SelLabel.Text = tostring(opt)
						open = false
						List.Visible = false
						pcall(callback, opt)
					end)
				end
				List.Size = UDim2.new(0.58, -10, 0, #options * 24)
			end

			BuildOptions()

			Selector.MouseButton1Click:Connect(function()
				open = not open
				List.Visible = open
			end)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(opt)
				selected = opt
				SelLabel.Text = tostring(opt)
			end
			function Control:Get()
				return selected
			end
			function Control:Refresh(newOptions)
				options = newOptions
				BuildOptions()
			end
			return Control
		end

		function TabObj:MultiDropdown(mdConfig, maybeOptions, maybeCallback)
			local cfg = NormalizeArgs(mdConfig)
			local title, options, defaults, callback

			if cfg then
				title = cfg.Title or "Dropdown"
				options = cfg.Options or {}
				defaults = cfg.Value or {}
				callback = cfg.Callback or function() end
			else
				title = mdConfig or "Dropdown"
				options = maybeOptions or {}
				defaults = {}
				callback = maybeCallback or function() end
			end

			local Frame, Stroke = RegisterRow(32)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(0.42, -10, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local Selector = Instance.new("TextButton")
			Selector.Size = UDim2.new(0.58, -10, 0, 24)
			Selector.Position = UDim2.new(0.42, 0, 0.5, -12)
			Selector.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
			Selector.BackgroundTransparency = hasBgImage and 1 or 0
			Selector.Text = ""
			Selector.ZIndex = 3
			Selector.Parent = Frame
			AddCorner(4, Selector)

			local SelStroke = Instance.new("UIStroke")
			SelStroke.Thickness = 1.5
			SelStroke.Transparency = 0.5
			SelStroke.Parent = Selector

			local SelLabel = Instance.new("TextLabel")
			SelLabel.Text = "Select..."
			SelLabel.TextSize = 11
			SelLabel.Font = Enum.Font.BuilderSansMedium
			SelLabel.Position = UDim2.new(0, 8, 0, 0)
			SelLabel.Size = UDim2.new(1, -26, 1, 0)
			SelLabel.TextXAlignment = Enum.TextXAlignment.Left
			SelLabel.TextTruncate = Enum.TextTruncate.AtEnd
			SelLabel.BackgroundTransparency = 1
			SelLabel.ZIndex = 4
			SelLabel.Parent = Selector

			local Chevron = Instance.new("ImageLabel")
			Chevron.Size = UDim2.fromOffset(12, 12)
			Chevron.Position = UDim2.new(1, -18, 0.5, -6)
			Chevron.BackgroundTransparency = 1
			Chevron.Image = StyxUI.Icons["chevron-down"] or ""
			Chevron.ZIndex = 4
			Chevron.Parent = Selector

			local List = Instance.new("Frame")
			List.Size = UDim2.new(0.58, -10, 0, 0)
			List.Position = UDim2.new(0.42, 0, 1, 2)
			List.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
			List.ClipsDescendants = true
			List.Visible = false
			List.ZIndex = 20
			List.Parent = Frame
			AddCorner(6, List)

			local ListStroke = Instance.new("UIStroke")
			ListStroke.Thickness = 1.5
			ListStroke.Transparency = 0.4
			ListStroke.Parent = List

			local ListLayout = Instance.new("UIListLayout")
			ListLayout.Parent = List

			local selectedSet = {}
			for _, v in ipairs(defaults) do
				selectedSet[v] = true
			end

			local function RefreshLabel()
				local names = {}
				for _, opt in ipairs(options) do
					if selectedSet[opt] then
						table.insert(names, tostring(opt))
					end
				end
				SelLabel.Text = (#names > 0) and table.concat(names, ", ") or "Select..."
			end

			local function BuildOptions()
				for _, c in ipairs(List:GetChildren()) do
					if c:IsA("TextButton") then
						c:Destroy()
					end
				end
				for _, opt in ipairs(options) do
					local OptBtn = Instance.new("TextButton")
					OptBtn.Size = UDim2.new(1, 0, 0, 24)
					OptBtn.BackgroundTransparency = 1
					OptBtn.Text = ""
					OptBtn.ZIndex = 21
					OptBtn.Parent = List

					local CheckBox = Instance.new("Frame")
					CheckBox.Size = UDim2.fromOffset(14, 14)
					CheckBox.Position = UDim2.new(0, 8, 0.5, -7)
					CheckBox.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
					CheckBox.ZIndex = 22
					CheckBox.Parent = OptBtn
					AddCorner(3, CheckBox)

					local CheckIcon = Instance.new("ImageLabel")
					CheckIcon.Size = UDim2.new(1, 0, 1, 0)
					CheckIcon.BackgroundTransparency = 1
					CheckIcon.Image = StyxUI.Icons["check"] or ""
					CheckIcon.ImageTransparency = selectedSet[opt] and 0 or 1
					CheckIcon.ZIndex = 23
					CheckIcon.Parent = CheckBox

					local OptLbl = Instance.new("TextLabel")
					OptLbl.Text = tostring(opt)
					OptLbl.TextSize = 11
					OptLbl.Font = Enum.Font.BuilderSansMedium
					OptLbl.Position = UDim2.new(0, 28, 0, 0)
					OptLbl.Size = UDim2.new(1, -36, 1, 0)
					OptLbl.TextXAlignment = Enum.TextXAlignment.Left
					OptLbl.BackgroundTransparency = 1
					OptLbl.ZIndex = 22
					OptLbl.Parent = OptBtn

					OptBtn.MouseEnter:Connect(function()
						OptBtn.BackgroundTransparency = 0.85
					end)
					OptBtn.MouseLeave:Connect(function()
						OptBtn.BackgroundTransparency = 1
					end)
					OptBtn.MouseButton1Click:Connect(function()
						selectedSet[opt] = not selectedSet[opt]
						CheckIcon.ImageTransparency = selectedSet[opt] and 0 or 1
						RefreshLabel()
						local out = {}
						for _, o in ipairs(options) do
							if selectedSet[o] then
								table.insert(out, o)
							end
						end
						pcall(callback, out)
					end)
				end
				List.Size = UDim2.new(0.58, -10, 0, #options * 24)
			end

			BuildOptions()
			RefreshLabel()

			Selector.MouseButton1Click:Connect(function()
				List.Visible = not List.Visible
			end)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Get()
				local out = {}
				for _, o in ipairs(options) do
					if selectedSet[o] then
						table.insert(out, o)
					end
				end
				return out
			end
			function Control:Set(list)
				selectedSet = {}
				for _, v in ipairs(list) do
					selectedSet[v] = true
				end
				BuildOptions()
				RefreshLabel()
			end
			return Control
		end

		function TabObj:Colorpicker(cpConfig, maybeDefault, maybeCallback)
			local cfg = NormalizeArgs(cpConfig)
			local title, defaultColor, callback

			if cfg then
				title = cfg.Title or "Color Picker"
				defaultColor = cfg.Value or Color3.fromRGB(88, 101, 242)
				callback = cfg.Callback or function() end
			else
				title = cpConfig or "Color Picker"
				defaultColor = maybeDefault or Color3.fromRGB(88, 101, 242)
				callback = maybeCallback or function() end
			end

			local Frame, Stroke = RegisterRow(32)

			local Txt = Instance.new("TextLabel")
			Txt.Text = title
			Txt.TextSize = 12
			Txt.Font = Enum.Font.BuilderSansMedium
			Txt.Position = UDim2.new(0, 10, 0, 0)
			Txt.Size = UDim2.new(1, -60, 1, 0)
			Txt.TextXAlignment = Enum.TextXAlignment.Left
			Txt.BackgroundTransparency = 1
			Txt.ZIndex = 2
			Txt.Parent = Frame

			local Swatch = Instance.new("Frame")
			Swatch.Size = UDim2.fromOffset(26, 18)
			Swatch.Position = UDim2.new(1, -36, 0.5, -9)
			Swatch.BackgroundColor3 = defaultColor
			Swatch.ZIndex = 2
			Swatch.Parent = Frame
			AddCorner(4, Swatch)

			local SwatchStroke = Instance.new("UIStroke")
			SwatchStroke.Thickness = 1.5
			SwatchStroke.Transparency = 0.3
			SwatchStroke.Parent = Swatch

			local Clicker = Instance.new("TextButton")
			Clicker.Size = UDim2.new(1, 0, 1, 0)
			Clicker.BackgroundTransparency = 1
			Clicker.Text = ""
			Clicker.ZIndex = 2
			Clicker.Parent = Frame

			AddButtonAnimation(Clicker, Frame, 0.97)

			local CPOverlay = Instance.new("Frame")
			CPOverlay.Size = UDim2.new(1, 0, 1, 0)
			CPOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			CPOverlay.BackgroundTransparency = hasBgImage and 1 or 0.5
			CPOverlay.Visible = false
			CPOverlay.ZIndex = 60
			CPOverlay.Parent = MainFrame

			local Popup = Instance.new("Frame")
			Popup.Size = UDim2.fromOffset(224, 258)
			Popup.Position = UDim2.fromScale(0.5, 0.5)
			Popup.AnchorPoint = Vector2.new(0.5, 0.5)
			Popup.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
			Popup.BackgroundTransparency = hasBgImage and 1 or 0
			Popup.ZIndex = 61
			Popup.Parent = CPOverlay
			AddCorner(10, Popup)

			local PopupStroke2 = Instance.new("UIStroke")
			PopupStroke2.Thickness = 5
			PopupStroke2.Parent = Popup

			local PopTitle = Instance.new("TextLabel")
			PopTitle.Text = title
			PopTitle.TextSize = 12
			PopTitle.Font = Enum.Font.BuilderSansBold
			PopTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
			PopTitle.Position = UDim2.new(0, 14, 0, 12)
			PopTitle.Size = UDim2.new(1, -50, 0, 18)
			PopTitle.TextXAlignment = Enum.TextXAlignment.Left
			PopTitle.BackgroundTransparency = 1
			PopTitle.ZIndex = 62
			PopTitle.Parent = Popup

			local CloseCP = Instance.new("TextButton")
			CloseCP.Size = UDim2.fromOffset(18, 18)
			CloseCP.Position = UDim2.new(1, -28, 0, 10)
			CloseCP.BackgroundTransparency = 1
			CloseCP.Text = "X"
			CloseCP.TextColor3 = Color3.fromRGB(200, 200, 200)
			CloseCP.TextSize = 11
			CloseCP.Font = Enum.Font.BuilderSansBold
			CloseCP.ZIndex = 62
			CloseCP.Parent = Popup

			local hue, sat, val = defaultColor:ToHSV()

			local SVBox = Instance.new("Frame")
			SVBox.Size = UDim2.new(1, -28, 0, 120)
			SVBox.Position = UDim2.new(0, 14, 0, 38)
			SVBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
			SVBox.ClipsDescendants = true
			SVBox.ZIndex = 62
			SVBox.Parent = Popup
			AddCorner(8, SVBox)

			local SVWhite = Instance.new("Frame")
			SVWhite.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SVWhite.Size = UDim2.new(1, 0, 1, 0)
			SVWhite.ZIndex = 62
			SVWhite.Parent = SVBox

			local SVWhiteGrad = Instance.new("UIGradient")
			SVWhiteGrad.Rotation = 0
			SVWhiteGrad.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 1),
			})
			SVWhiteGrad.Parent = SVWhite

			local SVBlack = Instance.new("Frame")
			SVBlack.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			SVBlack.Size = UDim2.new(1, 0, 1, 0)
			SVBlack.ZIndex = 63
			SVBlack.Parent = SVBox

			local SVBlackGrad = Instance.new("UIGradient")
			SVBlackGrad.Rotation = 90
			SVBlackGrad.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(1, 0),
			})
			SVBlackGrad.Parent = SVBlack

			local SVCursor = Instance.new("Frame")
			SVCursor.Size = UDim2.fromOffset(14, 14)
			SVCursor.AnchorPoint = Vector2.new(0.5, 0.5)
			SVCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SVCursor.ZIndex = 64
			SVCursor.Parent = SVBox
			AddCorner(1000, SVCursor)

			local SVCursorStroke = Instance.new("UIStroke")
			SVCursorStroke.Color = Color3.fromRGB(20, 20, 25)
			SVCursorStroke.Thickness = 2
			SVCursorStroke.Parent = SVCursor

			local HueTrack = Instance.new("Frame")
			HueTrack.Size = UDim2.new(1, -28, 0, 16)
			HueTrack.Position = UDim2.new(0, 14, 0, 166)
			HueTrack.ZIndex = 62
			HueTrack.Parent = Popup
			AddCorner(1000, HueTrack)

			local HueGradient = Instance.new("UIGradient")
			HueGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromHSV(0 / 6, 1, 1)),
				ColorSequenceKeypoint.new(1 / 6, Color3.fromHSV(1 / 6, 1, 1)),
				ColorSequenceKeypoint.new(2 / 6, Color3.fromHSV(2 / 6, 1, 1)),
				ColorSequenceKeypoint.new(3 / 6, Color3.fromHSV(3 / 6, 1, 1)),
				ColorSequenceKeypoint.new(4 / 6, Color3.fromHSV(4 / 6, 1, 1)),
				ColorSequenceKeypoint.new(5 / 6, Color3.fromHSV(5 / 6, 1, 1)),
				ColorSequenceKeypoint.new(1.00, Color3.fromHSV(1, 1, 1)),
			})
			HueGradient.Parent = HueTrack

			local HueKnob = Instance.new("Frame")
			HueKnob.Size = UDim2.new(0, 6, 1, 4)
			HueKnob.AnchorPoint = Vector2.new(0.5, 0.5)
			HueKnob.Position = UDim2.new(hue, 0, 0.5, 0)
			HueKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueKnob.ZIndex = 63
			HueKnob.Parent = HueTrack
			AddCorner(3, HueKnob)

			local HueKnobStroke = Instance.new("UIStroke")
			HueKnobStroke.Color = Color3.fromRGB(20, 20, 25)
			HueKnobStroke.Thickness = 1.5
			HueKnobStroke.Parent = HueKnob

			local PreviewSwatch = Instance.new("Frame")
			PreviewSwatch.Size = UDim2.fromOffset(28, 28)
			PreviewSwatch.Position = UDim2.new(0, 14, 0, 194)
			PreviewSwatch.BackgroundColor3 = defaultColor
			PreviewSwatch.ZIndex = 62
			PreviewSwatch.Parent = Popup
			AddCorner(6, PreviewSwatch)

			local PreviewStroke = Instance.new("UIStroke")
			PreviewStroke.Thickness = 1.5
			PreviewStroke.Parent = PreviewSwatch

			local HexFrame = Instance.new("Frame")
			HexFrame.Size = UDim2.new(1, -94, 0, 28)
			HexFrame.Position = UDim2.new(0, 50, 0, 194)
			HexFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
			HexFrame.BackgroundTransparency = hasBgImage and 1 or 0
			HexFrame.ZIndex = 62
			HexFrame.Parent = Popup
			AddCorner(6, HexFrame)

			local HexStroke = Instance.new("UIStroke")
			HexStroke.Thickness = 1.5
			HexStroke.Transparency = 0.5
			HexStroke.Parent = HexFrame

			local HashLbl = Instance.new("TextLabel")
			HashLbl.Text = "#"
			HashLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
			HashLbl.TextSize = 12
			HashLbl.Font = Enum.Font.BuilderSansBold
			HashLbl.Position = UDim2.new(0, 8, 0, 0)
			HashLbl.Size = UDim2.new(0, 14, 1, 0)
			HashLbl.BackgroundTransparency = 1
			HashLbl.ZIndex = 63
			HashLbl.Parent = HexFrame

			local HexBox = Instance.new("TextBox")
			HexBox.Size = UDim2.new(1, -24, 1, 0)
			HexBox.Position = UDim2.new(0, 20, 0, 0)
			HexBox.BackgroundTransparency = 1
			HexBox.Text = defaultColor:ToHex()
			HexBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			HexBox.TextSize = 12
			HexBox.Font = Enum.Font.BuilderSansMedium
			HexBox.TextXAlignment = Enum.TextXAlignment.Left
			HexBox.ClearTextOnFocus = false
			HexBox.ZIndex = 63
			HexBox.Parent = HexFrame

			local selectedColor = defaultColor
			local draggingSV = false
			local draggingHue = false

			local function Recompute(fireCallback)
				selectedColor = Color3.fromHSV(hue, sat, val)
				SVBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				SVCursor.Position = UDim2.new(sat, 0, 1 - val, 0)
				HueKnob.Position = UDim2.new(hue, 0, 0.5, 0)
				Swatch.BackgroundColor3 = selectedColor
				PreviewSwatch.BackgroundColor3 = selectedColor
				HexBox.Text = selectedColor:ToHex()
				if fireCallback then
					pcall(callback, selectedColor)
				end
			end

			local function UpdateSV(inputPos)
				local absPos = SVBox.AbsolutePosition
				local absSize = SVBox.AbsoluteSize
				if absSize.X <= 0 or absSize.Y <= 0 then
					return
				end
				sat = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
				val = 1 - math.clamp((inputPos.Y - absPos.Y) / absSize.Y, 0, 1)
				Recompute(true)
			end

			local function UpdateHue(inputPos)
				local absPos = HueTrack.AbsolutePosition
				local absSize = HueTrack.AbsoluteSize
				if absSize.X <= 0 then
					return
				end
				hue = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
				Recompute(true)
			end

			SVBox.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSV = true
					UpdateSV(input.Position)
				end
			end)

			SVBox.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSV = false
				end
			end)

			HueTrack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingHue = true
					UpdateHue(input.Position)
				end
			end)

			HueTrack.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingHue = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end
				if draggingSV then
					UpdateSV(input.Position)
				elseif draggingHue then
					UpdateHue(input.Position)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					draggingSV = false
					draggingHue = false
				end
			end)

			local function CommitHex()
				local hex = string.gsub(HexBox.Text, "#", "")
				local ok, col = pcall(function()
					return Color3.fromHex("#" .. hex)
				end)
				if ok and col then
					hue, sat, val = col:ToHSV()
					Recompute(true)
				else
					HexBox.Text = selectedColor:ToHex()
				end
			end

			HexBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					CommitHex()
				end
			end)

			CloseCP.MouseButton1Click:Connect(function()
				CPOverlay.Visible = false
			end)

			Clicker.MouseButton1Click:Connect(function()
				CPOverlay.Visible = true
			end)

			Recompute(false)

			table.insert(RegisteredElements, { Type = "Element", Instance = Frame, Stroke = Stroke, Label = Txt })
			UpdateTheme(StyxUI.CurrentTheme.Name, false)

			local Control = {}
			function Control:Set(c)
				hue, sat, val = c:ToHSV()
				Recompute(true)
			end
			function Control:Get()
				return selectedColor
			end
			return Control
		end

		return TabObj
	end

	UpdateTheme(currentThemeName, false)

	MainFrame.Visible = true
	TweenService:Create(
		MainFrame,
		TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Size = UDim2.fromOffset(baseSize.X, baseSize.Y), BackgroundTransparency = mainBgTransparency }
	):Play()

	return WindowObj
end

function StyxUI:Notification(config)
	config = config or {}
	local title = config.Title or "Notification"
	local content = config.Content or ""
	local duration = config.Duration or 3
	local ntype = config.Type or "Info"

	local typeColors = {
		Success = Color3.fromRGB(87, 242, 135),
		Error = Color3.fromRGB(237, 66, 69),
		Warning = Color3.fromRGB(250, 166, 26),
		Info = Color3.fromRGB(88, 101, 242),
	}
	local accent = typeColors[ntype] or typeColors.Info

	local NotifFrame = Instance.new("Frame")
	NotifFrame.Size = UDim2.new(1, 0, 0, 0)
	NotifFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	NotifFrame.BackgroundTransparency = 0.15
	NotifFrame.ClipsDescendants = true
	NotifFrame.Parent = NotificationHolder
	AddCorner(8, NotifFrame)

	local NotifStroke = Instance.new("UIStroke")
	NotifStroke.Thickness = 5
	NotifStroke.Transparency = 0.2
	ApplyThemeValue(
		NotifStroke,
		"Color",
		(StyxUI.CurrentTheme and (StyxUI.CurrentTheme.Outline or StyxUI.CurrentTheme.Accent)) or Color3.fromHex("#3f3f46")
	)
	NotifStroke.Parent = NotifFrame

	local AccentBar = Instance.new("Frame")
	AccentBar.Size = UDim2.new(0, 3, 1, 0)
	AccentBar.BackgroundColor3 = accent
	AccentBar.ZIndex = 2
	AccentBar.Parent = NotifFrame
	AddCorner(2, AccentBar)

	local TitleLbl = Instance.new("TextLabel")
	TitleLbl.Text = title
	TitleLbl.TextSize = 12
	TitleLbl.Font = Enum.Font.BuilderSansBold
	TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLbl.Position = UDim2.new(0, 14, 0, 8)
	TitleLbl.Size = UDim2.new(1, -24, 0, 16)
	TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
	TitleLbl.BackgroundTransparency = 1
	TitleLbl.Parent = NotifFrame

	local ContentLbl = Instance.new("TextLabel")
	ContentLbl.Text = content
	ContentLbl.TextSize = 11
	ContentLbl.Font = Enum.Font.BuilderSans
	ContentLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
	ContentLbl.Position = UDim2.new(0, 14, 0, 26)
	ContentLbl.Size = UDim2.new(1, -24, 0, 24)
	ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
	ContentLbl.TextYAlignment = Enum.TextYAlignment.Top
	ContentLbl.TextWrapped = true
	ContentLbl.BackgroundTransparency = 1
	ContentLbl.Parent = NotifFrame

	TweenService:Create(
		NotifFrame,
		TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Size = UDim2.new(1, 0, 0, 60) }
	):Play()

	task.delay(duration, function()
		local outTween = TweenService:Create(
			NotifFrame,
			TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
			{ Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1 }
		)
		outTween:Play()
		outTween.Completed:Connect(function()
			NotifFrame:Destroy()
		end)
	end)
end

function StyxUI:KeySystem(config)
	config = config or {}
	local Title = config.Title or "Key System"
	local Link = config.Link or ""
	local Keys = config.Keys or {}
	local OnSuccess = config.OnSuccess or function() end
	local hasBgImage = config.BackgroundImage ~= nil and config.BackgroundImage ~= ""
	local frameBgTransparency = hasBgImage and 1 or 0.15

	local KeyGui = Instance.new("ScreenGui")
	KeyGui.Name = "StyxUI_KeySystem"
	KeyGui.ResetOnSpawn = false
	KeyGui.Parent = CoreGui

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.fromOffset(0, 0)
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	Frame.BackgroundTransparency = 1
	Frame.ClipsDescendants = true
	Frame.Parent = KeyGui
	AddCorner(10, Frame)

	if hasBgImage then
		local BgImg = Instance.new("ImageLabel")
		BgImg.Size = UDim2.new(1, 0, 1, 0)
		BgImg.BackgroundTransparency = 1
		BgImg.Image = config.BackgroundImage
		BgImg.ImageTransparency = config.BackgroundImageTransparency or 0.5
		BgImg.ScaleType = Enum.ScaleType.Crop
		BgImg.ZIndex = 1
		BgImg.Parent = Frame
		AddCorner(10, BgImg)
	end

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 5
	Stroke.Transparency = 0.2
	Stroke.Color = Color3.fromHex("#3f3f46")
	Stroke.Parent = Frame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Text = Title
	TitleLabel.TextSize = 14
	TitleLabel.Font = Enum.Font.BuilderSansBold
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.Position = UDim2.new(0, 15, 0, 10)
	TitleLabel.Size = UDim2.new(1, -30, 0, 20)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.ZIndex = 2
	TitleLabel.Parent = Frame

	local TextBoxFrame = Instance.new("Frame")
	TextBoxFrame.Size = UDim2.new(1, -30, 0, 32)
	TextBoxFrame.Position = UDim2.new(0, 15, 0, 40)
	TextBoxFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
	TextBoxFrame.BackgroundTransparency = hasBgImage and 1 or 0
	TextBoxFrame.ZIndex = 2
	TextBoxFrame.Parent = Frame
	AddCorner(6, TextBoxFrame)

	local TextBoxStroke = Instance.new("UIStroke")
	TextBoxStroke.Thickness = 1.5
	TextBoxStroke.Transparency = 0.5
	TextBoxStroke.Color = Color3.fromHex("#3f3f46")
	TextBoxStroke.Parent = TextBoxFrame

	local TextBox = Instance.new("TextBox")
	TextBox.Size = UDim2.new(1, -10, 1, 0)
	TextBox.Position = UDim2.new(0, 5, 0, 0)
	TextBox.BackgroundTransparency = 1
	TextBox.Text = ""
	TextBox.PlaceholderText = "Enter Key..."
	TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextSize = 12
	TextBox.Font = Enum.Font.BuilderSansMedium
	TextBox.ClearTextOnFocus = false
	TextBox.ZIndex = 2
	TextBox.Parent = TextBoxFrame

	local GetKeyBtn = Instance.new("TextButton")
	GetKeyBtn.Size = UDim2.new(0.5, -20, 0, 30)
	GetKeyBtn.Position = UDim2.new(0, 15, 0, 80)
	GetKeyBtn.BackgroundColor3 = Color3.fromRGB(39, 39, 42)
	GetKeyBtn.BackgroundTransparency = hasBgImage and 1 or 0
	GetKeyBtn.Text = "Get Key"
	GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	GetKeyBtn.Font = Enum.Font.BuilderSansBold
	GetKeyBtn.TextSize = 12
	GetKeyBtn.ZIndex = 2
	GetKeyBtn.Parent = Frame
	AddCorner(6, GetKeyBtn)
	AddButtonAnimation(GetKeyBtn, GetKeyBtn, 0.95)

	local VerifyBtn = Instance.new("TextButton")
	VerifyBtn.Size = UDim2.new(0.5, -20, 0, 30)
	VerifyBtn.Position = UDim2.new(0.5, 5, 0, 80)
	VerifyBtn.BackgroundColor3 = Color3.fromRGB(51, 199, 89)
	VerifyBtn.BackgroundTransparency = hasBgImage and 0.35 or 0
	VerifyBtn.Text = "Verify"
	VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	VerifyBtn.Font = Enum.Font.BuilderSansBold
	VerifyBtn.TextSize = 12
	VerifyBtn.ZIndex = 2
	VerifyBtn.Parent = Frame
	AddCorner(6, VerifyBtn)
	AddButtonAnimation(VerifyBtn, VerifyBtn, 0.95)

	Frame.Visible = true
	TweenService:Create(
		Frame,
		TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Size = UDim2.fromOffset(300, 125), BackgroundTransparency = frameBgTransparency }
	):Play()

	GetKeyBtn.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(Link)
		end
	end)

	VerifyBtn.MouseButton1Click:Connect(function()
		local entered = TextBox.Text
		local valid = false

		for _, k in ipairs(Keys) do
			if k == entered then
				valid = true
				break
			end
		end

		if valid then
			local closeTween = TweenService:Create(
				Frame,
				TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
				{ Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1 }
			)
			closeTween:Play()
			closeTween.Completed:Connect(function()
				KeyGui:Destroy()
				OnSuccess()
			end)
		else
			TextBox.Text = ""
			TextBox.PlaceholderText = "Invalid Key!"
			TextBox.PlaceholderColor3 = Color3.fromRGB(255, 50, 50)
			task.delay(1.5, function()
				TextBox.PlaceholderText = "Enter Key..."
				TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
			end)
		end
	end)
end

return StyxUI
