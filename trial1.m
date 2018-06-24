clc
clear
close

srcFiles = dir('C:\Users\Sagarika\Desktop\Btech Proj\handwriting dataset\sortedstuff\*.png');  % the folder in which ur images exists
    l=length(srcFiles);
    
    prevn=0;
for i = 1 : l
    filename = strcat('C:\Users\Sagarika\Desktop\Btech Proj\handwriting dataset\sortedstuff\',srcFiles(i).name);
    I = imread(filename);
    
    I2=Thresholding(I);
    %feature Extraction
    cc=bwconncomp(I2,8);
    n=cc.NumObjects;
    con1=cc.Connectivity;
    %disp(cc);
    %disp(n);

    Area=zeros(n,1);
    Perimeter=zeros(n,1);
    MajorAxis=zeros(n,1);
    MinorAxis=zeros(n,1);
    Orientation=zeros(n,1);
    k=regionprops(cc,'Area','Perimeter','MajorAxisLength','MinorAxisLength','Orientation');
    
    for j=1:n
            Area(j)=k(j).Area;
            Perimeter(j)=k(j).Perimeter;
            MajorAxis(j)=k(j).MajorAxisLength;
            MinorAxis(j)=k(j).MinorAxisLength;
            Orientation(j)=k(j).Orientation;
    end  
    
    disp(MajorAxis);
    
    %figure, imshow(I2);
end

%I= imread('sample.png');
