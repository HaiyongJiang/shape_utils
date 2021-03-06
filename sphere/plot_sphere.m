function sphere = plot_sphere(center,params)

if nargin < 2
    params = struct;
end
if ~isfield(params,'refine')
    params.refine = 2;
end
if ~isfield(params,'radius')
    params.radius = 1;
end
if ~isfield(params,'rgb')
    params.rgb = [0,0,0];
end

tmp = sphere_tri('ico',params.refine,params.radius);

sphere.X    = tmp.vertices(:,1) + center(1);
sphere.Y    = tmp.vertices(:,2) + center(2);
sphere.Z    = tmp.vertices(:,3) + center(3);
sphere.TRIV = tmp.faces;

if params.flag_plot
    %trisurf(sphere.TRIV,sphere.X,sphere.Y,sphere.Z,ones(length(sphere.X),1),'edgecolor','none');
    %colormap(params.rgb);
    patch('Vertices',[sphere.X,sphere.Y,sphere.Z],...
        'Faces',sphere.TRIV,...
        'FaceVertexCData',repmat(params.rgb,length(sphere.X),1),...
        'FaceColor','flat',...
        'EdgeColor','flat');  
end
