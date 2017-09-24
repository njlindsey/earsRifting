function strain_eigvect_2(M)

%function to determine azimuth and plunge 
%of composite principle stress planes for a summed number of earthquake
%records in East Africa;
%
%input is V a 3x3 matrix with columns as eigenvectors determined 
%using the '[V,D]=eig(M)' function --> M is summed seismic
%moment tensor elements from Harvard/Global CMT catalog for region;
%D is the 3x3 diagonalized matrix of associated eigenvalues.
%
%three principle axes (T,N,P)

[V,D]=eig(M)

%IMPORTANT -- SIGN CONVENTIONS FOR EIGENVECTORS
%
%     Mrr   Mrt   Mrp
% M = Mrt   Mtt   Mtp
%     Mrp   Mtp   Mpp
%
%     V11   V12   V13
% V = V21   V22   V23
%     V31   V32   V33
%
%
%
% DEFINE AZIMUTH using second and third elements (y,x) of eigenvectors
%
%   Second element is the y coordinate, convention being +y south 
%
%   Third element is x, convention being +x east
%
%e1
if V(2,1)<0 && V(3,1)>=0
    az1=(180/pi)*(atan(abs(V(3,1)/V(2,1))));
elseif V(2,1)>=0 && V(3,1)>=0
    az1=360-(180/pi)*(atan(abs(V(3,1)/V(2,1))));
elseif V(2,1)>=0 && V(3,1)<0
    az1=(180/pi)*(atan(abs(V(3,1)/V(2,1))));
elseif V(2,1)<0 && V(3,1)<0
    az1=360-(180/pi)*(atan(abs(V(3,1)/V(2,1))));   
end

%e2
if V(2,2)<0 && V(3,2)>=0
    az2=(180/pi)*(atan(abs(V(3,2)/V(2,2))));
elseif V(2,2)>=0 && V(3,2)>=0
    az2=360-(180/pi)*(atan(abs(V(3,2)/V(2,2))));
elseif V(2,2)>=0 && V(3,2)<0
    az2=(180/pi)*(atan(abs(V(3,2)/V(2,2))));
elseif V(2,2)<0 && V(3,2)<0
    az2=360-(180/pi)*(atan(abs(V(3,2)/V(2,2))));   
end

%e3
if V(2,3)<0 && V(3,3)>=0
    az3=(180/pi)*(atan(abs(V(3,3)/V(2,3))));
elseif V(2,3)>=0 && V(3,3)>=0
    az3=360-(180/pi)*(atan(abs(V(3,3)/V(2,3))));
elseif V(2,3)>=0 && V(3,3)<0
    az3=(180/pi)*(atan(abs(V(3,3)/V(2,3))));
elseif V(2,3)<0 && V(3,3)<0
    az3=360-(180/pi)*(atan(abs(V(3,3)/V(2,3))));   
end

%PRINT OUTPUT AZIMUTHS
az1
az2
az3

%plunge
pl1=90-(180/pi)*acos(abs(V(1,1)))
pl2=90-(180/pi)*acos(abs(V(1,2)))
pl3=90-(180/pi)*acos(abs(V(1,3)))


