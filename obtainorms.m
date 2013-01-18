function norms = obtainnorms(objboundary, k0, k1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates two k curves by using k0 and k1, and generate
% normal for each boundary point by adding them up
%
% norms = obtainnorms(objboundary, k0, k1)
% objboundary : object boundary clouds
% k0 : the first two points that are employed to compute normal0
% k1 : the second two points that are employed to compute normal1
% norm : norm(normal0+normal1)
%
% Note that it does not matter wheather the surface normals are pointing
% outside or inside surface as their directions compromise each other
%
% Author: Weiwei Wan, The University of Tokyo
% Data: 03-07-2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  row = size(objboundary, 1);
  rotmatcc = [[0,-1];[1,0]];
  rotmatc = [[0,1];[-1,0]];
  boundarynv = repmat([0,0], row, 1);
  for item = 1:row
    idxpre0 = item - k0;
    idxnxt0 = item + k0;
    idxpre1 = item - k1;
    idxnxt1 = item + k1;
    if idxpre0 < 1
      idxpre0 = idxpre0+row;
    end
    if idxnxt0 > row
      idxnxt0 = idxnxt0-row;
    end
    if idxpre1 < 1
      idxpre1 = idxpre1+row;
    end
    if idxnxt1 > row
      idxnxt1 = idxnxt1-row;
    end
    % Here we rotate the previous one counter-clockwise while rotate the next
    % one clockwise
    point = objboundary(item, :);
    pointpre0 = objboundary(idxpre0, :);
    pointnxt0 = objboundary(idxnxt0, :);
    vpre0 = pointpre0-point;
    vnxt0 = pointnxt0-point;
    nvpre0 = vpre0/norm(vpre0);
    nvnxt0 = vnxt0/norm(vnxt0);
    orthnvpre0 = (rotmatc*nvpre0')';
    orthnvnxt0 = (rotmatcc*nvnxt0')';
    
    pointpre1 = objboundary(idxpre1, :);
    pointnxt1 = objboundary(idxnxt1, :);
    vpre1 = pointpre1-point;
    vnxt1 = pointnxt1-point;
    nvpre1 = vpre1/norm(vpre1);
    nvnxt1 = vnxt1/norm(vnxt1);
    orthnvpre1 = (rotmatc*nvpre1')';
    orthnvnxt1 = (rotmatcc*nvnxt1')';
    
    orthv = orthnvpre0+orthnvnxt0+orthnvpre1+orthnvnxt1;
    orthnv = orthv/norm(orthv);
    boundarynv(item, 1) = orthnv(1);
    boundarynv(item, 2) = orthnv(2);
  end
  
  norms = boundarynv;
