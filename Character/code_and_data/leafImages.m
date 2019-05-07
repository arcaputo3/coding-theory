
% Import leaf image
I = imread('leaf8.png');

% Convert to black and white image
BW = im2bw(I);
BW = imcomplement(I);
BW = imfill(I,'holes');


%{
% Import leaf image
I = imread('leaf5.jpg');

% Convert to black and white image
BW = im2bw(I);
BW = imcomplement(BW);
BW = imfill(BW,'holes');
%}

% Detect boundary 
dim = size(BW);
col = round(dim(2)/2)-90;
row = min(find(BW(:,col)));
boundary = bwtraceboundary(BW,[row, col],'S');

% Plot leaf image with boundary
%{
imshow(BW)
hold on;
plot(boundary(:,2),boundary(:,1),'r','LineWidth',3);
%}
% Initial boundary
C = boundary;

%{
% Smoothing using geometric heat equation
for dt = 0.01:0.01:0.8
    N = LineNormals2D(C);
    K = LineCurvature2D(C);
    d = dt*N.*K;
    % Delete points that would intersect
    % Gives 'decreased length' of curve
    [row,~] = find(abs(d) >= 1);
    C(row,:) = [];
    d(row,:) = [];
    C = C - d;
    % Clear isnan (non differentiable points)
    [row,col] = find(isnan(C));
    C(row,:) = [];
end
%}

%plot(C(:,2),C(:,1),'g','LineWidth',2)

%{
% Plot smoothed curve and normals
plot(C(:,2),C(:,1),'g','LineWidth',2)
hold on;
%plot(boundary(:,2),boundary(:,1),'r','LineWidth',1)
plot([C(:,2) C(:,2)+10*N(:,2)]',[C(:,1) C(:,1)+10*N(:,1)]');
%}

% Medial Axis
z = C(:,2) + C(:,1)*1i;
C = [real(z),imag(z)];
z = C(:,1)' + C(:,2)'*1i;

% This code assumes a polygon is given by a vector z of complex numbers
plot(z,'-*'), hold on, axis equal
xmax = max(real(z)); xmin = min(real(z)); ymax = max(imag(z)); ymin = min(imag(z));
maxlen = max((xmax-xmin), (ymax-ymin))/20;

% Get Delaunay triangles and compute their circumcenters
tri = sort(delaunay(real(z),imag(z))')';
u = z(tri(:,1)); v = z(tri(:,2)); w = z(tri(:,3));
dot = (u-w).*conj(v-w);
m = (u+v+1i*(u-v).*real(dot)./imag(dot))/2;
r = abs(u-m);

% Prune the exterior triangles. m is now the vertices of the medial axis
inside = imag(dot) < 0;
triin = tri(inside,:);
m = m(inside); r = r(inside);
nt = size(triin,1);

% Find edges of the medial axis
B = sparse([1:nt 1:nt 1:nt], triin(:), ones(1,3*nt));
[a,b,c] = find(B*B'>1);
ind = a>b; a = a(ind); b = b(ind);
plot([m(a); m(b)], '-')
%plot(m(a));
%{
% Subdivide long segments in the medial axis
numsub = ceil(abs(m(a)-m(b))/maxlen);
ind = numsub > 1; 
delta = 1./numsub(ind);
newm = m(a(ind))*(delta:delta:1-delta) + m(b(ind))*((1-delta):-delta:delta);
newr = abs(newm - z(dsearchn([real(z), imag(z)], tri, [real(newm), imag(newm)])));
m = [m newm]; r = [r newr];
nm = size(m,2);
plot(m,'*') 
%}
