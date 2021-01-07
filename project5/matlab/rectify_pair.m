function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m
c1=inv(K1*R1)*-(K1*t1); 
c2=inv(K2*R2)*-(K2*t2); 

r1=(c1-c2)/sqrt(sum((c1-c2).*(c1-c2)));
r2=(cross(R1(3,:),r1))';
r3=(cross(r2,r1)) ;

R_new = [r1 r2 r3].';
Kn = K2 ;

t1n = -R_new*c1 ;
t2n = -R_new*c2 ;

R1n = R_new ;
R2n= R_new ;

M1 = (Kn*R_new)*inv(K1*R1) ;
M2 = (Kn*R_new)*inv(K2*R2) ;

K1n = K1 ; 
K2n = K2 ;

P1n = [Kn*R_new -R_new*c1] ;
P2n = [Kn*R_new -R_new*c2] ;





end