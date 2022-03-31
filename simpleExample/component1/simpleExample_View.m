classdef simpleExample_View < mvc.view.aView
    %
    % Copyright 2021 The MathWorks, Inc.
    % Pierre Harouimi
    
    %% PROPERTIES MLAPP components
    properties (Dependent)
        hEnterText
        hEnterLabel
    end
    properties (Access = protected)
        hEnterLabel_ matlab.ui.control.Label
        hEnterText_  matlab.ui.control.NumericEditField
    end
    
    %% CONSTANT PROPERTIES
    properties (Constant)
        FontWeight = "bold"
        BorderType = "line"
    end

    %% CONSTRUCTOR
    methods
        function obj = simpleExample_View(options)
            arguments
                options.Name = mfilename("class")
            end
            obj@mvc.view.aView();
            obj.name_ = options.Name;
        end       
    end
    
    %% ACCESSORS & MUTATORS
    methods
        function getR = get.hEnterText(obj)
            getR = obj.hEnterText_;
        end
        function getR = get.hEnterLabel(obj)
            getR = obj.hEnterLabel_;
        end   
    end
    
    %% INHERITED METHODS
    methods (Access = protected)
        function buildImpl(obj)
            set(obj.parent_, Title = "Complex calculation", FontWeight = obj.FontWeight, BorderType = obj.BorderType)
            % LAYOUT
            layout                                  = uigridlayout(obj.parent_, [2, 1]);
            % LABEL
            obj.hEnterLabel_                        = uilabel(layout, Text = "Enter x", HorizontalAlignment = "center");
            obj.hEnterLabel_.Layout.Row             = 1;
            obj.hEnterLabel_.Layout.Column          = 1;
            obj.hEnterLabel_.HorizontalAlignment    = "center";
            % TEXT AREA
            obj.hEnterText_                         = uieditfield(layout, "numeric");
            obj.hEnterText_.Layout.Row              = 2;
            obj.hEnterText_.Layout.Column           = 1;
            obj.hEnterText_.HorizontalAlignment     = "center";
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