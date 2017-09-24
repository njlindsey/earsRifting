
function EAR_SEISMICITY_GRID
%EAR_SEISMICITY_GRID function to read all NEIC catalog data within a 
%defined lon/lat bounds, convert seismic magnitude(Ms,Mb,Mw,etc.) to moment 
%(Mo), sum moments within a defined lon/lat bin, and output two files to be
%plotted using GMT: outempty, summed moment values < 6.0M; outfilled,
%summed moment values >= 6.0M.
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% VARIABLES
%
% DEFINE NEIC data file
%   pre-sorted into 4 columns: longitude, latitude, magnitude, units; all 
%   header and footer information, along with any extraneous columns and 
%   rows from NEIC catalog have been deleted
clear all
NEIC_file = '/Users/Elli/Linux/Afar/Backups/Computer_backup/*Dead_Macbook/Users/nlindsey/Desktop/GMT/EAR/ears_neic_totalcatalog.mo.lonlat';
HIS_file = '/Users/Elli/Linux/Afar/Backups/Computer_backup/*Dead_Macbook/Users/nlindsey/Desktop/GMT/EAR/historic_earthquakes/HisEQ_mo.txt';

% DEFINE lon/lat bounds
lon_min = 20;
lon_max = 45;
lat_min = -25;
lat_max = 20;


% DEFINE bin step/dimension
%   for 1 degree bins (e.g. 12/12.99N x 30/30.99E) : bin_step=1
%   for 1/2 deg bins (e.g. 12/12.49N x 30/30.49E)  : bin_step=0.5
bin_step = 1;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% PRE-PROCESSING
%
% SORT data from NEIC_file into 3 variables
data=importdata(NEIC_file);
lon=data(:,1);
lat=data(:,2);
mo=data(:,3);

hisdata=importdata(HIS_file)
lon1=hisdata(:,2);
lat1=hisdata(:,1);
moHIS=hisdata(:,3);
%units=hisdata(:,4);

% CONVERT all seismic magnitude values to moment values(Mo)
for i=1:length(lon1)
    %if strcmp(units(i),'MsGS')==1  
    %moHIS(i)=0.8363*moHIS(i)+1.013; %convert Ms to Mw
    %moHIS(i)=10^(1.5*moHIS(i)+10.7); % convert Mw to Mo
%     %    elseif strcmp(units(i),'MwGS')==1
%     %%    elseif strcmp(units(i),'MwHRV')==1      
%             mo(i)=10^(1.5*mo(i)+9.1);
%          elseif strcmp(units(i),'mbGS')==1       
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'UKPAS')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'UKARO')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'MLARO')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'MLAAE')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'MDARO')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'LgBUL')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'MDRYD')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'MLDHMR')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%          elseif strcmp(units(i),'MwGCMT')==1
%              mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%      else mo(i)=10^(1.5*((mo(i)-2.28)/0.67)+9.1);
%      end
end

length(lon)
length(lat)
%lon=[lon;lon1];
%lat=[lat;lat1];
%mo=[mo;moHIS];
length(lon)
length(lat)
mo_matrix=[lon,lat,mo];

% MAKE zeros matrix
out=zeros(((lat_max-lat_min)*(lon_max-lon_min)*2),3);

% MAKE bins in lat and lon using a counter and bin_step
index = 1;
for i = lon_min:bin_step:lon_max
     for j = lat_min:bin_step:lat_max
          out(index,1) = i;
          out(index,2) = j;
          index = index+1;
     end
end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% SUM PROCESS
%
% COMPARE mo_matrix lon/lat values with bin bounds and sum moment values 
% within any bin
for i=1:length(out)
    for j=1:length(mo_matrix)
        if (out(i,1) <= mo_matrix(j,1)) && (out(i,1)+bin_step > mo_matrix(j,1)) && (out(i,2) <= mo_matrix(j,2)) && (out(i,2)+bin_step > mo_matrix(j,2))
            out(i,3) = out(i,3)+mo_matrix(j,3);
        end
    end
end

%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% OUTPUT
%
% Take the log10 of each binned summed moment value [log10(out(i,3)], then 
% scale for correct symbol size [x^3.1*0.000047162]. MAKE 2 matrices to be 
% called by GMT: outfilled with lon,lat,summo values for summo>=M6, and
% outempty with lon,lat,summo values for summo<M6.
outfilled(:,1) = out(:,1);
outfilled(:,2) = out(:,2);
outempty(:,1) = out(:,1);
outempty(:,2) = out(:,2);

for i = 1:length(out)
    if out(i,3) > 0
        %out(i,3) = (log10(out(i,3)))^3.1*0.000047162;
        %out(i,3) = (log10(out(i,3)))^6*(1.75E-9);
        out(i,3) = (log10(out(i,3)));
        if out(i,3) >= 25 % symbol scaled size for Mw=6
            outfilled(i,3) = out(i,3);
        else
            outempty(i,3) = out(i,3);
        end
    end
end


% WRITE outfilled and outempty to separate space-delimited ASCII files with 
% %.3f precision. folder=/Users/nlindsey/Desktop/GMT. Ready to be called by 
% ear_seismicity.gmt
dlmwrite('/Users/Elli/Linux/Afar/Backups/Computer_backup/*Dead_Macbook/Users/nlindsey/Desktop/GMT/out.xy',out,'delimiter',' ','precision','%.3f')
dlmwrite('/Users/Elli/Linux/Afar/Backups/Computer_backup/*Dead_Macbook/Users/nlindsey/Desktop/GMT/outfilled2014.xy',outfilled,'delimiter',' ','precision','%.3f')
dlmwrite('/Users/Elli/Linux/Afar/Backups/Computer_backup/*Dead_Macbook/Users/nlindsey/Desktop/GMT/outempty2014.xy',outempty,'delimiter',' ','precision','%.3f')
%dlmwrite('/Users/Elli/Linux/Afar/Backups/Computer_backup/*Dead_Macbook/Users/nlindsey/Desktop/GMT/outhistoric2014.xy',outhistoric,'delimiter',' ','precision','%.3f')
end

