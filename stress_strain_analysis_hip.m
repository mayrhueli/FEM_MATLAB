model = createpde('structural','static-solid');
importGeometry(model,'hip_steel.stl');

figure
pdegplot(model,'FaceLabels','off','Facealpha', 1.0)
view(30,30);
title('Modell mit eingezeichneten Flächen')

% Boundary Conditions
structuralProperties(model,'YoungsModulus',200e3, ...
                           'PoissonsRatio',0.29);
structuralBC(model,'Face',2,'Constraint','fixed');
structuralBoundaryLoad(model,'Vertex',14,'Force',[0;313.92;0]);

% Mesh generation
mesh = generateMesh(model);
figure
pdeplot3D(model)
title('Diskretisiertes Modell');

result = solve(model);
% Visualize results
maxY = max(result.Displacement.uy);
fprintf('Maximale Verschiebung in y-Richtung ist %g m.', maxY)

figure
pdeplot3D(model,'ColorMapData',result.Displacement.y)
title('Knotenverschiebungen in Meter')
colormap('jet')

figure
pdeplot3D(model,'ColorMapData',result.VonMisesStress)
title('Mises Vergleichsspannung in MPa')
colormap('jet')