local Root = script.Parent.Parent
local Roact = require(Root.dependencies.Roact)
local StudioPluginContext = require(Root.dependencies.vibrant.components.plugin.StudioPluginContext)
local StudioToolbar = require(Root.dependencies.vibrant.components.plugin.StudioToolbar)
local StudioToolbarButton = require(Root.dependencies.vibrant.components.plugin.StudioToolbarButton)
local StudioDockWidgetGui = require(Root.dependencies.vibrant.components.plugin.StudioDockWidgetGui)

local ButtonEntry = require(script.list_entries.ButtonEntry)
local TextBoxEntry = require(script.list_entries.TextBoxEntry)
local SliderEntry = require(script.list_entries.SliderEntry)
local ComboBoxEntry = require(script.list_entries.ComboBoxEntry)

local e = Roact.createElement
-----------------------------------------------------------------------------

local App = Roact.Component:extend("App")

function App:init()
    self:setState({
        enabled = false,
    })

    self.OnButton1Clicked = function()
        self:setState(function(prevState)
            return {
                enabled = not prevState.enabled
            }
        end)
    end
end

function App:render()
    local props = {
        pluginContext = {
            value = self.props.pluginModule
        },

        toolbar = {
            name = self.props.pluginModule.name
        },

        button1 = {
            text = "Vibrant Demo",
            active = self.state.enabled,
            tooltipDescription = "Shows a demo of all the plugin UI controls",
            onClick = self.OnButton1Clicked
        }
    }

    return e(StudioPluginContext.Provider, props.pluginContext, {
        ToolBar = e(StudioToolbar, props.toolbar, {
            Button1 = e(StudioToolbarButton, props.button1)
        }),


        StudioDockWidget = e(StudioDockWidgetGui, {
            enabled = self.state.enabled,
            title = "Vibrant Demo",
            initialDockState = Enum.InitialDockState.Float,

            onInitialState = function(enabled)
                self:setState({
                    enabled = enabled
                })
            end,

            onClose = function()
                self:setState({
                    enabled = false
                })
            end
        }, {
            ListLayout = e("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder
            }),

            ButtonListEntry = e("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 100),
                LayoutOrder = 0
            }, {
                ButtonsEntry = e(ButtonEntry)
            }),

            TextBoxListEntry = e("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 100),
                LayoutOrder = 1
            }, {
                TextBoxEntry = e(TextBoxEntry)
            }),

            SliderListEntry = e("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 100),
                LayoutOrder = 2
            }, {
                SliderEntry = e(SliderEntry)
            }),

            ComboBoxEntry = e("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 100),
                LayoutOrder = 3
            }, {
                ComboBoxEntry = e(ComboBoxEntry)
            })
        }),
    })
end

return App