function strain_eigvect(M)

%function to determine azimuth and plunge 
%of compite principle stress planes for a summed number of earthquake
%records in East Africa;
%
%input is V a 3x3 matrix with columns as eigenvectors determined 
%using the '[V,D]=eig(M)' function --> M is summed seismic
%moment tensor elements from Harvard/Global CMT catalog for region;
%D is the 3x3 diagonalized matrix of associated eigenvalues.
%
%the three principle axes (T,N,P) are determined by logical operators
%
[V,D]=eig(M)

J=[1 0 0;0 1 0;0 0 0];

A=J*V;

%IMPORTANT -- SIGN CONVENTIONS FOR EIGENVECTORS
%
%   x is north
%   y is east
%   z is down
%
%   ex: eigenvector <-0.2,0.999,-0.3> 
%           aximuth will be between 180 and 270
%           plunge will be around 20 degrees
%

%e1
%(0N-90N)
if A(1,1)>0 && A(2,1)>0
    az1=90+(180/pi)*(atan(A(2,1)/A(1,1)));
%(90N-180N)
elseif A(1,1)<0 && A(2,1)>0
    az1=(180/pi)*(atan(A(2,1)/-A(1,1)));
%(180N-270N)
elseif A(1,1)<0 && A(2,1)<0
    az1=270+(180/pi)*(atan(-A(2,1)/-A(1,1)));   
%(270N-360N)
elseif A(1,1)>0 && A(2,1)<0
    az1=180+(180/pi)*(atan(-A(2,1)/A(1,1)));
end

%e2
if A(1,2)>0 && A(2,2)>0
    az2=90+(180/pi)*(atan(A(2,2)/A(1,2)));
elseif A(1,2)<0 && A(2,2)>0
    az2=(180/pi)*(atan(A(2,2)/-A(1,2)));
elseif A(1,2)<0 && A(2,2)<0
    az2=270+(180/pi)*(atan(-A(2,2)/-A(1,2)));
elseif A(1,2)>0 && A(2,2)<0
    az2=180+(180/pi)*(atan(-A(2,2)/A(1,2)));
end

%e3
if A(1,3)>0 && A(2,3)>0
    az3=90+(180/pi)*(atan(A(2,3)/A(1,3)));
elseif A(1,3)<0 && A(2,3)>0
    az3=(180/pi)*(atan(A(2,3)/-A(1,3)));
elseif A(1,3)<0 && A(2,3)<0
    az3=270+(180/pi)*(atan(-A(2,3)/-A(1,3)));
elseif A(1,3)>0 && A(2,3)<0
    az3=180+(180/pi)*(atan(-A(2,3)/A(1,3)));
end

%azimuth
az1=az1
az2=az2
az3=az3

%plunge
pl1=(180/pi)*asin(V(3,1))
pl2=(180/pi)*asin(V(3,2))
pl3=(180/pi)*asin(V(3,3))


