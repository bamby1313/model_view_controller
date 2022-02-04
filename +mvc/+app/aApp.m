classdef (Abstract) aApp < matlab.mixin.SetGet & matlab.mixin.Heterogeneous & dynamicprops
    
    events
        FigureCreated
        AppCreated
    end
    
    %% ABSTRACT
    properties (Abstract, Constant)
        FILENAME string {mustBeNonzeroLengthText}
    end

    methods (Abstract, Access = protected)
        hCloseRequestFcnImpl(obj, evt, src)
        hUnitsImpl(obj)
        hAutoResizeChildrenImpl(obj)
        hWindowStateImpl(obj)
        hResizeImpl(obj)
        runImpl(obj)
        refreshImpl(obj, varargin)
    end
    
    properties (Dependent)
        Components
        Mlapp
        Name
        MyFigure
    end
    
    properties (SetAccess = private, GetAccess = protected)
        name_           (1,1) string  = ""
        status_         (1,1) logical = false % Is App ran?
    end
    properties (Access = protected)
        myFigure_       (:,:) matlab.ui.Figure
    end
    properties (Access = protected, SetObservable = true)
        mlapp_          (:,:) {mustBeAnApp}              = matlab.apps.AppBase.empty()
        components_     (:,:) mvc.controller.aController = mvc.controller.aController.empty()
    end

    %% PROPERTIES - Listeners
    properties (Access = protected)
        listeners_ (:,:) event.listener
    end

    %% CONSTRUCTOR
    methods
        function obj = aApp(varargin)
            narginchk(0,1)
            obj.listeners_(end+1) = event.proplistener(obj, findprop(obj, "mlapp_"), 'PostSet', @(~,~) obj.initApp);
            if ~isempty(varargin)
                setProperties(varargin{:});
            end
            [~, name, ext] = fileparts(obj.FILENAME);
            assert(ext == ".mlapp", "Ensure the FILENAME property is a valid mlapp file.");
            obj.name_ = name;                                                     
        end
        function delete(obj)
            obj.status_ = false;
        end
    end

    %% ACCESSORS 
    methods
        function name = get.Name(obj)
            name = obj.name_;
        end
        function myfigure = get.MyFigure(obj)
            myfigure = obj.myFigure_;
        end
        function app = get.Mlapp(obj)
            app = obj.mlapp_;
        end
        function getR = get.Components(obj)
            getR = obj.components_;
        end
    end

    %% PRIVATE METHODS
    methods (Access = private)
        function initApp(obj) % After mlapp_ is set
            myAppProp                       = properties(obj.mlapp_);
            obj.myFigure_                   = obj.mlapp_.(myAppProp{1});
            obj.myFigure_.CloseRequestFcn   = @(evt, src) obj.hCloseRequestFcn(evt, src);
            obj.defineWindowProperties();
            obj.refresh();
            obj.status_ = true; 
            notify(obj, "FigureCreated")
        end
    end

    %% PUBLIC METHODS
    methods
        function obj = addComponent(obj, component)
            assert(~any(component == obj.components_), "Component already attached to the app.")
            
            obj.components_(end+1)  = component;
            
            if component.Name == ""
                component.Name = string(inputname(2));
            end
            obj.addprop(component.Name);
            obj.(component.Name) = component;

            if obj.status_
                obj.(component.Name).build();
            end
            
            obj.refresh(component);
            
        end 
    end

    %% HERITED METHODS
    methods (Sealed)

        function obj = run(obj, varargin)
            
            if ~isempty(obj.myFigure_) && isvalid(obj.myFigure_)
                delete(obj.myFigure_.Children);
            end  
            
            if ~isempty(varargin)
                obj.mlapp_ = varargin{:};
            else
                app        = str2func(obj.name_);
                obj.mlapp_ = app();
            end

            % Build all components view
            arrayfun(@build, [obj.components_], "UniformOutput", false);

            % Run app
            obj.runImpl();
            
            notify(obj, "AppCreated")

            obj.MyFigure.Visible = "on";

        end

        function refresh(obj, varargin)
            if isempty(varargin)
                arrayfun(@obj.refreshImpl, obj.components_);
            else
                component = varargin{:};
                obj.refreshImpl(component);
            end            
        end

        % WINDOW INTERACTIVITY
        function hFigureWindowButtonMotionFcn(obj, evt)
            obj.hFigureWindowButtonMotionFcnImpl(evt);
        end
        function hFigureWindowButtonUpFcn(obj, evt)
            obj.hFigureWindowButtonUpFcnImpl(evt);
        end

        
        % WINDOW PROPERTIES
        function defineWindowProperties(obj)
            obj.hUnits();
            obj.hAutoResizeChildren();
            obj.hWindowState();
            obj.hResize();
        end
            function hUnits(obj)
                obj.hUnitsImpl();
            end
            function hAutoResizeChildren(obj)
                obj.hAutoResizeChildrenImpl();
            end     
            function hWindowState(obj)
                obj.hWindowStateImpl();
            end    
            function hResize(obj)
                obj.hResizeImpl();
            end    

        function hCloseRequestFcn(obj, evt, src)
            obj.hCloseRequestFcnImpl(evt, src);
            obj.status_ = false;
        end

    end

    %% OVERLOADED
    methods
        function bool = eq(app1, app2)
            bool = app1.Name == app2.Name;
        end
        function appsunique = unique(apps)
            [~, b]      = unique([apps.Name]);
            appsunique  = apps(b);
        end
    end
    methods (Sealed)
        function myclass = class(~)
            myclass = string(mfilename('class'));
        end
    end

end

function mustBeAnApp(obj)
if ~any(superclasses(obj) == "matlab.apps.AppBase") && ~(class(obj) == "matlab.apps.AppBase")
    eidType = 'App:notAnApp';
    msgType = 'Value assigned to App property is not a matlab.apps.AppBase.';
    throwAsCaller(MException(eidType,msgType))
end
end

