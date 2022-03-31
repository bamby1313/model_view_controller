classdef simpleExample_View2 < mvc.view.aView
    %
    % Copyright 2021 The MathWorks, Inc.
    % Pierre Harouimi

    %% PROPERTIES MLAPP components
    properties (Dependent)
        hResultText
        hResultLabel
    end
    properties (Access = protected)
        hResultLabel_ matlab.ui.control.Label
        hResultText_  matlab.ui.control.NumericEditField
    end
    
    %% CONSTANT PROPERTIES
    properties (Constant)
        FontWeight = "bold"
        BorderType = "line"
    end

    %% CONSTRUCTOR
    methods
        function obj = simpleExample_View2(options)
            arguments
                options.Model   mvc.model.aModel    = mvc.model.aModel.empty()
                options.Name    string              = mfilename("class")
            end
            obj@mvc.view.aView();
            obj.name_ = options.Name;
        end       
    end
    
    %% ACCESSORS & MUTATORS
    methods
        function getR = get.hResultText(obj)
            getR = obj.hResultText_;
        end
        function getR = get.hResultLabel(obj)
            getR = obj.hResultLabel_;
        end      
    end
    
    %% INHERITED METHODS
    methods (Access = protected)
        function buildImpl(obj)
            set(obj.parent_, Title = "Result of the complex calculation", FontWeight = obj.FontWeight, BorderType = obj.BorderType)
            % LAYOUT
            layout                                  = uigridlayout(obj.parent_, [2, 1]);
            % LABEL
            obj.hResultLabel_                       = uilabel(layout, Text = "x + 2", HorizontalAlignment = "center");
            obj.hResultLabel_ .Layout.Row           = 1;
            obj.hResultLabel_ .Layout.Column        = 1;
            % TEXT AREA
            obj.hResultText_                        = uieditfield(layout, "numeric");
            obj.hResultText_.Layout.Row             = 2;
            obj.hResultText_.Layout.Column          = 1;
            obj.hResultText_.Editable               = false;
            obj.hResultText_.HorizontalAlignment    = "center";
        end
        function refreshImpl(obj)
        end
    end

    %% PUBLIC METHODS
    methods 
        function update(obj, value)
            obj.hResultText_.Value = value;
        end
    end
end