classdef simpleExample_Model < mvc.model.aModel   
    
    %% EVENTS
    events
        NumberOutputChanged
    end
    
    %% CONSTANT
    properties (Dependent)
        Name
    end

    %% DEPENDENT
    properties (Dependent, SetObservable = true)
        NumberInput                  
    end
    properties (Dependent, SetObservable = true)
        NumberOutput                     
    end
    
    %% PROTECTED
    properties (Access = private, SetObservable = true)
        numberInput_    (1,1) double = 0
        numberOutput_   (1,1) double = 0
    end

    %% PROPERTIES - Listeners
    properties (Access = protected)
        listeners_ (:,:) event.listener
    end

    %% CONSTRUCTOR
    methods
        function obj = simpleExample_Model()  
            obj@mvc.model.aModel(); 
            obj.listeners_(end+1) = event.proplistener(obj, findprop(obj, "numberInput_"), 'PostSet', @(~,~) obj.update);
        end    
    end
    
    %% ACCESSORS
    methods  
        function n = get.NumberInput(obj)
            n = obj.numberInput_;
        end
        function n = get.NumberOutput(obj)
            n = obj.numberOutput_;
        end
        function name = get.Name(obj)
            name = string(metaclass(obj).Name);
        end    
    end

    %% MUTATORS
    methods 
        function set.NumberInput(obj, n)
            obj.numberInput_ = n;
        end
    end
   
    %% METHODS VIEW ONLY ACCESS
    methods 
        function update(obj)
            obj.numberOutput_ = obj.numberInput_ + 2;
            notify(obj, "NumberOutputChanged");
        end
    end
    
end


