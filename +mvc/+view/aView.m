classdef (Abstract) aView < matlab.mixin.SetGet & matlab.mixin.Heterogeneous & matlab.mixin.Copyable
    
    %% EVENTS FOR POTENTIAL CALLBACKS ATTACHED
    events
        ViewBuilt
        ViewRefreshed
        NameChanged
        StatusChanged
    end
    
    %% ABSTRACT METHODS
    methods (Abstract, Access = protected)
        buildImpl(obj)
        refreshImpl(obj)
    end
    
    %% PROPERTIES - Constant
    properties (Constant, Hidden)
        UNITS = "pixels"
    end

    %% PROPERTIES - Parent (Panel)
    properties (Dependent)
        Parent
        Name
    end
    properties (Access = protected)
        parent_  matlab.ui.container.Panel
        name_    string = ""
    end
    
    
    %% PROPERTIES - Listeners
    properties (Access = protected)
        listeners_ (:,:) event.listener
    end
    
    %% PROPERTIES - Status (built)
    properties (Dependent)
        Status
    end
    properties (Access = private)
        status_ (1,1) logical = false
    end

    %% CONSTRUCTOR
    methods
        function obj = aView()
            if ~isempty(obj.parent_)
                obj.refresh();
            end
        end     
    end 
    
    %% ACCESSORS & MUTATORS
    methods
        function name = get.Name(obj)
            name = obj.name_;
        end
        function set.Name(obj, name)
            obj.name_ = name;
            notify(obj, "NameChanged");
        end   

        function parent = get.Parent(obj)
            parent = obj.parent_;
        end
        function set.Parent(obj, parent)
            obj.parent_ = parent;
        end
        
        function status = get.Status(obj)
            status = obj.status_;
        end
        function set.Status(obj, status)
            obj.status_ = status;
            notify(obj, "StatusChanged");
        end        

    end
    
    %% REFRESH METHODS
    methods
        function obj = build(obj)
            buildImpl(obj);
            obj.status_ = true;
            notify(obj, "ViewBuilt");
        end
        function obj = refresh(obj)
            refreshImpl(obj);
            obj.status_ = true;
            notify(obj, "ViewRefreshed");
        end        
    end

%     %% SEALED METHODS
%     methods (Sealed)
%         function myclass = class(obj) %#ok<MANU>
%             myclass = string(mfilename('class'));
%         end        
%     end   
    
end