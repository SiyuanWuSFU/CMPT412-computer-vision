load('../data/PnP.mat')

pose = estimate_pose(x, X);
[K, R, t] = estimate_params(pose);
size(t)

size(pose);

X = [X; ones(1,size(X,2))];  
coordinate = pose*X;
for i = 1:size(coordinate,2)
    coordinate(:,i) = coordinate(:,i)/coordinate(3,i);
end
coordinate;
figure
imshow(image);
hold on;
plot3(coordinate(1,:),coordinate(2,:),coordinate(3,:), 'bo','MarkerSize',35);
plot(x(1,:),x(2,:), 'r.','MarkerSize',30);
hold off







vertices = R*cad.vertices';

faces = cad.faces;
    


x = vertices(1,:);
y = vertices(2,:);
z = vertices(3,:);


size(vertices);
figure
second_plot = trimesh(faces,x,y,z);
%axis equal
 




projection = K*[R,t];

p_vertice = projection*[cad.vertices';ones(1,size(cad.vertices,1))];

for i = 1:size(p_vertice,2)
    p_vertice(:,i) = p_vertice(:,i)/p_vertice(3,i);
    
end
p_vertice(3,:) = [];


x = p_vertice(1,:);
y = p_vertice(2,:);

i = image;
figure
imshow(i);
hold on
patch('Faces',faces,'Vertices',[x',y'],'FaceColor','red','EdgeColor','red','FaceAlpha','0.2');




   

