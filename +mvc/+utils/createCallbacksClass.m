function createCallbacksClass(app)
    % Copyright 2021 The MathWorks, Inc.
    % Pierre Harouimi
    % pharouim@mathworks.com
    % Create automatically the Callbacks class derived from mvc.aCallbacks abstract class 
    % See createViewClass function to create the View class derived from mvc.aView abstract class

    components          = findobj(app);
    p                   = properties(components);
    myComp              = ?myComponents;
    attachCallbacks     = [];
    functionsCallbacks  = [];
    pat                 = asManyOfPattern("ui");

    for i = 1 : numel(p)
    	comp            = components.(p{i});
        try
            type        = extractAfter(comp.Type, pat);
            compMethods = string({myComp.MethodList.Name});
            indMethod   = find(strcmpi(compMethods, type));
        catch ME
            fprintf("Component " + p(i) + " is not an ui obj :%s\n", ME.message);
            continue
        end
    	comp            = myComponents.(compMethods(indMethod)); %#ok<FNDSB>
        for j = 1 : numel(comp.callbacks)
            attachCallbacks     = [attachCallbacks 10 convertStringsToChars(["obj.view_." + "h" + p{i} + "." + comp.callbacks(j) + " = " + "@(evt,src) " + ...
                                   "h" + p{i} + comp.callbacks(j) + "(obj,evt,src)" + ";"]) 10]; %#ok<*AGROW> 
            functionsCallbacks  = [functionsCallbacks 10 convertStringsToChars(["function " + "h" + p{i} + comp.callbacks(j) + "(obj,evt,src)"]) 10 ...
                                   '%% TO DO' 10 'end' 10];
        end
    end

    constructorCallbacks    = {'methods', 'function obj = Callbacks(view)', 'obj@mvc.aCallbacks(view);', 'end', 'end', ''}; 
    constructorCallbacks    = matlab.desktop.editor.linesToText(constructorCallbacks);
    attachCallbacks         = ['methods' 10 'function attachCallbacks(obj)' attachCallbacks 10 'end' 10 'end' 10];   
    functionsCallbacks      = ['methods (Access = private)' 10 functionsCallbacks 10 'end']; 
    bodyCallbacks           = {'classdef Callbacks < mvc.aCallbacks', '', constructorCallbacks, attachCallbacks, functionsCallbacks, 'end', ''};
    bodyCallbacks           = matlab.desktop.editor.linesToText(bodyCallbacks);

    % Load it up with the lines of code you want in it.
    editorService       = com.mathworks.mlservices.MLEditorServices;
    editorApplication   = editorService.getEditorApplication();
    e                   = editorApplication.newEditor(bodyCallbacks);
    e.smartIndentContents
    e.negotiateSave
    
end