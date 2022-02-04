classdef (Abstract) aModel < handle & matlab.mixin.Heterogeneous & matlab.mixin.SetGet & matlab.mixin.Copyable
    
    %% CONSTRUCTOR
    methods
        function obj = aModel(varargin)
            if ~isempty(varargin)
                setProperties(varargin{:})
            end
        end
    end

end


