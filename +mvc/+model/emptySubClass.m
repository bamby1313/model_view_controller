classdef emptySubClass < mvc.model.aModel 

    methods (Static, Hidden)
        function EmptyObj = empty( varargin )
            ind         = double.empty; 
            Obj         = emptySubClass(); 
            EmptyObj    = Obj(ind);
        end
    end

end