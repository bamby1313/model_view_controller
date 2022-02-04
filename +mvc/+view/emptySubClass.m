classdef emptySubClass < mvc.view.aView

    methods (Static, Hidden)
        function EmptyObj = empty( varargin )
            ind         = double.empty; 
            Obj         = emptySubClass(); 
            EmptyObj    = Obj(ind);
        end
    end

    methods (Access = protected)
        function buildView(obj)
        end
    end

end