classdef (Abstract) myComponents 
    methods (Static)
        %% CONTROLS        
        function v = Figure()
            v.class      = "matlab.ui.Figure";
            v.callbacks  = ["ButtonDownFcn" "KeyPressFcn" "KeyReleaseFcn" "CloseRequestFcn" "SizeChangedFcn" "WindowButtonDownFcn" ...
                           "WindowButtonMotionFcn" "WindowButtonUpFcn" "WindowKeyPressFcn" "WindowKeyReleaseFcn" "WindowScrollWheelFcn"];
        end        
        function v = Button()
            v.class      = "matlab.ui.control.Button";
            v.callbacks  = "ButtonPushedFcn";
        end
        function v = CheckBox()
            v.class      = "matlab.ui.control.CheckBox";
            v.callbacks  = "ValueChangedFcn ";
        end
        function v = DatePicker()
            v.class      = "matlab.ui.control.DatePicker";
            v.callbacks  = "ValueChangedFcn";
        end
        function v = DropDown()
            v.class      = "matlab.ui.control.DropDown";
            v.callbacks  = ["ValueChangedFcn" "DropDownOpeningFcn"];
        end
        function v = NumericEditField()
            v.class      = "matlab.ui.control.NumericEditField";
            v.callbacks  = "ValueChangedFcn";
        end
        function v = EditField()
            v.class      = "matlab.ui.control.EditField";
            v.callbacks  = ["ValueChangedFcn" "ValueChangingFcn"];
        end
        function v = Image()
            v.class      = "matlab.ui.control.Image";
            v.callbacks  = "ImageClickedFcn";
        end
        function v = Label()
            v.class      = "matlab.ui.control.Label";
            v.callbacks  = [];
        end 
        function v = ListBox()
            v.class      = "matlab.ui.control.ListBox";
            v.callbacks  = "ValueChangedFcn";
        end 
        function v = ButtonGroup()
            v.class      = "matlab.ui.container.ButtonGroup";
            v.callbacks  = ["SelectionChangedFcn" "SizeChangedFcn" "ButtonDownFcn"];
        end 
        function v = RadioButton()
            v.class      = "matlab.ui.control.RadioButton";
            v.callbacks  = [];
        end 
        function v = Slider()
            v.class      = "matlab.ui.control.Slider";
            v.callbacks  = ["ValueChangedFcn" "ValueChangingFcn"];
        end 
        function v = Spinner()
            v.class      = "matlab.ui.control.Spinner";
            v.callbacks  = ["ValueChangedFcn" "ValueChangingFcn"];
        end 
        function v = StateButton()
            v.class      = "matlab.ui.control.StateButton";
            v.callbacks  = "ValueChangedFcn";
        end        
        function v = Table()
            v.class      = "matlab.ui.control.Table";
            v.callbacks  = ["CellEditCallback" "CellSelectionCallback" "DisplayDataChangedFcn" "ButtonDownFcn" "KeyPressFcn" "KeyReleaseFcn"];
        end 
        function v = TextArea()
            v.class      = "matlab.ui.control.TextArea";
            v.callbacks  = "ValueChangedFcn";
        end 
        function v = ToggleButton()
            v.class      = "matlab.ui.control.ToggleButton";
            v.callbacks  = [];
        end 
        function v = Tree()
            v.class      = "matlab.ui.container.Tree";
            v.callbacks  = ["SelectionChangedFcn" "NodeExpandedFcn" "NodeCollapsedFcn" "NodeTextChangedFcn"];
        end 
        function v = TreeNode()
            v.class      = "matlab.ui.container.TreeNode";
            v.callbacks  = "ValueChangedFcn";
        end                
        %% AXES
        function v = Axes()
            v.class      = "matlab.ui.control.UIAxes";
            v.callbacks  = "ButtonDownFcn";
        end 
        function v = GeographicAxes()
            v.class      = "matlab.graphics.axis.GeographicAxes";
            v.callbacks  = "ButtonDownFcn";
        end 
        function v = PolarAxes()
            v.class      = "matlab.graphics.axis.PolarAxes";
            v.callbacks  = "ButtonDownFcn";
        end 
        
        %% CONTAINERS
        function v = GridLayout()
            v.class      = "matlab.ui.container.GridLayout";
            v.callbacks  = [];
        end        
        function v = Panel()
            v.class      = "matlab.ui.container.Panel";
            v.callbacks  = ["SizeChangedFcn" "ButtonDownFcn"];
        end 
        function v = TabGroup()
            v.class      = "matlab.ui.container.TabGroup";
            v.callbacks  = ["SelectionChangedFcn" "SizeChangedFcn" "ButtonDownFcn"];
        end 
        function v = Tab()
            v.class      = "matlab.ui.container.Tab";
            v.callbacks  = ["SizeChangedFcn" "ButtonDownFcn"];
        end 
        function v = Menu()
            v.class      = "matlab.ui.container.Menu";
            v.callbacks  = "MenuSelectedFcn";
        end 
        function v = ContextMenu()
            v.class      = "matlab.ui.container.ContextMenu";
            v.callbacks  = "ContextMenuOpeningFcn";
        end        
        function v = Toolbar()
            v.class      = "matlab.ui.container.Toolbar";
            v.callbacks  = [];
        end 
        function v = ToggleTool()
            v.class      = "matlab.ui.container.toolbar.ToggleTool";
            v.callbacks  = ["ClickedCallback" "OnCallback" "OffCallback"];
        end 
        function v = PushTool()
            v.class      = "matlab.ui.container.toolbar.PushTool";
            v.callbacks  = "ClickedCallback";
        end 

        %% INSTRUMENTATION
        function v = Gauge()
            v.class      = "matlab.ui.control.Gauge";
            v.callbacks  = [];
        end 
        function v = NinetyDegreeGauge()
            v.class      = "matlab.ui.control.NinetyDegreeGauge";
            v.callbacks  = [];
        end        
        function v = LinearGauge()
            v.class      = "matlab.ui.control.LinearGauge";
            v.callbacks  = [];
        end 
        function v = SemicircularGauge()
            v.class      = "matlab.ui.control.SemicircularGauge";
            v.callbacks  = [];
        end 
        function v = Knob()
            v.class      = "matlab.ui.control.Knob";
            v.callbacks  = ["ValueChangedFcn", "ValueChangingFcn"];
        end 
        function v = DiscreteKnob()
            v.class      = "matlab.ui.control.DiscreteKnob";
            v.callbacks  = "ValueChangedFcn";
        end         
        function v = Lamp()
            v.class      = "matlab.ui.control.Lamp";
            v.callbacks  = [];
        end 
        function v = Switch()
            v.class      = "matlab.ui.control.Switch";
            v.callbacks  = "ValueChangedFcn";
        end 
        function v = ToggleSwitch()
            v.class      = "matlab.ui.control.ToggleSwitch";
            v.callbacks  = "ValueChangedFcn";
        end 
        function v = RockerSwitch()
            v.class      = "matlab.ui.control.RockerSwitch";
            v.callbacks  = "ValueChangedFcn";
        end 
        
        %% EXTENSIBLE
        function v = HTML()
            v.class      = "matlab.ui.control.HTML";
            v.callbacks  = "DataChangedFcn";
        end         
       
    end
end