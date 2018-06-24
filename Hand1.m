    function varargout = Hand1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Hand1_OpeningFcn, ...
                   'gui_OutputFcn',  @Hand1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Hand1 is made visible.
function Hand1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Hand1 (see VARARGIN)

% Choose default command line output for Hand1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Hand1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Hand1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename,filepath] = uigetfile({'*.*';'*.jpg';'*.png';'*.bmp'},'Search Image To Be Displayed');
fullname = [filepath filename];
%now reading the image
ImageFile = imread(fullname);

%displaying the image
myImageName=fullname;
disp(myImageName);
set(handles.pushbutton1, 'UserData', myImageName);
axes(handles.axes1)
imshow(ImageFile);
axis image;
%clear axes scale
axis off

set(handles.text3,'string',fullname);
%update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
I1 = get(handles.pushbutton1,'UserData');
I1=imread(I1);
I1=rgb2gray(I1);%for coloured sample images

I2=Thresholding(I1);

set(handles.pushbutton3, 'UserData', I2);

%displaying image
axes(handles.axes1)
imshow(I2);
axis image;

%clear axes scale
axis off
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
I2 = get(handles.pushbutton3,'UserData');
cc=bwconncomp(I2,8);
n=cc.NumObjects;
%declaring feature variables
    Area1=zeros(n,1);
    Perimeter1=zeros(n,1);
    MajorAxis1=zeros(n,1);
    MinorAxis1=zeros(n,1);
    Orientation1=zeros(n,1);
set(handles.pushbutton4, 'UserData', cc);

disp(cc);%just for trial
disp(n);%just for trial
k=regionprops(cc,'Area','Perimeter','MajorAxisLength','MinorAxisLength','Orientation');
    
    for j=1:n
            Area1(j)=k(j).Area;
            Perimeter1(j)=k(j).Perimeter;
            MajorAxis1(j)=k(j).MajorAxisLength;
            MinorAxis1(j)=k(j).MinorAxisLength;
            Orientation1(j)=k(j).Orientation;
    end  
    disp(Area1);
    disp(Perimeter1);
    disp(MajorAxis1);
    disp(MinorAxis1);
    disp(Orientation1);
    
%displaying image
axes(handles.axes1)
imshow(I2);
axis image;

%clear axes scale
axis off
guidata(hObject, handles);
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
cc = get(handles.pushbutton4,'UserData');
n=cc.NumObjects;
Area1=zeros(n,1);
Perimeter1=zeros(n,1);
MajorAxis1=zeros(n,1);
MinorAxis1=zeros(n,1);
Orientation1=zeros(n,1);
k=regionprops(cc,'Area','Perimeter','MajorAxisLength','MinorAxisLength','Orientation');
    
    for j=1:n
            Area1(j)=k(j).Area;
            Perimeter1(j)=k(j).Perimeter;
            MajorAxis1(j)=k(j).MajorAxisLength;
            MinorAxis1(j)=k(j).MinorAxisLength;
            Orientation1(j)=k(j).Orientation;
    end 
    
    % for major axis
   [r1,c1] = size(MajorAxis1);
   im1= zeros(r1,c1);
  for i=1:r1
    for j=1:c1
        if MajorAxis1(i,j)>=100
            im1(i,j)=1;
        else
            im1(i,j)=0;
        end
    end
  end
    % for orientation
  [r2,c2] = size(Orientation1);
   im2= zeros(r2,c2);
  for p=1:r2
    for q=1:c2
        if Orientation1(p,q)>=-1
            im2(p,q)=1;
        else
            im2(p,q)=0;
        end
    end
  end
  %for major axis
  %counting the number of 0's and 1's
  
  a = unique(im1);
out = [a,histc(im1(:),a)];
disp(im1);
disp(out);
[outr,outc]=size(out);
%if the number of rows of the count matrix is 1, than means, either the
%matrix has only 0's or 1's
if outr==1
    if out(1,1)==0
        countzero=out(1,2);
        countone=0;
    else
        countzero=0;
        countone=out(1,2);
    end    
else
    %if the number of rows of the count matrix is greater than 1, both 1
    %and 0 exist in the matrix and their count as well
    if outr>1
        countzero=out(1,2);
        countone=out(2,2);
    end
end
    disp(countzero);
    disp(countone);
    
    %for orientation
    
    
b = unique(im2);
out2 = [b,histc(im2(:),b)];
disp(im2);
disp(out2);
[outr2,outc2]=size(out2);
if outr2==1
    if out2(1,1)==0
        countzero1=out2(1,2);
        countone1=0;
    else
        countzero1=0;
        countone1=out2(1,2);
    end    
else
    if outr2>1
        countzero1=out2(1,2);
        countone1=out2(2,2);
    end
end
    disp(countzero1);
    disp(countone1);
%for major axis
smallfont='Introspective, not seeking attention, modest';
largefont='Likes being noticed, stands out in a crowd';
midfont='balanced';
if countzero>countone
    set(handles.text3,'string',smallfont);
else
    if countzero<countone
        set(handles.text3,'string',largefont);
    else
        set(handles.text3,'string',midfont);
    end
end
%for orientation
leftslant='Introvert, reserved';
rightslant='Social, responsive, interactive';
vertslant='Practical, independent self-sufficient';
if countzero1>countone1
    set(handles.text4,'string',leftslant);
else
    if countzero1<countone1
        set(handles.text4,'string',rightslant);
    else
        set(handles.text4,'string',vertslant);
    end
end
guidata(hObject, handles);
