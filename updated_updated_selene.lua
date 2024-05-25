--[[
	@@ Selene 
	
	~ Reflinders	
]]

local Selene = {
	Version = "P.2.0";
	Binds = {}
}

--[[
	PROTOTYPES ARE UNSAFE!
]]

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweeningService = game:GetService("TweenService")

do
	local NO_STYLE

	function tween(obj, properties, style)
		return TweeningService:Create(obj, style or NO_STYLE, properties)
	end

	easing = TweenInfo.new
	NO_STYLE = easing(1, Enum.EasingStyle.Cubic)
end

local QUICK_STYLE = easing(.45, Enum.EasingStyle.Quint)
local MID_STYLE = easing(.55, Enum.EasingStyle.Quad)

local ON_STUDIO = RunService:IsStudio()

local client = game:GetService("Players").LocalPlayer

--  [[ -------------------------------------------------]]
-- [[ ---------------------------------------------------]]
--  [[ -------------------------------------------------]]

--  [[ -------------------------------------------------]]
-- [[ ---------------------------------------------------]]
--  [[ -------------------------------------------------]]

--@ Modules & Functions

do
	import = require(ON_STUDIO and (script.import) 
		or [[https://raw.githubusercontent.com/Reflinders/Selene/main/code/import.lua]])
	
	_G["$import"] = import 
	_G["$tween"] = tween 
	
	RAW = import "RAW"
	Theme = import "Theme"
	State = import "State"
	Slnobj = import "Slnobj"
	str_to_size = import "str_to_size"	
	
	New, Children = RAW.New, RAW.Children
	
	--   [[ -------------- ]]
		--  [[ ---------------- ]]
		--   [[ -------------- ]]

		function play_intro(src)
			local gui = RAW.intro()

			gui.Parent = src
			gui.Cover.Img.Position = UDim2.fromScale(.5, 1.8)

			task.wait(1.5)

			tween(gui.Cover.Img, { Position = UDim2.fromScale(.5, .5) }):Play()

			task.wait(2)

			tween(gui, { BackgroundTransparency = 1 } ):Play()
			tween(gui.Cover, { BackgroundTransparency = 1 } ):Play()
			tween(gui.Cover.Img, { ImageTransparency = 1 } ):Play()

			task.wait(1)

			gui:Destroy()
		end
end

local size_for_elements

--  [[ -------------------------------------------------]]
-- [[ ---------------------------------------------------]]
--  [[ -------------------------------------------------]]

--  [[ -------------------------------------------------]]
-- [[ ---------------------------------------------------]]
--  [[ -------------------------------------------------]]

--@ Slnobj Classes

local Tab = {}
do
	Tab.__index = Tab

	function Tab:_objMount(obj)
		local gui = type(obj) == "table" and obj.Gui or obj

		table.insert(self.Props, obj)

		if Selene.Spotlight ~= self then
			gui.Parent = Selene.Outside
		else
			gui.Parent = Selene.Gui.List
		end
	end

	function Tab:Pop()
		local items = Selene.Gui.List

		for _, obj in pairs(self.Props) do
			local gui = type(obj) == "table" and obj.Gui or obj

			gui.Parent = Selene.Outside
		end

		tween(self.Gui.Label, { TextTransparency = .5 }, QUICK_STYLE):Play()
		tween(self.Gui.Img, { ImageTransparency = .5 }, QUICK_STYLE):Play()
	end

	function Tab:Push()
		if Selene.Spotlight == self then
			return
		end

		local list = Selene.Gui.List
		list.CanvasSize = size_for_elements(self.Props)

		if Selene.Spotlight then
			Selene.Spotlight:Pop()
		end

		for _, obj in pairs(self.Props) do
			if type(obj) == "table" then
				obj.Gui.Parent = list

				continue
			end

			obj.Parent = list
		end

		Selene.Spotlight = self

		tween(self.Gui.Label, { TextTransparency = .2 }, QUICK_STYLE):Play()
		tween(self.Gui.Img, { ImageTransparency = .2 }, QUICK_STYLE):Play()
	end

	function Tab.new(parent, args)
		local self = {
			Title = args.Title,
			Gui = RAW.tab(args.Title, args.Icon);

			Props = {}
		}

		do
			local gui = self.Gui
			local modal = RAW.modal(gui)

			local divider = RAW.divider(Selene.Ref, nil, self.Title, true)
			table.insert(self.Props, divider)

			modal.MouseButton1Click:Connect(function()
				self:Push()
			end)
		end

		return setmetatable(self, Tab)
	end
end;

local Divider = {}
do
	function Divider.new(parent, title)
		return {
			Parent = parent,
			Gui = RAW.divider(Selene.Ref, nil, title)
		}
	end
end;

local Macro = Slnobj.impl()
do
	function Macro:Hook(fn)
		self._hook = fn
	end

	function Macro.new(parent, args)
		--[[
			Args
			@ Title
			@ Caption?
			@ Hook
		]]

		local self = setmetatable({}, Macro)

		self.Parent = parent
		self.Gui = RAW.macro(args.Title, args.Caption)

		do
			self:_init(args)

			local button = RAW.topm(self.Gui, self.Gui.Img, 3, 3)

			button.MouseButton1Down:Connect(function()
				if self._hook then
					self._hook()
				end

				tween(self.Gui, { 
					BackgroundTransparency = .45
				}, easing(.35, Enum.EasingStyle.Elastic)):Play()

				task.wait(.25)

				tween(self.Gui, { 
					BackgroundTransparency = 0
				}, easing(.35, Enum.EasingStyle.Elastic)):Play()
			end)
		end


		return self
	end
end;

local Boolean = Slnobj.impl()
do
	function Boolean:Hook(fn)
		return self.State:observe(fn)
	end

	function Boolean.new(parent, args)
		local self = setmetatable({}, Boolean)

		self.Parent = parent
		self.Gui = RAW.boolean(args.Title, args.Caption)
		self.State = State.new(not args.State)

		do
			self:_init(args)

			local button = RAW.topm(self.Gui, self.Gui.Slide, 3, 3)

			button.MouseButton1Down:Connect(function(...)
				self:Set(not self:Get())
			end)

			self:Hook(function(value)
				tween(self.Gui.Slide, { 
					BackgroundColor3 = value and Color3.fromRGB(157, 171, 189) or Color3.fromRGB(189, 189, 189)
				}, MID_STYLE):Play()

				tween(self.Gui.Slide.Wheel, { 
					Position = value and UDim2.new(0, 15, .5, 0) or UDim2.new(0, -5, .5, 0)
				}, MID_STYLE):Play()
			end)

			self:Set(args.State or false)
		end

		return self
	end
end;

local Slider = Slnobj.impl()
do
	function Slider:Hook(fn)
		return self.State:observe(fn)
	end	

	function Slider.new(parent, args)
		local self = setmetatable({}, Slider)
		self.Parent = parent
		self.Gui = RAW.slider(args.Title)
		self.State = State.new(0)
		self.Range = args.Range

		do
			self:_init(args)

			local gui = self.Gui
			local input = gui.Int
			local progress = gui.Whole.Progress
			local wheel = gui.Whole.Wheel

			self:Hook(function(value)
				value = math.round(value)

				local min, max = self.Range[1], self.Range[2]
				local portion = (value - min) / (max - min)

				tween(wheel, { 
					Rotation = math.round(360 * portion),
					Position = UDim2.fromScale(math.clamp(portion-.05, -.01, 1), .5)
				}, QUICK_STYLE):Play()

				tween(progress, { Size = UDim2.fromScale(portion, 1) }, QUICK_STYLE):Play()

				input.Text = value
			end)

			input.FocusLost:Connect(function()
				local num = tonumber(input.Text)

				self:Set(num or self.Range[1])
			end)

			self:Set(args.State or args.Range[1])

			self._temp = {}

			table.insert(self._temp, UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
					return
				end

				local mouse = client:GetMouse()
				local guis = client.PlayerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)

				if table.find(guis, self.Gui) then
					self._active = true

					task.spawn(function()
						while self.Gui.Parent ~= nil and self._active do
							task.wait()

							local pos = UserInputService:GetMouseLocation()
							local relative = (pos -  gui.Whole.AbsolutePosition)

							local portion = math.clamp(relative.X / gui.Whole.AbsoluteSize.X, 0, 1)

							local min, max = self.Range[1], self.Range[2]

							self:Set(min + (portion * (max - min)))
						end	
					end)
				end
			end))

			table.insert(self._temp, UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
					return
				end

				self._active = false
			end))
		end

		return self
	end
end;

local Dropdown = Slnobj.impl()
do
	local PER_OPTION = 64

	function Dropdown:Hook(fn)
		return self.State:observe(fn)
	end	

	function Dropdown:Add(obj)
		local literal = self.List.core

		table.insert(literal, obj)

		self.List:set(literal, nil, true)
	end

	function Dropdown:Remove(obj)
		local literal = self.List.core

		table.remove(literal, table.find(literal, obj))

		self.List:set(literal, nil, true)
	end

	function Dropdown:Load()
		if self._toggled then
			self:Toggle()
		end

		local buttons = self.Buttons
		local list = self.List:get()

		for i, choice in ipairs(buttons) do
			choice:Destroy(); buttons[i] = nil
		end

		for _, val in ipairs(list) do
			local choice = RAW.option(self.Gui.Options, val)
			local modal = RAW.modal(choice)

			modal.MouseButton1Click:Connect(function()
				if not self._toggled then
					return
				end

				self:Toggle(false)
				self:Set(val)
			end)

			modal.MouseEnter:Connect(function()
				tween(choice, { BackgroundTransparency = .8 }, MID_STYLE):Play()	
			end)

			modal.MouseLeave:Connect(function()
				tween(choice, { BackgroundTransparency = 1 }, MID_STYLE):Play()	
			end)

			table.insert(buttons, choice)
		end
	end

	function Dropdown:Toggle(active)
		if not active then
			active = not self._toggled
		end

		local gui = self.Gui
		local options = gui.Options
		local init_size = self._init_size

		local amt_options = #self.List:get()

		local extension = (PER_OPTION * (active and amt_options or 0))

		tween(gui, { 
			Size = UDim2.fromOffset(init_size.X.Offset, 
				init_size.Y.Offset + extension + (active and 18 or 0)) 
		}, QUICK_STYLE):Play()

		tween(options, {
			Size = UDim2.fromOffset(384, extension)
		}, QUICK_STYLE):Play()

		self._toggled = active
	end

	function Dropdown.new(parent, args)
		local self = setmetatable({}, Dropdown)
		self.Parent = parent
		self.Gui = RAW.dropdown(args.Title)
		self.State = State.new(args.State or args.Range[1])

		self.List = State.new( args.Range )
		self.Buttons = {}

		do
			self:_init(args)

			local selection = self.Gui.Selection

			self:Toggle(false)
			self:Load()

			self.List:observe(function()
				self:Load()
			end)

			self:Hook(function(val)
				selection.Text = tostring(val)
			end)

			self:Set(args.State or args.Range[1], nil, true)

			self._modal.Size = self._init_size
			self._modal.MouseButton1Down:Connect(function()
				self:Toggle()
			end)
		end

		return self
	end
end;

local Embed = Slnobj.impl()
do
	function Embed.new(parent, args)
		local self = setmetatable({}, Embed)
		self.Parent = parent
		self.Gui = RAW.embed(args.Title, args.Caption)

		self:_init(args)

		return self
	end
end;

function size_for_elements(elements)
	local y_across = 0

	for _, obj in pairs(elements) do
		local u = type(obj) == "table" and obj.Gui or obj
		local list = type(obj) == "table" and obj.List

		local extlen = (list and #list:get() * 64 or 0)

		y_across += (u.Size.Y.Offset * 2) + extlen
	end

	return UDim2.fromOffset(0, y_across)
end

--  [[ -------------------------------------------------]]
-- [[ ---------------------------------------------------]]
--  [[ -------------------------------------------------]]

--  [[ -------------------------------------------------]]
-- [[ ---------------------------------------------------]]
--  [[ -------------------------------------------------]]

function Selene:_objMount(tab)
	tab.Gui.Parent = self.Gui.Navi.List
	self.Tabs[tab.Title] = tab

	if not self.Spotlight then
		tab:Push()
	end
end

function Selene:Toggle(on)
	if self._toggled == on then
		return
	end

	local size_mult = on and 1 or .98
	local style = easing(.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

	if on then
		self.Gui.Visible = true	
		self._toggled = on
	else
		task.delay(style.Time, function()
			self.Gui.Visible = false

			self._toggled = on
		end)
	end

	tween(self.Gui, {
		GroupTransparency = on and 0 or 1,
		Size = UDim2.fromOffset(660 * size_mult, 511 * size_mult)
	}, style):Play()
end

function Selene:Mount(constructor, ...)
	if not self._objMount then
		error()
	end

	local new = constructor(self, ...)

	self:_objMount(new)

	return new
end

function Selene:Bind(keybind, fn)
	self.Binds[keybind] = fn
end

function Selene:Create(SETTINGS)
	assert(not self.Gui, "Attempt to create more than one instance of Selene...")
	print("! Selene Initialized :: On vers. " .. self.Version)

	self.Ref = SETTINGS.Ref
	self.Tabs = {}

	self.Gui = RAW.src_Gui(SETTINGS)
	self.Outside = New "Frame" {
		Name = "Outside",
		Parent = self.Gui.Parent,
		Visible = false
	}

	if SETTINGS.Theme then
		Theme.apply(SETTINGS.Theme, self.Gui)
	end

	do
		local gui = self.Gui

		UserInputService.InputBegan:Connect(function(input)
			local code = input.KeyCode
			local bind =  self.Binds[code]

			return bind and bind()
		end)

		self:Bind(Enum.KeyCode.LeftAlt, function()
			self:Toggle(not self._toggled)
		end)

		self._toggled = true

		--@ dragging
		do
			local dragging
			local dragInput
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart
				gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end

			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = gui.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
		end
	end

	task.defer(play_intro, self.Gui)
end	

function Selene.Hook(obj, ...)
	return obj:Hook(...)	
end

Selene.Tab = Tab.new
Selene.Boolean = Boolean.new
Selene.Divider = Divider.new
Selene.Macro = Macro.new
Selene.Slider = Slider.new
Selene.Dropdown = Dropdown.new
Selene.Embed = Embed.new

Selene.Theme = Theme
Selene.State = State.new

return Selene
