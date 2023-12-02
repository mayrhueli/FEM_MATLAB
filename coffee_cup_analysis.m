model = createpde("thermal","transient");
importGeometry(model,'cup.stl');

figure
pdegplot(model,"VertexLabels","off","EdgeLabels","off",'FaceLabels','on','Facealpha', 1.0)
view(30,30);
title('Modell mit eingezeichneten Flächen')

% Boundary Conditions
thermalProperties(model,"ThermalConductivity",3.8,...
                               "MassDensity",4,...
                               "SpecificHeat",900);
thermalBC(model,"Face",3,"HeatFlux",-10);
thermalBC(model,"Face",[4,6,10,17,18,19,20,22,23,27,31,34,35,36],"Temperature",100);
model.StefanBoltzmannConstant = 5.670367e-8;
thermalIC(model,0);

% Mesh generation
mesh = generateMesh(model);
figure
pdeplot3D(model)
title('Diskretisiertes Modell');

tlist = 0:60:600;
result = solve(model, tlist);

% Visualize results
for i = 1:length(result.SolutionTimes)
  figure
  pdeplot3D(model,"ColorMapData",result.Temperature(:,i))
  title({['Time = ' num2str(result.SolutionTimes(i)) 's']})
end