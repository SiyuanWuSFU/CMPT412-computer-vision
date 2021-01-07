function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

[U, S, V] = svd(P);
for i = 1:size(V,2)
    V(:,i) = V(:,i)/V(4,i);
    
end
V(4,:) = [];


 
 M = P(:,1:3);

 M = sign(det(M))*M;
 


  reverse = [0, 0, 1 
             0, 1, 0 
             1, 0, 0];

  

  
  Ro_reverse = reverse*M;
  Ro_reverse = sign(det(Ro_reverse'))*Ro_reverse';
  D = diag(sign(diag(Ro_reverse)));
  [Qm, Rm] = qr(Ro_reverse);


  
  
  Q1 = reverse * Qm';
  
  R1 = reverse * Rm' * reverse;
  D = diag(sign(diag(R1)));
  R1 = R1*D;
  
  

  K = R1;
  
  
  R = inv(R1)*M;
  K = K/K(end,end);
%   
%   
%   
%   
%   
%   K = R1;
%   
%   if det(K) < 0
%     K = -K;
%   end
%   
%   R = Q1;
%     
%   %t = inv(K) * t0;
%   
%   M = K*R;
%   
%   %t = inv(M)*(-t0);
  t = -R*V(:,4);

  
end