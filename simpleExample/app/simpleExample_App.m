classdef simpleExample_App < mvc.app.aApp & dynamicprops
    
    %% PRIVATE PROPERTIES
    properties (Access = private)
        appclosed_ logical 
    end
    
    %% CONSTRUCTOR
    methods
        function obj = simpleExample_App(name, varargin)     
            obj@mvc.app.aApp(name, varargin{:});
        end    
    end
    
    %% INHERITED METHODS
    methods (Access = protected)
        
        function hCloseRequestFcnImpl(obj, evt, src) %#ok<INUSD> 
            obj.appclosed_ = ~obj.appclosed_;    
            delete(obj.mlapp_)
        end            
        
        function runImpl(obj)          
            obj.setParentOfComponents();
            obj.setInitialLocationsOfComponents();
        end
    
        function refreshImpl(obj, varargin)
        end
        function hSizeChangedFcnImpl(obj, evt, src)
        end
        function hAutoResizeChildrenImpl(obj)
        end
        function hResizeImpl(obj)
        end
        function hWindowStateImpl(obj)
        end
        function hUnitsImpl(obj)
        end

        function setParentOfComponents(obj)
            obj.simpleExample_Controller1.Parent = obj.mlapp_.GridLayout;
            obj.simpleExample_Controller2.Parent = obj.mlapp_.GridLayout;
        end        
        function setInitialLocationsOfComponents(obj)
            obj.simpleExample_Controller1.Panel.Layout.Row     = 1;
            obj.simpleExample_Controller1.Panel.Layout.Column  = 2;
            obj.simpleExample_Controller2.Panel.Layout.Row     = 2;
            obj.simpleExample_Controller2.Panel.Layout.Column  = 1;
        end

    end
    
    %% METHODS - Specific/Custom app
    methods (Access = private)
    end
end


