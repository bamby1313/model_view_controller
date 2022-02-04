classdef emptySubClass < mvc.controller.aController

    methods (Static, Hidden)
        function EmptyObj = empty()
            EmptyObj = emptySubClass(); 
        end
    end

end