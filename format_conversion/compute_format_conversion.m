function compute_format_conversion(name,paths,params)
%
% compute_format_conversion(name,paths,params)
%    converts the given shape to the desired mesh format
%
% inputs:
%    name, name of the file to convert (without extension)
%    params, struct containing the following fields
%       format_in, extension of the file to convert (without dot)
%       format_out, desired extension of the output file (without dot)
%

% read the input mesh format
if strcmp(params.format_in,'mat')
    tmp = load(fullfile(paths.input,[name,'.mat']));
    shape = tmp.shape; clear tmp;
    vertices = [shape.X,shape.Y,shape.Z];
    faces = shape.TRIV;
elseif strcmp(params.format_in,'off')
    [vertices_,faces_] = read_off(fullfile(paths.input,[name,'.off']));
    vertices = vertices_'; clear vertices_;
    faces = faces_'; clear faces_;
elseif strcmp(params.format_in,'ply')
    [vertices_,faces_] = read_ply(fullfile(paths.input,[name,'.ply']));
    vertices = vertices_'; clear vertices_;
    faces = faces_'; clear faces_;
elseif strcmp(params.format_in,'obj')
    [vertices_,faces_] = read_obj(fullfile(paths.input,[name,'.obj']));
    vertices = vertices_'; clear vertices_;
    faces = faces_'; clear faces_;
else
    error('[e] the input format is not supported');
end

% convert to the output mesh format
if strcmp(params.format_out,'mat')
    shape.X = vertices(:,1);
    shape.Y = vertices(:,2);
    shape.Z = vertices(:,3);
    shape.TRIV = faces;
    save(fullfile(paths.output,[name,'.mat']),'shape');
elseif strcmp(params.format_out,'off')
    write_off(fullfile(paths.output,[name,'.off']),vertices,faces);
elseif strcmp(params.format_out,'ply')
    write_ply(vertices,faces,fullfile(paths.output,[name,'.ply']));
else
    error('[e] the output format is not supported');
end
