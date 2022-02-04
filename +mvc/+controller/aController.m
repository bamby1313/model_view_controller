classdef (Abstract) aController < matlab.mixin.SetGetExactNames & matlab.mixin.Heterogeneous & dynamicprops
    
    %% EVENTS
    events
        LocationChanged
        SizeChanged
        ModelAdded
    end    

    properties (Constant, Hidden)
        UNITS_DEFAULT = "pixels" 
    end

    %% ABSTRACT METHODS
    methods (Abstract, Access = protected)
        attachCallbacks(obj)
        addListenersToModel(obj)    
    end
    methods (Abstract)
        refresh(obj)
        build(obj)
    end

    %% DEPENDENT PROPERTIES
    properties (Dependent)
        Model
        View
        Panel
        Parent
        Name
        Units 
        Visible
        Position
        Location
        Size  
    end

    %% LISTENERS PROPERTIES
    properties (Access = protected)
        listeners_ (:,:) event.listener
    end

    %% PRIVATE PROPERTIES
    properties (GetAccess = protected, SetAccess = immutable)
        panel_ matlab.ui.container.Panel
    end     
    properties (Access = protected)
        view_   (:,:) mvc.view.aView    = mvc.view.aView.empty()
        model_  (:,:) mvc.model.aModel  = mvc.model.aModel.empty()
        name_   (1,1) string            = ""
    end

    %% CONSTRUCTOR
    methods
        function obj = aController(view, model)
            obj.panel_              = uipanel("Parent", [], "BorderType", "none", "Units", obj.UNITS_DEFAULT); %, "DeleteFcn", @obj.onPanelDeleted);
            obj.View                = view;
            obj.listeners_(end+1)   = event.listener(obj.view_, "ViewBuilt", @(~,~) obj.attachCallbacks);  
            obj.Model               = model;
        end
    end

   methods(Sealed)
        function varargout = set(obj,varargin)
            [varargout{1:nargout}] = set@matlab.mixin.SetGet(obj,varargin{:});
        end
   end
   
    %% ACCESSORS & MUTATORS
    methods

        function value = get.Name(obj)
            value = obj.name_; 
        end
        function set.Name(obj, name)
            obj.name_       = name; 
            obj.view_.Name  = obj.name_;
        end   

        function v = get.View(obj)
            v = obj.view_;
        end
        function set.View(obj, v)
            obj.view_           = v;
            obj.view_.Parent    = obj.panel_;
            obj.view_.Name      = obj.name_;            
            if v.Status
                attachCallbacks(obj);
            end
        end

        function value = get.Model(obj)
            value = obj.model_; 
        end
        function set.Model(obj, model)
            obj.model_ = model;
            addListenersToModel(obj);
            notify(obj, 'ModelAdded');
        end    

        function value = get.Parent(obj)
            value = obj.panel_.Parent;
        end
        function set.Parent(obj, value)
            obj.panel_.Parent = value;
        end 
        function panel = get.Panel(obj)
            panel = obj.panel_;
        end        

        % POSITION (LOCATION & SIZE)
        function value = get.Position(obj)
            value = obj.panel_.Position;
        end 
        function value = get.Location(obj)
            value = obj.panel_.Position(1:2);
        end 
        function set.Location(obj, value)
            obj.panel_.Position(1:2) = value;
            notify(obj, "LocationChanged")
        end         
        function size = get.Size(obj)
            size = obj.panel_.Position(3:4);
        end
        function set.Size(obj, size)
            obj.panel_.Position(3:4) = size;
            notify(obj, "SizeChanged")
        end

        function value = get.Units(obj)
            value = obj.panel_.Units;
        end 
        function set.Units(obj, value)
            obj.panel_.Units = value;
        end 
        
        function value = get.Visible(obj)
            value = obj.panel_.Visible;
        end 
        function set.Visible(obj, value)
            obj.panel_.Visible = value;
        end 

    end

    %% PRIVATE METHODS - DELETE OBJECT
    methods (Access = private)
        function onPanelDeleted(obj, ~, ~)
            delete(obj);
        end
    end

    %% SETPROPERTIES
    methods (Access = protected)
        function setProperties(obj, varargin)
            if ~isempty(varargin)
                set(obj, varargin{:});
            end 
        end      
    end

    %% OVERRIDE
    methods (Sealed)
        function bool = eq(c1,c2)
            if isempty(c1) && ~isempty(c2) || isempty(c2) && ~isempty(c1)
                bool = false;
            elseif numel(c1) >= numel(c2)
                bool = arrayfun(@(x) c2.View.Name == x.View.Name, c1);
            elseif numel(c2) > numel(c1)
                bool = arrayfun(@(x) c1.View.Name == x.View.Name, c2);         
            end
        end
    end    
        
end