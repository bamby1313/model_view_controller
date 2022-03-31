classdef simpleExample_Controller2 < mvc.controller.aController

    %% CONSTRUCTOR
    methods
        function obj = simpleExample_Controller2(view, options)  
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
        end
        function addListenersToModel(obj)
            obj.listeners_(end+1) = event.listener(obj.model_, "NumberOutputChanged", @(src, ~) obj.view_.update(src.NumberOutput));
        end
    end
    methods (Access = public)
        function build(obj)
            obj.view_.build();
        end
        function refresh(obj)
        end
    end
  
end

