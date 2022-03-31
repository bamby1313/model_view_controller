function appInterface = main()

%% Create the different components
m  = simpleExample_Model();
v1 = simpleExample_View();
c1 = simpleExample_Controller(v1, "Model", m, "Name", "simpleExample_Controller1");
v2 = simpleExample_View2();
c2 = simpleExample_Controller2(v2, "Model", m, "Name", "simpleExample_Controller2");

%% Create the app
appInterface = mvc.utils.loadApp("simpleExample_App", "simpleExample.mlapp", c1, c2);

end
