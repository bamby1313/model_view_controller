function createViewClass(app)
    % Copyright 2021 The MathWorks, Inc.
    % Pierre Harouimi
    % pharouim@mathworks.com
    % Create automatically the View class derived from mvc.aView abstract class 
    % See createCallbacksClass function to create the Callbacks class derived from mvc.aView abstract class

    components      = findobj(app);
    p               = properties(components);
    propertiesView  = [];
    accessorsView   = [];
    mutatorsView    = [];

    for i = 1 : numel(p)
        propertiesView  = [propertiesView 10 strcat('h', p{i})]; %#ok<AGROW> % 10 is the ascii code for newline
        accessorsView   = [accessorsView 10 convertStringsToChars(["function value = get." + "h" + p{i} + "(obj)"]) 10 ...
                          convertStringsToChars(["value = obj.mlapp_." + p{i} + ";"]) 10 'end'];   %#ok<AGROW>
        mutatorsView    = [mutatorsView 10 convertStringsToChars(["function set." + "h" + p{i} + "(obj, value)"]) 10 ...
                          convertStringsToChars(["obj.mlapp_." + p{i} + " = value;"]) 10 'end'];   %#ok<AGROW>

    end
    
    propertiesView  = ['properties (Dependent)' 10 propertiesView 10 'end' 10];
    accessorsView   = ['methods' 10 accessorsView 10 'end' 10];
    mutatorsView    = ['methods' 10 mutatorsView 10 'end' 10];

    constructorView = {'methods', 'function obj = View(app, model)', 'obj@mvc.aView(app, model);', 'end', 'end', ''}; 
    constructorView = matlab.desktop.editor.linesToText(constructorView);
    bodyView        = {'classdef View < mvc.aView', '', propertiesView, constructorView, accessorsView, mutatorsView, 'end', ''};
    bodyView        = matlab.desktop.editor.linesToText(bodyView);

    % Load it up with the lines of code you want in it.
    editorService       = com.mathworks.mlservices.MLEditorServices;
    editorApplication   = editorService.getEditorApplication();
    e                   = editorApplication.newEditor(bodyView);
    e.smartIndentContents
    e.negotiateSave
    
end
