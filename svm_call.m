%db1 for the lesser values
%db for the 635 values array
% DISCLAIMER : we are feeding Major Axis and Orientation to the svm. You
% can use the other features too. As SVM graphs are always relative.
% To call any .mat file of the extracted features, you can call them by
% typing :-  load('<Feature>db') or load('<Feature>db1')

area1=load('Areadb');
%disp(area1.Area);
peri1=load('Perimeterdb');
%disp(peri1.Perimeter);
%major1=load('MajorAxisdb');
major1=load('MajorAxisdb1');

%disp(major1.MajorAxis);
minor1=load('MinorAxisdb');
%disp(minor1.MinorAxis);

%orient1=load('Orientationdb');
orient1=load('Orientationdb1');
%disp(orient1.Orientation);

label = [ 'P '; 'P '; 'P '; 'P '; 'P '; 'P '; 'P '; 'P '; 'P ';    'NP'; 'NP'; 'NP'; 'NP'; 'NP'; 'NP'; 'NP'; 'NP';];
one_label = 'NP';
figure;
kernel_function = 'linear';
svm_classifier(orient1.Orientation1,major1.MajorAxis1,label,one_label,kernel_function);
%svm_classifier(major1.MajorAxis,orient1.Orientation,label,one_label,kernel_function);
figure;
kernel_function = 'rbf';
svm_classifier(orient1.Orientation1,major1.MajorAxis1, label,one_label,kernel_function);
%svm_classifier(major1.MajorAxis,orient1.Orientation,label,one_label,kernel_function);


