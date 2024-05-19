--[[
	@@ Selene 
	
	~ Reflinders	
]]

local Selene = {
	Version = "P.1.1";
	Binds = {}
}

--[[
	PROTOTYPES ARE UNSAFE!
]]

--  <- [[ --------------------- ]] ->
-- <- [[ ----------------------- ]] ->
--  <- [[ --------------------- ]] ->

local UserInputService = game:GetService("UserInputService")

local CONFIG = {
	Studio = true
}

local ENUM_NOTIF = {
	Info = {
		Color = Color3.fromRGB(107, 186, 255),
		Stroke = Color3.fromRGB(26, 46, 62),
		Image = Color3.fromRGB(115, 155, 171),

		Icon = "http://www.roblox.com/asset/?id=17450549882"	
	};

	Error = {
		Color = Color3.fromRGB(255, 97, 97),
		Stroke = Color3.fromRGB(252, 0, 0),
		Image = Color3.fromRGB(217, 140, 140),

		Icon = "http://www.roblox.com/asset/?id=17450469216"
	};
}

local NO_STYLE = TweenInfo.new(1, Enum.EasingStyle.Cubic)
local QUICK_STYLE = TweenInfo.new(.45, Enum.EasingStyle.Quint)

local CLIENT = game:GetService("Players").LocalPlayer

local Children = newproxy()

--[[
	@
]]

do
	local TweeningService = game:GetService("TweenService")

	function New(class)
		return function(attr)
			attr = attr or {}

			local obj = Instance.new(class)

			local children = attr[Children]

			if children then
				for _, sub in ipairs(children) do
					sub.Parent = obj
				end

				attr[Children] = nil
			end

			for k, v in pairs(attr) do
				obj[k] = v
			end

			return obj
		end
	end

	function cleanup(tbl)

	end

	function tween(obj, properties, style)
		return TweeningService:Create(obj, style or NO_STYLE, properties)
	end
	
	function intro(src)
		local intro = New "Frame" {
			Name = "intro",
			BackgroundColor3 = Color3.fromRGB(206, 229, 239),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 3,

			[Children] = {
				New "UICorner" {
					Name = "Corner",
				},

				New "UIGradient" {
					Name = "Gradient",
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(141, 151, 154)),
					}),
					Offset = Vector2.new(0, 0.5),
					Rotation = 90,
				},

				New "Frame" {
					Name = "Cover",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromOffset(194, 97),
					Size = UDim2.fromOffset(188, 216),
					ZIndex = 3,
					ClipsDescendants = true,

					[Children] = {
						New "ImageLabel" {
							Name = "Img",
							Image = "http://www.roblox.com/asset/?id=17441215440",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.5, 1.5),
							Size = UDim2.fromOffset(105, 181),
							ZIndex = 3,
						},
					}
				},
			}
		}

		intro.Parent = 	src

		task.wait(1.5)

		tween(intro.Cover.Img, { Position = UDim2.fromScale(.5, .5) }):Play()

		task.wait(2)

		tween(intro, { BackgroundTransparency = 1 } ):Play()
		tween(intro.Cover, { BackgroundTransparency = 1 } ):Play()
		tween(intro.Cover.Img, { ImageTransparency = 1 } ):Play()

		task.wait(1)

		intro:Destroy()
	end
	
	easing = TweenInfo.new
end

local RAW = {}
do
	function RAW.boolean(title)
		return New "Frame" {
			Name = "Boolean",
			BackgroundColor3 = Color3.fromRGB(203, 203, 203),
			BackgroundTransparency = 0.85,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.226, 0.229),
			Size = UDim2.fromOffset(444, 37),

			[Children] = {
				New "TextLabel" {
					Name = "Title",
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = title,
					TextColor3 = Color3.fromRGB(68, 68, 68),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0251, 0),
					Size = UDim2.new(0.227, 187, 1, 0),
				},

				New "Frame" {
					Name = "Toggle",
					Active = true,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(92, 114, 122),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.878, 0.5),
					Size = UDim2.fromOffset(38, 3),

					[Children] = {
						New "ImageLabel" {
							Name = "Wheel",
							Image = "http://www.roblox.com/asset/?id=17441312604",
							ImageColor3 = Color3.fromRGB(7, 0, 77),
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(104, 150, 89),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 20, 0.5, 0),
							Size = UDim2.fromOffset(24, 24),
							ZIndex = 2,
						},

						New "Frame" {
							Name = "Progress",
							BackgroundColor3 = Color3.fromRGB(76, 109, 255),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.fromScale(1, 1),
						},
					}
				},

				New "UICorner" {
					Name = "Corner",
					CornerRadius = UDim.new(0, 4),
				},

				New "UIStroke" {
					Name = "Stroke",
					Thickness = 0.8,
					Transparency = 0.66,
				},
			}
		}
	end

	function RAW.macro(text)
		return New "Frame" {
			Name = "Macro",
			BackgroundColor3 = Color3.fromRGB(203, 203, 203),
			BackgroundTransparency = 0.85,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.226, 0.229),
			Size = UDim2.fromOffset(444, 37),

			[Children] = {
				New "UICorner" {
					Name = "UICorner",
					CornerRadius = UDim.new(0, 4),
				},

				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(55, 79, 78),
					Thickness = 0.8,
					Transparency = 0.66,
				},

				New "TextLabel" {
					Name = "Title",
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = text,
					TextColor3 = Color3.fromRGB(112, 161, 159),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0251, 0),
					Size = UDim2.new(0, 187, 1, 0),
				},

				New "TextLabel" {
					Name = "Indicator",
					FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = "!",
					TextColor3 = Color3.fromRGB(112, 161, 159),
					TextSize = 26,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.922, 0.515),
					Size = UDim2.fromOffset(33, 35),
				},
			}
		}
	end

	function RAW.src_gui(SETTINGS)
		local holder = New "ScreenGui" {
			Name = "Selene",
			DisplayOrder = math.huge,
			IgnoreGuiInset = true,
			ResetOnSpawn = false,
			ZIndexBehavior = "Sibling"
		}

		holder.Parent = CONFIG.Studio and CLIENT.PlayerGui or game:GetService("CoreGui")

		local src = New "CanvasGroup" {
			Name = "Src",
			Active = true,
			BackgroundColor3 = Color3.fromRGB(213, 217, 223),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.352, 0.381),
			Size = UDim2.fromOffset(587, 412),
			AnchorPoint = Vector2.new(.5, .5),
			
			[Children] = {
				New "Frame" {
					Name = "Buttons",
					BackgroundColor3 = Color3.fromRGB(236, 241, 248),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1.04e-07, 0),
					Size = UDim2.fromOffset(587, 42),
					ZIndex = 2,

					[Children] = {
						New "ImageLabel" {
							Name = "Close",
							Image = "http://www.roblox.com/asset/?id=17441312604",
							ImageColor3 = Color3.fromRGB(206, 71, 96),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.952, 0.286),
							Size = UDim2.fromOffset(18, 18),
						},
					}
				},

				New "Frame" {
					Name = "Side",
					BackgroundColor3 = Color3.fromRGB(170, 202, 212),
					BackgroundTransparency = 0.7,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 0.102),
					Size = UDim2.fromOffset(119, 370),

					[Children] = {
						New "UIStroke" {
							Name = "Stroke",
							Color = Color3.fromRGB(161, 161, 161),
						},

						New "Frame" {
							Name = "List",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.0756, 0.027),
							Size = UDim2.fromScale(0.924, 0.973);

							[Children] = {
								New "UIListLayout" {
									Name = "Layout",
									SortOrder = Enum.SortOrder.LayoutOrder,
								}
							}
						},
					}
				},

				New "Frame" {
					Name = "Top",
					Active = true,
					BackgroundColor3 = Color3.fromRGB(247, 251, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1.04e-07, 0),
					Size = UDim2.fromOffset(587, 42),

					[Children] = {
						New "TextLabel" {
							Name = "Title",
							FontFace = Font.new(
								"rbxasset://fonts/families/Roboto.json",
								Enum.FontWeight.Light,
								Enum.FontStyle.Normal
							),
							Text = ":Selene\\" .. SETTINGS.Name .. "\\",
							TextColor3 = Color3.fromRGB(50, 51, 53),
							TextSize = 20,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.0311, 0),
							Size = UDim2.fromOffset(446, 42),
							ZIndex = 2,
						},

						New "UIStroke" {
							Name = "UIStroke",
							Color = Color3.fromRGB(194, 194, 194),
						},
					}
				},

				New "UICorner" {
					Name = "Corners",
				},

				New "Frame" {
					Name = "background",
					BackgroundColor3 = Color3.fromRGB(249, 249, 249),
					BackgroundTransparency = 0.2,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.fromScale(1, 1),
					ZIndex = -5,

					[Children] = {
						New "Folder" {
							Name = "Gradients",

							[Children] = {
								New "Frame" {
									Name = "frame",
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 0.9,
									BorderColor3 = Color3.fromRGB(0, 0, 0),
									BorderSizePixel = 0,
									Size = UDim2.fromScale(1, 1),
									ZIndex = -1,

									[Children] = {
										New "UIGradient" {
											Name = "UIGradient",
											Color = ColorSequence.new({
												ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
												ColorSequenceKeypoint.new(0.5, Color3.fromRGB(240, 255, 164)),
												ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
											}),
											Offset = Vector2.new(0, 0.5),
											Rotation = -163,
										},
									}
								},

								New "Frame" {
									Name = "frame",
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 0.95,
									BorderColor3 = Color3.fromRGB(0, 0, 0),
									BorderSizePixel = 0,
									Size = UDim2.fromScale(1, 1),
									ZIndex = -1,

									[Children] = {
										New "UIGradient" {
											Name = "UIGradient",
											Color = ColorSequence.new({
												ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 97)),
												ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
											}),
											Offset = Vector2.new(0, 0.2),
											Rotation = -91,
										},
									}
								},

								New "Frame" {
									Name = "frame",
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 0.6,
									BorderColor3 = Color3.fromRGB(0, 0, 0),
									BorderSizePixel = 0,
									Size = UDim2.fromScale(1, 1),
									ZIndex = -1,

									[Children] = {
										New "UIGradient" {
											Name = "UIGradient",
											Color = ColorSequence.new({
												ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 207, 237)),
												ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 255, 192)),
											}),
											Offset = Vector2.new(0, 0.5),
											Rotation = 130,
										},
									}
								},

								New "Frame" {
									Name = "frame",
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 0.45,
									BorderColor3 = Color3.fromRGB(0, 0, 0),
									BorderSizePixel = 0,
									Size = UDim2.fromScale(1, 1),
									ZIndex = -1,

									[Children] = {
										New "UIGradient" {
											Name = "UIGradient",
											Color = ColorSequence.new({
												ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
												ColorSequenceKeypoint.new(1, Color3.fromRGB(171, 235, 255)),
											}),
											Rotation = 88,
										},
									}
								},
							}
						},

						New "ImageLabel" {
							Name = "fireflies",
							Image = "http://www.roblox.com/asset/?id=17477615352",
							ImageColor3 = Color3.fromRGB(8, 132, 132),
							ImageTransparency = 0.9,
							ScaleType = Enum.ScaleType.Fit,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromScale(1.5, 1.5),
							Visible = false,
							ZIndex = 0,
						},
					}
				},

				New "ScrollingFrame" {
					Name = "Items",
					ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 3,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.203, 0.142),
					Size = UDim2.fromScale(0.796, 0.857),

					[Children] = {
						New "UIListLayout" {
							Name = "Layout",
							Padding = UDim.new(0, 10),
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
						},

						New "Frame" {
							Name = "first",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 0.999,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.fromOffset(1, 1),
						}
					}
				},
			}
		}

		src.Parent = holder
		src.Active = true

		return src
	end
	
	function RAW.tab_navi(title, icon)
		--@ returns a side-tab

		return New "Frame" {
			Name = "Tab",
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.fromRGB(233, 255, 253),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.473, 0.0267),
			Size = UDim2.fromOffset(112, 39),
			Parent = Selene.Gui.Side.List;

			[Children] = {
				New "TextLabel" {
					Name = "Label",
					FontFace = Font.new(
						"rbxassetid://12187365364",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					LineHeight = 0,
					Text = title or "Untitled",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 21,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.611, 0.485),
					Size = UDim2.fromScale(0.442, 0.727);

					[Children] = {
						New "UITextSizeConstraint" {
							Name = "TextConstraint",
							MaxTextSize = 21,
						}
					}
				},

				New "ImageLabel" {
					Name = "Img",
					Image = icon or "http://www.roblox.com/asset/?id=17477735628",
					ImageColor3 = Color3.fromRGB(0, 0, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0526, 0.472),
					Size = UDim2.fromOffset(24, 24),
				},
			}
		}
	end
	
	function RAW.modal(parent)
		return New "TextButton" {
			Name = "Modal",
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = .999,
			ZIndex = 2,
			Modal = true,
			AutoButtonColor = false,
			Parent = parent
		}	
	end	
end;	

local State = {}
do
	State.__index = State

	function State:is()
		return type(self) == "table" and getmetatable(self) == State
	end

	function State:equals(v)
		return self:get() == v	
	end

	function State:observe(fn)
		local observers = self.observers

		local n = #observers + 1
		observers[n] = fn

		return function()
			if observers[n] == fn then
				table.remove(n)
			end
		end
	end

	function State:plot(fn)
		self._plot = fn

		return self
	end

	function State:set(new, ignorePlot, ignoreWarn)
		if typeof(new) ~= self.of then
			error("Selene : Cannot change State type!")
		end

		if not ignoreWarn and new == self.core then
			return
		end

		local plotter = not ignorePlot and self._plot

		if plotter then
			return self:set(plotter(new), true)
		end

		self.core = new

		for _, observer in ipairs(self.observers) do
			task.spawn(observer, new)
		end

		return new
	end

	function State:get()
		return self.core
	end

	function State.new(literal)
		local self = setmetatable({
			core = literal;
			of = type(literal);
			observers = { };
		}, State)

		if State.is(literal) then
			literal:observe(literal)	
		end

		return self
	end

	-- type Literal = string | number | ValueBase | CFrame | Vector3
end;

local Tab = {}
do
	Tab.__index = Tab

	function Tab:_objMount(obj)
		table.insert(self.Props, obj)
		
		if Selene.Spotlight ~= self then
			obj.Gui.Parent = Selene.Repository
		else
			obj.Gui.Parent = Selene.Gui.Items
		end
	end

	function Tab:Pop()
		local items = Selene.Gui.Items

		for _, obj in pairs(self.Props) do
			obj.Gui.Parent = Selene.Repository
		end

		tween(self.Gui.Label, { TextColor3 = Color3.new(0,0,0) }, QUICK_STYLE):Play()
		tween(self.Gui.Img, { ImageColor3 = Color3.new(0,0,0) }, QUICK_STYLE):Play()
	end

	function Tab:Push()
		if Selene.Spotlight == self then
			return
		end

		local items = Selene.Gui.Items

		if Selene.Spotlight then
			Selene.Spotlight:Pop()
		end

		for _, obj in pairs(self.Props) do
			obj.Gui.Parent = items
		end

		Selene.Spotlight = self

		tween(self.Gui.Label, { TextColor3 = Color3.fromRGB(124, 176, 181) }, QUICK_STYLE):Play()
		tween(self.Gui.Img, { ImageColor3 = Color3.fromRGB(124, 176, 181)}, QUICK_STYLE):Play()
	end

	function Tab.new(parent, args)
		local self = {
			Title = args.Title,
			Gui = RAW.tab_navi(args.Title, args.Icon);

			Props = {}
		}

		do
			local gui = self.Gui
			local modal = RAW.modal(self.Gui)

			modal.MouseButton1Click:Connect(function()
				self:Push()
			end)
		end

		return setmetatable(self, Tab)
	end
end;

local Slnobj = {}
do
	Slnobj.__index = Slnobj

	function Slnobj:Destroy()
		if self._temp then
			for _, v in pairs(self._temp) do
				self._temp:Disconnect()
			end
		end
		
		self.Parent:_remove(self)	
		self.Gui:Destroy()
	end
	
	function Slnobj:Get(...)
		return self.State:get(...)	
	end
	
	function Slnobj:Set(...)
		return self.State:set(...)	
	end
	
	function Slnobj:_init(args)
		--@ initialize events

		for fn, arg in pairs(args) do
			if type(fn) == "function" then
				fn(self, arg)
			end
		end

		--@ initialize effects and stuff

		local gui = self.Gui
		local modal = RAW.modal(self.Gui)
		
		local mousedown = function()
			tween(self.Gui, { Size = self._initSize }):Play()
		end
		
		if self._clickable then
			modal.MouseButton1Down:Connect(function()
				local iSize = self._initSize
				local AMP = .98

				tween(self.Gui, { Size =  UDim2.fromOffset(iSize.X.Offset * AMP, iSize.Y.Offset * AMP) }):Play()
			end)

			modal.MouseButton1Up:Connect(mousedown)
		end
		
		modal.MouseEnter:Connect(function()
			tween(self.Gui, { BackgroundTransparency = .25 }):Play()
		end)

		modal.MouseLeave:Connect(function()
			if self._clickable then
				mousedown()
			end
			
			tween(self.Gui, { BackgroundTransparency = .85 }):Play()
		end)

		self._initSize = gui.Size
		self._modal = modal
	end

	-- [ ... ]

	function impl_sln()
		local tbl = {}

		tbl.__index = function(self, key)
			local fromSln = Slnobj[key]

			if fromSln then
				return fromSln
			end;

			return tbl[key]
		end

		return tbl
	end
end;

local Macro = impl_sln()
do
	function Macro:Hook(fn)
		self._hook = fn
	end

	function Macro.new(parent, args)
		--[[
			Args
			@ Title
			@ Hook
		]]

		local self = setmetatable({}, Macro)

		self.Parent = parent
		self.Gui = RAW.macro(args.Title)

		do
			self._clickable = true
			self:_init(args)

			self._modal.MouseButton1Down:Connect(function()
				self._hook()
			end)
		end


		return self
	end
end;

local Boolean = impl_sln()
do
	function Boolean:Hook(fn)
		return self.State:observe(fn)
	end
	
	function Boolean.new(parent, args)
		local self = setmetatable({}, Boolean)
		
		self.Parent = parent
		self.Gui = RAW.boolean(args.Title)
		self.State = State.new(not args.State)
		
		do
			self._clickable = true
			
			self:_init(args)
			
			self._modal.MouseButton1Down:Connect(function(...)
				self:Set(not self:Get())
			end)
			
			self:Hook(function(value)
				tween(self.Gui.Toggle.Progress, { Size = UDim2.fromScale(value and 1 or 0, value and 1 or 0) }, QUICK_STYLE):Play()
				tween(self.Gui.Toggle.Wheel, { Position = UDim2.fromScale(value and .526 or -.1, .5) }, QUICK_STYLE):Play()
			end)
			
			self:Set(args.State or false)
		end
		
		return self
	end
end;


local Slider = impl_sln()
do
	local function new_g(title)
		return New "Frame" {
			Name = "Slider",
			BackgroundColor3 = Color3.fromRGB(203, 203, 203),
			BackgroundTransparency = 0.85,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.226, 0.229),
			Size = UDim2.fromOffset(444, 37),

			[Children] = {
				New "UICorner" {
					Name = "Corner",
					CornerRadius = UDim.new(0, 4),
				},

				New "UIStroke" {
					Name = "Stroke",
					Thickness = 0.8,
					Transparency = 0.66,
				},

				New "TextLabel" {
					Name = "Title",
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = title,
					TextColor3 = Color3.fromRGB(68, 68, 68),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0251, 0),
					Size = UDim2.new(0, 187, 1, 0),
				},

				New "Frame" {
					Name = "Whole",
					Active = true,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(92, 114, 122),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.328, 0.5),
					Size = UDim2.fromOffset(245, 3),

					[Children] = {
						New "ImageLabel" {
							Name = "Wheel",
							Image = "http://www.roblox.com/asset/?id=17441312604",
							ImageColor3 = Color3.fromRGB(7, 0, 77),
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(104, 150, 89),
							BackgroundTransparency = 1,
							Position = UDim2.fromScale(0, 0.5),
							Size = UDim2.fromOffset(24, 24),
						},

						New "Frame" {
							Name = "Progress",
							Active = true,
							BackgroundColor3 = Color3.fromRGB(76, 109, 255),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.fromScale(0.124, 1),
							ZIndex = 0,
						},
						
						New "Frame" {
							Name = "Helper",
							Active = true,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Size = UDim2.fromScale(1, 1),
							ZIndex = 0,
						}
					}
				},

				New "TextBox" {
					Name = "Input",
					CursorPosition = -1,
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					PlaceholderText = "*",
					Text = "*",
					TextColor3 = Color3.fromRGB(102, 102, 102),
					TextSize = 20,
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.94, 0),
					Size = UDim2.fromOffset(39, 37),
				},
			}
		}	
	end
	
	function Slider:Hook(fn)
		return self.State:observe(fn)
	end
	
	function Slider.new(parent, args)
		local self = setmetatable({}, Slider)
		
		self.Parent = parent
		self.Gui = new_g(args.Title)
		self.State = State.new(0)
		self.Range = args.Range
		
		do
			self._clickable = true
			self:_init(args)
			
			-- [ ... ]
			
			local gui = self.Gui
			local input = gui.Input
			local progress, wheel = gui.Whole.Progress, gui.Whole.Wheel
			
			self:Hook(function(value)
				value = math.round(value)
				
				local min, max = self.Range[1], self.Range[2]
				local portion = (value - min) / (max - min)
				
				tween(wheel, { 
					Rotation = math.round(360 * portion),
					Position = UDim2.fromScale(math.clamp(portion - .1, -.02, .93), .5)
				}, QUICK_STYLE):Play()
				
				tween(progress, { Size = UDim2.fromScale(portion, 1) }, QUICK_STYLE):Play()
				
				input.Text = value .. "*"
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
				
				local mouse = CLIENT:GetMouse()
				local guis = CLIENT.PlayerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)
				
				if table.find(guis, self.Gui) then
					self._active = true
					
					task.spawn(function()
						while self.Gui.Parent ~= nil and self._active do
							task.wait()
							
							local pos = UserInputService:GetMouseLocation()
							local relative = (pos -  gui.Whole.Helper.AbsolutePosition)
							
							local portion = math.clamp(relative.X / gui.Whole.Helper.AbsoluteSize.X, 0, 1)
							
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

local Dropdown = impl_sln()
do
	local function new_g(title)
		return New "Frame" {
			Name = "Dropdown",
			BackgroundColor3 = Color3.fromRGB(203, 203, 203),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.226, 0.229),
			Size = UDim2.fromOffset(444, 37),

			[Children] = {
				New "Frame" {
					Name = "Dropper",
					BackgroundColor3 = Color3.fromRGB(203, 203, 203),
					BackgroundTransparency = 0.85,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromOffset(0, 39),
					Size = UDim2.fromScale(1, 5),
					ClipsDescendants = true,

					[Children] = {
						New "UIStroke" {
							Name = "Stroke",
							Thickness = 0.8,
							Transparency = 0.66,
						},

						New "UICorner" {
							Name = "Corner",
							CornerRadius = UDim.new(0, 4),
						},

						New "UIListLayout" {
							Name = "List",
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
					}
				},

				New "Frame" {
					Name = "Base",
					BackgroundColor3 = Color3.fromRGB(203, 203, 203),
					BackgroundTransparency = 0.85,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.fromOffset(444, 37),

					[Children] = {
						New "TextLabel" {
							Name = "Title",
							FontFace = Font.new(
								"rbxasset://fonts/families/Roboto.json",
								Enum.FontWeight.Light,
								Enum.FontStyle.Normal
							),
							Text = title,
							TextColor3 = Color3.fromRGB(68, 68, 68),
							TextSize = 18,
							TextXAlignment = Enum.TextXAlignment.Left,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.0251, 0),
							Size = UDim2.new(0.227, 187, 1, 0),
						},

						New "UICorner" {
							Name = "Corner",
							CornerRadius = UDim.new(0, 4),
						},

						New "UIStroke" {
							Name = "Stroke",
							Thickness = 0.8,
							Transparency = 0.66,
						},

						New "ImageLabel" {
							Name = "Arrow",
							Image = "http://www.roblox.com/asset/?id=13481605377",
							ImageColor3 = Color3.fromRGB(140, 163, 184),
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 409, 0.52, 0),
							Size = UDim2.fromOffset(28, 28),
						},

						New "TextLabel" {
							Name = "Choice",
							FontFace = Font.new(
								"rbxasset://fonts/families/Roboto.json",
								Enum.FontWeight.Light,
								Enum.FontStyle.Normal
							),
							Text = "Option",
							TextColor3 = Color3.fromRGB(124, 124, 124),
							TextSize = 18,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Right,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Position = UDim2.fromOffset(299, 1),
							Size = UDim2.new(-0.0292, 118, 1, 0),
						},
					}
				},
			}
		}
	end
	
	local function option_g(parent, title)
		return New "Frame" {
			Name = "Option",
			BackgroundColor3 = Color3.fromRGB(190, 190, 190),
			BackgroundTransparency = 0.7,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(444, 37),
			Parent = parent;

			[Children] = {
				New "TextLabel" {
					Name = "Label",
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = title,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 18,
					TextTransparency = 0.25,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.fromScale(1, 1),
				},
			}
		}
	end
	
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
		local arr = self.List:get()
		
		for i, choice in ipairs(buttons) do
			choice:Destroy()
			buttons[i] = nil
		end
		
		for _, value in ipairs(arr) do
			local choice = option_g(self.Gui.Dropper, value)
			local modal = RAW.modal(choice)
			
			modal.MouseButton1Click:Connect(function()
				if not self._toggled then
					return
				end
				
				self:Toggle()
				self:Set(value)
			end)
			
			modal.MouseEnter:Connect(function()
				tween(choice, { BackgroundTransparency = .7 }, QUICK_STYLE):Play()	
			end)
			
			modal.MouseLeave:Connect(function()
				tween(choice, { BackgroundTransparency = .8 }, QUICK_STYLE):Play()	
			end)
			
			table.insert(buttons, choice)	
		end
	end
	
	function Dropdown:Toggle()
		local enable = not self._toggled
		
		local gui = self.Gui
		local base, dropper = gui.Base, gui.Dropper
		
		local arr = self.List:get()
		
		tween(gui, { Size = UDim2.fromOffset(444, 37 * (1 + (enable and #arr or 0))) }, QUICK_STYLE):Play()
		tween(dropper, { Size = UDim2.new(1, 0, 0, enable and (#arr * 37) or 0) }, QUICK_STYLE):Play()
		tween(base.Arrow, { Rotation = enable and 0 or 180 }, QUICK_STYLE):Play()
		
		self._toggled = enable
	end
	
	function Dropdown.new(parent, args)
		local self = setmetatable({}, Dropdown)
		
		self.Parent = parent
		self.Gui = new_g(args.Title)
		self.State = State.new(args.State or args.Range[1])
		
		self.List = State.new( args.Range )
		self.Buttons = {}
		
		do
			self._toggled = true
			
			self:Toggle()
			self:_init(args)
			self:Load()
			
			self.List:observe(function()
				self:Load()	
			end)
			
			self:Hook(function(value)
				self.Gui.Base.Choice.Text = tostring(value)	
			end)
			
			self:Set(args.State or args.Range[1], nil, true)
			
			self._modal.Parent = self.Gui.Base
			self._modal.MouseButton1Down:Connect(function(...)
				self:Toggle()
			end)
		end
		
		return self
	end	
end;

local Embed = impl_sln()
do
	local function new_g(title, caption)
		local strlen = caption:len()
		
		return New "Frame" {
			Name = "Embed",
			BackgroundColor3 = Color3.fromRGB(203, 203, 203),
			BackgroundTransparency = 0.85,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.226, 0.369),
			Size = UDim2.fromOffset(444, 12 + (37 * (1 + (strlen/56)))),

			[Children] = {
				New "UICorner" {
					Name = "Corner",
					CornerRadius = UDim.new(0, 4),
				},

				New "UIStroke" {
					Name = "Stroke",
					Thickness = 0.8,
					Transparency = 0.66,
				},

				New "TextLabel" {
					Name = "Title",
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = title,
					TextColor3 = Color3.fromRGB(68, 68, 68),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromOffset(11, 0),
					Size = UDim2.fromOffset(187, 38),
				},

				New "TextLabel" {
					Name = "Caption",
					FontFace = Font.new(
						"rbxasset://fonts/families/Roboto.json",
						Enum.FontWeight.Light,
						Enum.FontStyle.Normal
					),
					Text = caption,
					TextColor3 = Color3.fromRGB(132, 132, 132),
					TextSize = 18,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromOffset(11, 38),
					Size = UDim2.fromOffset(415, 83),
				},
			}
		} 
	end
	
	function Embed.new(parent, args)
		local self = setmetatable({}, Embed)
		
		self.Parent = parent
		self.Gui = new_g(args.Title, args.Caption)
		
		return self
	end	
end;

local Theme = {}
do
	function Theme:apply(src)
		if self.Primary then
			src.GroupColor3 = self.Primary

			return
		end
	end

	function Theme.from(color)
		return {
			Primary = color
		}
	end

	Theme.Peach = Theme.from(Color3.fromHex("F6D0B1"))
	Theme.Blossom = Theme.from(Color3.fromHex("FFCFCF"))
end;

--[[Selene.Components = {
	// Macro = "Macro",
	// Toggle = "Toggle",
	Slider = "Slider",
	// Dropdown = "Dropdown",
	// Keybind = "Keybind",
	// Embed = "Embed",
	// Typeable = "Typeable"
}]]

function Selene:_objMount(tab)
	self.Tabs[tab.Title] = tab

	if not self.Spotlight then
		tab:Push()
	end
end

function Selene:Toggle(on)
	if self._toggled == on then
		return
	end

	local CONST = on and 1 or .98
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
		Size = UDim2.fromOffset(587 * CONST, 412 * CONST)
	}, style):Play()
end

function Selene:Mount(constructor, args)
	if not self._objMount then
		error()
	end

	local new = constructor(self, args)

	self:_objMount(new)

	return new
end

function Selene:Bind(keybind, fn)
	self.Binds[keybind] = fn
end

function Selene:Create(SETTINGS)
	assert(not self.Gui, "Attempt to create more than one instance of Selene...")

	print("! Selene Initialized :: On vers. " .. self.Version)

	self.Tabs = {}

	self.Gui = RAW.src_gui(SETTINGS)
	self.Repository = New "Frame" {
		Name = "Repository",
		Parent = self.Gui.Parent,
		Visible = false
	}

	if SETTINGS.Theme then
		Theme.apply(SETTINGS.Theme, self.Gui)
	end

	do
		local gui = self.Gui
		local button = RAW.modal(gui.Buttons.Close)

		button.MouseButton1Click:Connect(function()
			self:Toggle(false)		
		end)
		
		task.spawn(function()
			local TIME = 1.2

			local bgroundGrad = self.Gui.background.Gradients:GetChildren()
			local style = easing(TIME, Enum.EasingStyle.Linear)

			while task.wait(TIME) do
				for _, grad in pairs(bgroundGrad) do
					tween(grad, { BackgroundTransparency = (math.random(25, 75) / 100) }, style):Play()
				end
			end	
		end)
		
		UserInputService.InputBegan:Connect(function(input)
			local code = input.KeyCode
			local bind =  self.Binds[code]
			
			return bind and bind()
		end)
		
		self:Bind(Enum.KeyCode.RightShift, function()
			self:Toggle(true)
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

	task.defer(intro, self.Gui)
end	

function Selene.Hook(obj, ...)
	return obj:Hook(...)	
end

Selene.Tab = Tab.new
Selene.Macro = Macro.new
Selene.Boolean = Boolean.new
Selene.Dropdown = Dropdown.new
Selene.Embed = Embed.new
Selene.Slider = Slider.new

Selene.Theme = Theme
Selene.State = State.new

return Selene
