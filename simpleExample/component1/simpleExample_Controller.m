classdef simpleExample_Controller < mvc.controller.aController

    %% CONSTRUCTOR
    methods
        function obj = simpleExample_Controller(view, options)  
            arguments
                view            {mustBeNonempty}
                options.Name    = mfilename("class")
                options.Model   = mvc.model.aModel.empty()
            end
            view_copy = copy(view);
            obj@mvc.controller.aController(view_copy, options.Model);
            obj.Name = options.Name;
        end
    end

    %% INHERITED METHODS
    methods (Access = protected)
        function attachCallbacks(obj)
            obj.view_.hEnterText.ValueChangedFcn = @(evt,src) hEnterTextValueChangedFcn(obj,src,evt);
        end
        function addListenersToModel(obj)
        end
    end
    methods (Access = public)
        function build(obj)
            obj.view_.build();
        end
        function refresh(obj)
        end
    end
    
    %% PRIVATE METHODS
    methods (Access = private)
        function hEnterTextValueChangedFcn(obj, ~, evt)
            obj.updateModel(evt.Value)
        end        
        function updateModel(obj, value)
            obj.model_.NumberInput = value;
        end
    end
  
end

