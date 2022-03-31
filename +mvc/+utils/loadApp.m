function appInterface = loadApp(mvc_app_name, mlapp_name, controllers)
arguments
    mvc_app_name        (1,1) string {mustBeNonzeroLengthText}
    mlapp_name          (1,1) string {mustBeNonzeroLengthText}
end
arguments (Repeating)
    controllers  (:,:) mvc.controller.aController
end

%% Create the mvc.app object
mvc_app = str2func(mvc_app_name);

%% Run the app
appInterface = mvc_app(mlapp_name);

%% Add components
if ~isempty(controllers)
    cellfun(@appInterface.addComponent, controllers)
end

end