local Library = {}
Library.__index = Library

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local UIModule = require(script.Parent.UI.lua)
local WidgetsModule = require(script.Parent.Widgets.lua)

local IconsModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
IconsModule.SetIconsType("lucide")

local function CreateLoader(parent)
	local loader = Instance.new("Frame")
	loader.Name = "Loader"
	loader.Size = UDim2.new(1, 0, 1, 0)
	loader.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	loader.BorderSizePixel = 0
	loader.ZIndex = 1000
	loader.Parent = parent
	
	local logoText = Instance.new("TextLabel")
	logoText.Size = UDim2.new(0, 300, 0, 50)
	logoText.Position = UDim2.new(0.5, -150, 0.5, -80)
	logoText.BackgroundTransparency = 1
	logoText.Text = "Loading GUI"
	logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
	logoText.TextSize = 32
	logoText.Font = Enum.Font.GothamBold
	logoText.Parent = loader
	
	local progressBack = Instance.new("Frame")
	progressBack.Size = UDim2.new(0, 300, 0, 6)
	progressBack.Position = UDim2.new(0.5, -150, 0.5, 0)
	progressBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	progressBack.BorderSizePixel = 0
	progressBack.Parent = loader
	
	local progressCorner = Instance.new("UICorner")
	progressCorner.CornerRadius = UDim.new(0, 3)
	progressCorner.Parent = progressBack
	
	local progressFill = Instance.new("Frame")
	progressFill.Size = UDim2.new(0, 0, 1, 0)
	progressFill.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
	progressFill.BorderSizePixel = 0
	progressFill.Parent = progressBack
	
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 3)
	fillCorner.Parent = progressFill
	
	local statusText = Instance.new("TextLabel")
	statusText.Size = UDim2.new(0, 300, 0, 30)
	statusText.Position = UDim2.new(0.5, -150, 0.5, 20)
	statusText.BackgroundTransparency = 1
	statusText.Text = "Loading"
	statusText.TextColor3 = Color3.fromRGB(180, 180, 180)
	statusText.TextSize = 14
	statusText.Font = Enum.Font.Gotham
	statusText.Parent = loader
	
	local dots = 0
	local dotConnection
	dotConnection = RunService.Heartbeat:Connect(function()
		dots = (dots + 1) % 4
		statusText.Text = "Loading" .. string.rep(".", dots)
	end)
	
	return {
		Frame = loader,
		Progress = function(percent)
			TweenService:Create(progressFill, TweenInfo.new(0.3), {Size = UDim2.new(percent, 0, 1, 0)}):Play()
		end,
		Finish = function()
			dotConnection:Disconnect()
			TweenService:Create(loader, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			TweenService:Create(logoText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			TweenService:Create(progressBack, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			TweenService:Create(progressFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			TweenService:Create(statusText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			wait(0.6)
			loader:Destroy()
		end
	}
end

function Library:CreateWindow(title, subtitle, theme, home)
	local self = setmetatable({}, Library)
	
	title = title or "GUI Library"
	subtitle = subtitle or "Modern Design"
	theme = theme or "black"
	home = home ~= nil and home or true
	
	self.ScreenGui = Instance.new("ScreenGui")
	self.ScreenGui.Name = "ModernGUILibrary"
	self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	self.ScreenGui.ResetOnSpawn = false
	
	if syn and syn.protect_gui then
		syn.protect_gui(self.ScreenGui)
		self.ScreenGui.Parent = CoreGui
	elseif gethui then
		self.ScreenGui.Parent = gethui()
	else
		self.ScreenGui.Parent = CoreGui
	end
	
	local loader = CreateLoader(self.ScreenGui)
	
	task.spawn(function()
		for i = 0, 100, 5 do
			loader.Progress(i / 100)
			task.wait(0.05)
		end
	end)
	
	self.Theme = UIModule.Themes[theme] or UIModule.Themes.black
	self.CurrentTheme = theme
	
	self.MainFrame = Instance.new("Frame")
	self.MainFrame.Name = "MainFrame"
	self.MainFrame.Size = UDim2.new(0, 650, 0, 500)
	self.MainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
	self.MainFrame.BackgroundColor3 = self.Theme.Background
	self.MainFrame.BorderSizePixel = 0
	self.MainFrame.ClipsDescendants = true
	self.MainFrame.BackgroundTransparency = 1
	self.MainFrame.Parent = self.ScreenGui
	
	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 12)
	mainCorner.Parent = self.MainFrame
	
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.Size = UDim2.new(1, 40, 1, 40)
	shadow.Position = UDim2.new(0, -20, 0, -20)
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://5554236805"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 1
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	shadow.ZIndex = 0
	shadow.Parent = self.MainFrame
	
	local topBar = Instance.new("Frame")
	topBar.Name = "TopBar"
	topBar.Size = UDim2.new(1, 0, 0, 50)
	topBar.BackgroundColor3 = self.Theme.TopBar
	topBar.BorderSizePixel = 0
	topBar.BackgroundTransparency = 1
	topBar.Parent = self.MainFrame
	
	local topCorner = Instance.new("UICorner")
	topCorner.CornerRadius = UDim.new(0, 12)
	topCorner.Parent = topBar
	
	local topBarFix = Instance.new("Frame")
	topBarFix.Size = UDim2.new(1, 0, 0, 12)
	topBarFix.Position = UDim2.new(0, 0, 1, -12)
	topBarFix.BackgroundColor3 = self.Theme.TopBar
	topBarFix.BorderSizePixel = 0
	topBarFix.BackgroundTransparency = 1
	topBarFix.Parent = topBar
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, -60, 0, 25)
	titleLabel.Position = UDim2.new(0, 20, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = self.Theme.TextColor
	titleLabel.TextSize = 18
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextTransparency = 1
	titleLabel.Parent = topBar
	
	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.Name = "Subtitle"
	subtitleLabel.Size = UDim2.new(1, -60, 0, 15)
	subtitleLabel.Position = UDim2.new(0, 20, 0, 30)
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Text = subtitle
	subtitleLabel.TextColor3 = self.Theme.SubTextColor
	subtitleLabel.TextSize = 12
	subtitleLabel.Font = Enum.Font.Gotham
	subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	subtitleLabel.TextTransparency = 1
	subtitleLabel.Parent = topBar
	
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseButton"
	closeBtn.Size = UDim2.new(0, 30, 0, 30)
	closeBtn.Position = UDim2.new(1, -40, 0, 10)
	closeBtn.BackgroundColor3 = self.Theme.ElementBackground
	closeBtn.BorderSizePixel = 0
	closeBtn.Text = "×"
	closeBtn.TextColor3 = self.Theme.TextColor
	closeBtn.TextSize = 20
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.BackgroundTransparency = 1
	closeBtn.TextTransparency = 1
	closeBtn.Parent = topBar
	
	local closeBtnCorner = Instance.new("UICorner")
	closeBtnCorner.CornerRadius = UDim.new(0, 8)
	closeBtnCorner.Parent = closeBtn
	
	closeBtn.MouseButton1Click:Connect(function()
		self:Toggle()
	end)
	
	closeBtn.MouseEnter:Connect(function()
		TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = self.Theme.AccentColor}):Play()
	end)
	
	closeBtn.MouseLeave:Connect(function()
		TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = self.Theme.ElementBackground}):Play()
	end)
	
	self.TabContainer = Instance.new("Frame")
	self.TabContainer.Name = "TabContainer"
	self.TabContainer.Size = UDim2.new(0, 180, 1, -60)
	self.TabContainer.Position = UDim2.new(0, 10, 0, 60)
	self.TabContainer.BackgroundTransparency = 1
	self.TabContainer.Parent = self.MainFrame
	
	local tabList = Instance.new("ScrollingFrame")
	tabList.Name = "TabList"
	tabList.Size = UDim2.new(1, 0, 1, 0)
	tabList.BackgroundTransparency = 1
	tabList.BorderSizePixel = 0
	tabList.ScrollBarThickness = 4
	tabList.ScrollBarImageColor3 = self.Theme.AccentColor
	tabList.ScrollBarImageTransparency = 1
	tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabList.Parent = self.TabContainer
	
	local tabListLayout = Instance.new("UIListLayout")
	tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabListLayout.Padding = UDim.new(0, 8)
	tabListLayout.Parent = tabList
	
	tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tabList.CanvasSize = UDim2.new(0, 0, 0, tabListLayout.AbsoluteContentSize.Y + 10)
	end)
	
	self.ContentContainer = Instance.new("Frame")
	self.ContentContainer.Name = "ContentContainer"
	self.ContentContainer.Size = UDim2.new(1, -210, 1, -60)
	self.ContentContainer.Position = UDim2.new(0, 200, 0, 60)
	self.ContentContainer.BackgroundTransparency = 1
	self.ContentContainer.Parent = self.MainFrame
	
	self.Tabs = {}
	self.CurrentTab = nil
	self.TitleLabel = titleLabel
	self.SubtitleLabel = subtitleLabel
	self.TabList = tabList
	self.Visible = false
	
	self:MakeDraggable(self.MainFrame, topBar)
	self:ScaleUI()
	
	task.delay(1, function()
		loader.Finish()
		self:Show()
	end)
	
	return self
end

function Library:Show()
	self.Visible = true
	TweenService:Create(self.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(self.MainFrame:FindFirstChild("Shadow"), TweenInfo.new(0.4), {ImageTransparency = 0.7}):Play()
	TweenService:Create(self.MainFrame:FindFirstChild("TopBar"), TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
	TweenService:Create(self.MainFrame.TopBar:FindFirstChildOfClass("Frame"), TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
	TweenService:Create(self.TitleLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
	TweenService:Create(self.SubtitleLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
	TweenService:Create(self.MainFrame.TopBar.CloseButton, TweenInfo.new(0.4), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
	TweenService:Create(self.TabList, TweenInfo.new(0.4), {ScrollBarImageTransparency = 0.5}):Play()
	
	for _, tab in pairs(self.Tabs) do
		TweenService:Create(tab.Button, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
		TweenService:Create(tab.Button.Icon, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()
		TweenService:Create(tab.Button.Title, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
	end
end

function Library:Hide()
	self.Visible = false
	TweenService:Create(self.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(self.MainFrame:FindFirstChild("Shadow"), TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
	TweenService:Create(self.MainFrame:FindFirstChild("TopBar"), TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	TweenService:Create(self.MainFrame.TopBar:FindFirstChildOfClass("Frame"), TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	TweenService:Create(self.TitleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(self.SubtitleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(self.MainFrame.TopBar.CloseButton, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
	TweenService:Create(self.TabList, TweenInfo.new(0.4), {ScrollBarImageTransparency = 1}):Play()
	
	for _, tab in pairs(self.Tabs) do
		TweenService:Create(tab.Button, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		TweenService:Create(tab.Button.Icon, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
		TweenService:Create(tab.Button.Title, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	end
end

function Library:Toggle()
	if self.Visible then
		self:Hide()
	else
		self:Show()
	end
end

function Library:Tab(title, icon, index)
	local Tab = {}
	
	local tabButton = Instance.new("TextButton")
	tabButton.Name = "Tab_" .. title
	tabButton.Size = UDim2.new(1, -10, 0, 40)
	tabButton.BackgroundColor3 = self.Theme.ElementBackground
	tabButton.BorderSizePixel = 0
	tabButton.Text = ""
	tabButton.LayoutOrder = index or #self.Tabs + 1
	tabButton.BackgroundTransparency = self.Visible and 0 or 1
	tabButton.Parent = self.TabList
	
	local tabCorner = Instance.new("UICorner")
	tabCorner.CornerRadius = UDim.new(0, 8)
	tabCorner.Parent = tabButton
	
	local tabIcon = Instance.new("ImageLabel")
	tabIcon.Name = "Icon"
	tabIcon.Size = UDim2.new(0, 20, 0, 20)
	tabIcon.Position = UDim2.new(0, 12, 0.5, -10)
	tabIcon.BackgroundTransparency = 1
	tabIcon.ImageColor3 = self.Theme.TextColor
	tabIcon.Image = IconsModule.GetIcon(icon or "home")
	tabIcon.ImageTransparency = self.Visible and 0 or 1
	tabIcon.Parent = tabButton
	
	local tabTitle = Instance.new("TextLabel")
	tabTitle.Name = "Title"
	tabTitle.Size = UDim2.new(1, -50, 1, 0)
	tabTitle.Position = UDim2.new(0, 40, 0, 0)
	tabTitle.BackgroundTransparency = 1
	tabTitle.Text = title
	tabTitle.TextColor3 = self.Theme.TextColor
	tabTitle.TextSize = 14
	tabTitle.Font = Enum.Font.GothamMedium
	tabTitle.TextXAlignment = Enum.TextXAlignment.Left
	tabTitle.TextTransparency = self.Visible and 0 or 1
	tabTitle.Parent = tabButton
	
	local contentFrame = Instance.new("ScrollingFrame")
	contentFrame.Name = "Content_" .. title
	contentFrame.Size = UDim2.new(1, 0, 1, 0)
	contentFrame.BackgroundTransparency = 1
	contentFrame.BorderSizePixel = 0
	contentFrame.ScrollBarThickness = 4
	contentFrame.ScrollBarImageColor3 = self.Theme.AccentColor
	contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	contentFrame.Visible = false
	contentFrame.Parent = self.ContentContainer
	
	local contentLayout = Instance.new("UIListLayout")
	contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	contentLayout.Padding = UDim.new(0, 10)
	contentLayout.Parent = contentFrame
	
	contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
	end)
	
	Tab.Button = tabButton
	Tab.Content = contentFrame
	Tab.Sections = {}
	
	tabButton.MouseButton1Click:Connect(function()
		for _, t in pairs(self.Tabs) do
			t.Content.Visible = false
			TweenService:Create(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = self.Theme.ElementBackground}):Play()
		end
		
		contentFrame.Visible = true
		TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = self.Theme.AccentColor}):Play()
		self.CurrentTab = Tab
	end)
	
	tabButton.MouseEnter:Connect(function()
		if self.CurrentTab ~= Tab then
			TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
				self.Theme.ElementBackground.R * 255 + 10,
				self.Theme.ElementBackground.G * 255 + 10,
				self.Theme.ElementBackground.B * 255 + 10
			)}):Play()
		end
	end)
	
	tabButton.MouseLeave:Connect(function()
		if self.CurrentTab ~= Tab then
			TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = self.Theme.ElementBackground}):Play()
		end
	end)
	
	table.insert(self.Tabs, Tab)
	
	if #self.Tabs == 1 then
		tabButton.MouseButton1Click:Fire()
	end
	
	function Tab:Section(title, type, index)
		local Section = {}
		
		local sectionFrame = Instance.new("Frame")
		sectionFrame.Name = "Section_" .. title
		sectionFrame.BackgroundColor3 = self.Theme.ElementBackground
		sectionFrame.BorderSizePixel = 0
		sectionFrame.LayoutOrder = index or #self.Sections + 1
		sectionFrame.Parent = contentFrame
		
		local sectionCorner = Instance.new("UICorner")
		sectionCorner.CornerRadius = UDim.new(0, type == "cube" and 12 or 8)
		sectionCorner.Parent = sectionFrame
		
		local sectionBorder = Instance.new("UIStroke")
		sectionBorder.Color = self.Theme.SectionBorder
		sectionBorder.Thickness = 1
		sectionBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		sectionBorder.Parent = sectionFrame
		
		local sectionHeader = Instance.new("TextButton")
		sectionHeader.Name = "Header"
		sectionHeader.Size = UDim2.new(1, 0, 0, 40)
		sectionHeader.BackgroundTransparency = 1
		sectionHeader.Text = ""
		sectionHeader.Parent = sectionFrame
		
		local sectionTitle = Instance.new("TextLabel")
		sectionTitle.Size = UDim2.new(1, -50, 1, 0)
		sectionTitle.Position = UDim2.new(0, 15, 0, 0)
		sectionTitle.BackgroundTransparency = 1
		sectionTitle.Text = title
		sectionTitle.TextColor3 = self.Theme.TextColor
		sectionTitle.TextSize = 15
		sectionTitle.Font = Enum.Font.GothamBold
		sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
		sectionTitle.Parent = sectionHeader
		
		local toggleIcon = Instance.new("TextLabel")
		toggleIcon.Size = UDim2.new(0, 20, 0, 20)
		toggleIcon.Position = UDim2.new(1, -35, 0.5, -10)
		toggleIcon.BackgroundTransparency = 1
		toggleIcon.Text = "▼"
		toggleIcon.TextColor3 = self.Theme.SubTextColor
		toggleIcon.TextSize = 12
		toggleIcon.Font = Enum.Font.GothamBold
		toggleIcon.Parent = sectionHeader
		
		local contentContainer = Instance.new("Frame")
		contentContainer.Name = "Content"
		contentContainer.Size = UDim2.new(1, 0, 1, -40)
		contentContainer.Position = UDim2.new(0, 0, 0, 40)
		contentContainer.BackgroundTransparency = 1
		contentContainer.ClipsDescendants = true
		contentContainer.Parent = sectionFrame
		
		local contentList = Instance.new("UIListLayout")
		contentList.SortOrder = Enum.SortOrder.LayoutOrder
		contentList.Padding = UDim.new(0, 8)
		contentList.Parent = contentContainer
		
		local contentPadding = Instance.new("UIPadding")
		contentPadding.PaddingTop = UDim.new(0, 10)
		contentPadding.PaddingBottom = UDim.new(0, 10)
		contentPadding.Parent = contentContainer
		
		Section.Container = contentContainer
		Section.Expanded = true
		
		local function updateSize()
			if Section.Expanded then
				sectionFrame.Size = UDim2.new(1, -20, 0, contentList.AbsoluteContentSize.Y + 60)
			else
				sectionFrame.Size = UDim2.new(1, -20, 0, 40)
			end
		end
		
		contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
		
		sectionHeader.MouseButton1Click:Connect(function()
			Section.Expanded = not Section.Expanded
			
			if Section.Expanded then
				TweenService:Create(toggleIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
				TweenService:Create(sectionFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
					Size = UDim2.new(1, -20, 0, contentList.AbsoluteContentSize.Y + 60)
				}):Play()
			else
				TweenService:Create(toggleIcon, TweenInfo.new(0.2), {Rotation = -90}):Play()
				TweenService:Create(sectionFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
					Size = UDim2.new(1, -20, 0, 40)
				}):Play()
			end
		end)
		
		updateSize()
		
		function Section:Button(title, desc, icon, callback)
			return WidgetsModule:Button(contentContainer, self.Theme, title, desc, icon, callback)
		end
		
		function Section:Toggle(title, callback)
			return WidgetsModule:Toggle(contentContainer, self.Theme, title, callback)
		end
		
		function Section:Input(title, placeholder, callback)
			return WidgetsModule:Input(contentContainer, self.Theme, title, placeholder, callback)
		end
		
		function Section:Paragraph(title, subtext, index)
			return WidgetsModule:Paragraph(contentContainer, self.Theme, title, subtext, index)
		end
		
		function Section:Invite(text, desc, link)
			return WidgetsModule:Invite(contentContainer, self.Theme, text, desc, link)
		end
		
		function Section:Slider(title, min, max, callback)
			return WidgetsModule:Slider(contentContainer, self.Theme, title, min, max, callback)
		end
		
		table.insert(self.Sections, Section)
		return Section
	end
	
	return Tab
end

function Library:Notification(text, desc, dur)
	dur = dur or 3
	
	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(0, 300, 0, 80)
	notif.Position = UDim2.new(1, -320, 1, 100)
	notif.BackgroundColor3 = self.Theme.ElementBackground
	notif.BorderSizePixel = 0
	notif.Parent = self.ScreenGui
	
	local notifCorner = Instance.new("UICorner")
	notifCorner.CornerRadius = UDim.new(0, 10)
	notifCorner.Parent = notif
	
	local notifTitle = Instance.new("TextLabel")
	notifTitle.Size = UDim2.new(1, -20, 0, 25)
	notifTitle.Position = UDim2.new(0, 15, 0, 10)
	notifTitle.BackgroundTransparency = 1
	notifTitle.Text = text
	notifTitle.TextColor3 = self.Theme.TextColor
	notifTitle.TextSize = 14
	notifTitle.Font = Enum.Font.GothamBold
	notifTitle.TextXAlignment = Enum.TextXAlignment.Left
	notifTitle.Parent = notif
	
	local notifDesc = Instance.new("TextLabel")
	notifDesc.Size = UDim2.new(1, -20, 0, 35)
	notifDesc.Position = UDim2.new(0, 15, 0, 35)
	notifDesc.BackgroundTransparency = 1
	notifDesc.Text = desc
	notifDesc.TextColor3 = self.Theme.SubTextColor
	notifDesc.TextSize = 12
	notifDesc.Font = Enum.Font.Gotham
	notifDesc.TextXAlignment = Enum.TextXAlignment.Left
	notifDesc.TextWrapped = true
	notifDesc.Parent = notif
	
	TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -320, 1, -100)}):Play()
	
	task.delay(dur, function()
		TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -320, 1, 100)}):Play()
		task.wait(0.6)
		notif:Destroy()
	end)
end

function Library:MakeDraggable(frame, dragHandle)
	local dragging = false
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		TweenService:Create(frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		}):Play()
	end
	
	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function Library:ScaleUI()
	local camera = workspace.CurrentCamera
	local viewport = camera.ViewportSize
	
	local scaleConstraint = Instance.new("UIScale")
	scaleConstraint.Parent = self.MainFrame
	
	local function updateScale()
		local vpSize = camera.ViewportSize
		local scale = math.min(vpSize.X / 1920, vpSize.Y / 1080)
		scaleConstraint.Scale = math.clamp(scale, 0.5, 1)
	end
	
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
	updateScale()
end

return Library
