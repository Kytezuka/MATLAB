%Group Name: Struggle Bus
%Members' Names: Trey Athey, Kyle Alexander Howser, Kairi Yoon Tezuka
%Members' IDs (in respective order): 999712027, 912210470, 912310998
%Members' Sections (in respective order): A06, A05, A04
%Date: 03/13/2016


%% DO NOT TOUCH
function varargout = AudioProjectGUI(varargin)
%AUDIOPROJECTGUI M-file for AudioProjectGUI.fig
%      AUDIOPROJECTGUI, by itself, creates a new AUDIOPROJECTGUI or raises the existing
%      singleton*.
%
%      H = AUDIOPROJECTGUI returns the handle to a new AUDIOPROJECTGUI or the handle to
%      the existing singleton*.
%
%      AUDIOPROJECTGUI('Property','Value',...) creates a new AUDIOPROJECTGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to AudioProjectGUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      AUDIOPROJECTGUI('CALLBACK') and AUDIOPROJECTGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in AUDIOPROJECTGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help_chopping AudioProjectGUI

% Last Modified by GUIDE v2.5 15-Mar-2016 18:09:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AudioProjectGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @AudioProjectGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before AudioProjectGUI is made visible.
function AudioProjectGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for AudioProjectGUI
handles.output = hObject;

[y x]=audioread('Microsoft_Windows_XP_Startup_Sound.wav');
sound(y,x)

axes(handles.Trey)
imshow('TreyA.jpeg')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AudioProjectGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AudioProjectGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% Audio Play Back
% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla reset 
clear sound
audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
stereoExist=isfield(handles,'stereoValue'); %creating a logical array which indicates the existance of the field "stereoValue"
monoExist=isfield(handles,'monoValue'); %creating a logical array which indicates the existance of the field "monoValue"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please select a sample to be played first.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
elseif stereoExist==0
     [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please select Stereo or Monofirst.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
elseif monoExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please select Stereo or Mono first.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
elseif monoExist==1
    monoValue=handles.monoValue;
    monoLValue=handles.monoLValue;
    monoRValue=handles.monoRValue;
    if monoValue==1
        [amplitude,fq]=audioread(handles.audioFile);
        %amplitude is 2 column matrix and left and right side of the audio info is stored in respective columns
        %taking the average of 2 columns will convert stereo to mono
        monoAmplitude=(amplitude(:,1)+amplitude(:,2))/2;
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        handles.t=t; %stores time in the structure "handles"
        [row col]=size(amplitude);
        handles.row=row; 
        conversion=row/t(end);
        handles.conversion=conversion;
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,monoAmplitude,'k'); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf(handles.audioFile)); %changes the title of the graph to the title of the audio file
        xlabel('Time(s)');
        ylabel('Amplitude');
        handles.audio=audioplayer(monoAmplitude,fq); %storing the amplitude and frequeny as audioplayer file 
        stop(handles.audio); %stops the audio playing previously 
        play(handles.audio); %plays the audio
    elseif monoLValue==1
        [amplitude,fq]=audioread(handles.audioFile);
        monoLAmplitude=amplitude(:,1);
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        handles.t=t; %stores time in the structure "handles"
        [row col]=size(amplitude);
        handles.row=row; 
        conversion=row/t(end);
        handles.conversion=conversion;
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,monoLAmplitude); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf(handles.audioFile)); %changes the title of the graph to the title of the audio file
        xlabel('Time(s)');
        ylabel('Amplitude');
        handles.audio=audioplayer(monoLAmplitude,fq); %storing the amplitude and frequeny as audioplayer file 
        stop(handles.audio); %stops the audio playing previously 
        play(handles.audio); %plays the audio
    elseif monoRValue==1
        [amplitude,fq]=audioread(handles.audioFile);
        monoRAmplitude=amplitude(:,2);
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        handles.t=t; %stores time in the structure "handles"
        [row col]=size(amplitude);
        handles.row=row; 
        conversion=row/t(end);
        handles.conversion=conversion;
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,monoRAmplitude,'color',[1 .5 0]); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf(handles.audioFile)); %changes the title of the graph to the title of the audio file
        xlabel('Time(s)');
        ylabel('Amplitude');
        handles.audio=audioplayer(monoRAmplitude,fq); %storing the amplitude and frequeny as audioplayer file 
        stop(handles.audio); %stops the audio playing previously 
        play(handles.audio); %plays the audio
    else
        [amplitude, fq]=audioread(handles.audioFile); %obtaining the amplitude and the frequency of the selected audio file
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        handles.t=t; %stores time in the structure "handles"
        [row col]=size(amplitude);
        handles.row=row; 
        conversion=row/t(end);
        handles.conversion=conversion;
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,amplitude); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf(handles.audioFile)); %changes the title of the graph to the title of the audio file
        xlabel('Time(s)');
        ylabel('Amplitude');
        handles.audio=audioplayer(amplitude,fq); %storing the amplitude and frequeny as audioplayer file 
        stop(handles.audio); %stops the audio playing previously 
        play(handles.audio); %plays the audio
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Pause.
function Pause_Callback(hObject, eventdata, handles)
% hObject    handle to Pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please select a sample to be played first.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    pause(handles.audio); %pauses the audio being played
end


% --- Executes on button press in Resume.
function Resume_Callback(hObject, eventdata, handles)
% hObject    handle to Resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please select a sample to be played first.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    resume(handles.audio); %resume the audio being paused
end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound
audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please select a sample to be played first.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else 
    stop(handles.audio)
end



%% Basic Audio File Input 
% Sounds Files 
% All of the Load Buttons
% --- Executes on button press in Load1.
function Load1_Callback(hObject, eventdata, handles)
% hObject    handle to Load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude1=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq1=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile1=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample1, 'String', handles.audioFile1, 'Backgroundcolor','cyan');
    %changes the label 'Sample 1' to the name of the audio file loaded
    %changes the color of the Sample 1 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load2.
function Load2_Callback(hObject, eventdata, handles)
% hObject    handle to Load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude2=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq2=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile2=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample2, 'String', handles.audioFile2, 'Backgroundcolor','cyan');
    %changes the label 'Sample 2' to the name of the audio file loaded
    %changes the color of the Sample 2 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load3.
function Load3_Callback(hObject, eventdata, handles)
% hObject    handle to Load3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude3=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq3=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile3=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample3, 'String', handles.audioFile3, 'Backgroundcolor','cyan');
    %changes the label 'Sample 3' to the name of the audio file loaded
    %changes the color of the Sample 3 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load4.
function Load4_Callback(hObject, eventdata, handles)
% hObject    handle to Load4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude4=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq4=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile4=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample4, 'String', handles.audioFile4, 'Backgroundcolor','cyan');
    %changes the label 'Sample 4' to the name of the audio file loaded
    %changes the color of the Sample 4 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load5.
function Load5_Callback(hObject, eventdata, handles)
% hObject    handle to Load5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude5=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq5=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile5=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample5, 'String', handles.audioFile5, 'Backgroundcolor','cyan');
    %changes the label 'Sample 5' to the name of the audio file loaded
    %changes the color of the Sample 5 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace



% --- Executes on button press in Load6.
function Load6_Callback(hObject, eventdata, handles)
% hObject    handle to Load6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude6=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq6=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile6=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample6, 'String', handles.audioFile6, 'Backgroundcolor','cyan');
    %changes the label 'Sample 6' to the name of the audio file loaded
    %changes the color of the Sample 6 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load7.
function Load7_Callback(hObject, eventdata, handles)
% hObject    handle to Load7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude7=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq7=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile7=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample7, 'String', handles.audioFile7, 'Backgroundcolor','cyan');
    %changes the label 'Sample 7' to the name of the audio file loaded
    %changes the color of the Sample 7 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load8.
function Load8_Callback(hObject, eventdata, handles)
% hObject    handle to Load8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude8=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq8=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile8=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample8, 'String', handles.audioFile8, 'Backgroundcolor','cyan');
    %changes the label 'Sample 8' to the name of the audio file loaded
    %changes the color of the Sample 8 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load9.
function Load9_Callback(hObject, eventdata, handles)
% hObject    handle to Load9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude9=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq9=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile9=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample9, 'String', handles.audioFile9, 'Backgroundcolor','cyan');
    %changes the label 'Sample 9' to the name of the audio file loaded
    %changes the color of the Sample 9 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load10.
function Load10_Callback(hObject, eventdata, handles)
% hObject    handle to Load10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude10=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq10=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile10=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample10, 'String', handles.audioFile10, 'Backgroundcolor','cyan');
    %changes the label 'Sample 10' to the name of the audio file loaded
    %changes the color of the Sample 10 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load11.
function Load11_Callback(hObject, eventdata, handles)
% hObject    handle to Load11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude11=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq11=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile11=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample11, 'String', handles.audioFile11, 'Backgroundcolor','cyan');
    %changes the label 'Sample 11' to the name of the audio file loaded
    %changes the color of the Sample 11 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load12.
function Load12_Callback(hObject, eventdata, handles)
% hObject    handle to Load12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude12=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq12=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile12=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample12, 'String', handles.audioFile12, 'Backgroundcolor','cyan');
    %changes the label 'Sample 12' to the name of the audio file loaded
    %changes the color of the Sample 12 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load13.
function Load13_Callback(hObject, eventdata, handles)
% hObject    handle to Load13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude13=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq13=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile13=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample13, 'String', handles.audioFile13, 'Backgroundcolor','cyan');
    %changes the label 'Sample 13' to the name of the audio file loaded
    %changes the color of the Sample 13 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load14.
function Load14_Callback(hObject, eventdata, handles)
% hObject    handle to Load14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude14=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq14=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile14=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample14, 'String', handles.audioFile14, 'Backgroundcolor','cyan');
    %changes the label 'Sample 14' to the name of the audio file loaded
    %changes the color of the Sample 14 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load15.
function Load15_Callback(hObject, eventdata, handles)
% hObject    handle to Load15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude15=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq15=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile15=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample15, 'String', handles.audioFile15, 'Backgroundcolor','cyan');
    %changes the label 'Sample 15' to the name of the audio file loaded
    %changes the color of the Sample 15 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Load16.
function Load16_Callback(hObject, eventdata, handles)
% hObject    handle to Load16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFile=uigetfile('*.wav','Please choose a .wav file to load.');
%uigetfile allows the user to choose a file they want to load
%'*.wav' restricts the type of the file they can load

if audioFile~=0
    [amplitude fq]=audioread(audioFile); %obtaining the amplitude and the time of the file
    handles.amplitude16=amplitude; %storing the amplitude of the file to the structure "handles"
    handles.fq16=fq; %storing the frequency of the file to the structure "handles"
    handles.audioFile16=audioFile; %storing the name of the file to the structure "handles"

    set(handles.Sample16, 'String', handles.audioFile16, 'Backgroundcolor','cyan');
    %changes the label 'Sample 16' to the name of the audio file loaded
    %changes the color of the Sample 16 button when the file is loaded
end

guidata(hObject,handles); %updating the handles on the global workspace


%All of the Sample Buttons
% --- Executes on button press in Sample1.
function Sample1_Callback(hObject, eventdata, handles)
% hObject    handle to Sample1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile1');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile1; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample1,'Backgroundcolor','green');
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample2.
function Sample2_Callback(hObject, eventdata, handles)
% hObject    handle to Sample2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile2');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile2; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample2,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample3.
function Sample3_Callback(hObject, eventdata, handles)
% hObject    handle to Sample3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile3');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile3; %stores/updates the name of the audio file to be played to the selected button
set(handles.Sample3,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample4.
function Sample4_Callback(hObject, eventdata, handles)
% hObject    handle to Sample4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile4');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile4; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample4,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample5.
function Sample5_Callback(hObject, eventdata, handles)
% hObject    handle to Sample5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile5');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile5; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample5,'Backgroundcolor','green');
    if colorSample5==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample6.
function Sample6_Callback(hObject, eventdata, handles)
% hObject    handle to Sample6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile6');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile6; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample6,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample7.
function Sample7_Callback(hObject, eventdata, handles)
% hObject    handle to Sample7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile7');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile7; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample7,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample8.
function Sample8_Callback(hObject, eventdata, handles)
% hObject    handle to Sample8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile8');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile8; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample8,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample9.
function Sample9_Callback(hObject, eventdata, handles)
% hObject    handle to Sample9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile9');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile9; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample9,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample10.
function Sample10_Callback(hObject, eventdata, handles)
% hObject    handle to Sample10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile10');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile10; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample10,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample11.
function Sample11_Callback(hObject, eventdata, handles)
% hObject    handle to Sample11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile11');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile11; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample11,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample12.
function Sample12_Callback(hObject, eventdata, handles)
% hObject    handle to Sample12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile12');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile12; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample12,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end
    
    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample13.
function Sample13_Callback(hObject, eventdata, handles)
% hObject    handle to Sample13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile13');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile13; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample13,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end
    
    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample14==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample14.
function Sample14_Callback(hObject, eventdata, handles)
% hObject    handle to Sample14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile14');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile14; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample14,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end
    
    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample15.
function Sample15_Callback(hObject, eventdata, handles)
% hObject    handle to Sample15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile15');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile15; %stores/updates the name of the audio file to be played to the selected button
    set(handles.Sample15,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end
    
    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample16==default;
    set(handles.Sample16,'Backgroundcolor',default);
    else
    set(handles.Sample16,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Sample16.
function Sample16_Callback(hObject, eventdata, handles)
% hObject    handle to Sample16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

default=[0.9400 0.9400 0.9400];
colorSample1=get(handles.Sample1,'Backgroundcolor');
colorSample2=get(handles.Sample2,'Backgroundcolor');
colorSample3=get(handles.Sample3,'Backgroundcolor');
colorSample4=get(handles.Sample4,'Backgroundcolor');
colorSample5=get(handles.Sample5,'Backgroundcolor');
colorSample6=get(handles.Sample6,'Backgroundcolor');
colorSample7=get(handles.Sample7,'Backgroundcolor');
colorSample8=get(handles.Sample8,'Backgroundcolor');
colorSample9=get(handles.Sample9,'Backgroundcolor');
colorSample10=get(handles.Sample10,'Backgroundcolor');
colorSample11=get(handles.Sample11,'Backgroundcolor');
colorSample12=get(handles.Sample12,'Backgroundcolor');
colorSample13=get(handles.Sample13,'Backgroundcolor');
colorSample14=get(handles.Sample14,'Backgroundcolor');
colorSample15=get(handles.Sample15,'Backgroundcolor');
colorSample16=get(handles.Sample16,'Backgroundcolor');

audioFileExist=isfield(handles,'audioFile16');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
else
    handles.audioFile=handles.audioFile16; %stores/updates the name of the audio file to be played to the selected button
set(handles.Sample16,'Backgroundcolor','green');
    if colorSample1==default;
    set(handles.Sample1,'Backgroundcolor',default);
    else
    set(handles.Sample1,'Backgroundcolor','cyan');
    end
    
    if colorSample2==default;
    set(handles.Sample2,'Backgroundcolor',default);
    else
    set(handles.Sample2,'Backgroundcolor','cyan');
    end
    
    if colorSample3==default;
    set(handles.Sample3,'Backgroundcolor',default);
    else
    set(handles.Sample3,'Backgroundcolor','cyan');
    end
    
    if colorSample4==default;
    set(handles.Sample4,'Backgroundcolor',default);
    else
    set(handles.Sample4,'Backgroundcolor','cyan');
    end
    
    if colorSample5==default;
    set(handles.Sample5,'Backgroundcolor',default);
    else
    set(handles.Sample5,'Backgroundcolor','cyan');
    end
    
    if colorSample6==default;
    set(handles.Sample6,'Backgroundcolor',default);
    else
    set(handles.Sample6,'Backgroundcolor','cyan');
    end
    
    if colorSample7==default;
    set(handles.Sample7,'Backgroundcolor',default);
    else
    set(handles.Sample7,'Backgroundcolor','cyan');
    end
    
    if colorSample8==default;
    set(handles.Sample8,'Backgroundcolor',default);
    else
    set(handles.Sample8,'Backgroundcolor','cyan');
    end
    
    if colorSample9==default;
    set(handles.Sample9,'Backgroundcolor',default);
    else
    set(handles.Sample9,'Backgroundcolor','cyan');
    end

    if colorSample10==default;
    set(handles.Sample10,'Backgroundcolor',default);
    else
    set(handles.Sample10,'Backgroundcolor','cyan');
    end
    
    if colorSample11==default;
    set(handles.Sample11,'Backgroundcolor',default);
    else
    set(handles.Sample11,'Backgroundcolor','cyan');
    end
    
    if colorSample12==default;
    set(handles.Sample12,'Backgroundcolor',default);
    else
    set(handles.Sample12,'Backgroundcolor','cyan');
    end
    
    if colorSample13==default;
    set(handles.Sample13,'Backgroundcolor',default);
    else
    set(handles.Sample13,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample14,'Backgroundcolor',default);
    else
    set(handles.Sample14,'Backgroundcolor','cyan');
    end
    
    if colorSample15==default;
    set(handles.Sample15,'Backgroundcolor',default);
    else
    set(handles.Sample15,'Backgroundcolor','cyan');
    end
end

guidata(hObject,handles); %updating the handles on the global workspace


% Mono/Mono Buttons
% --- Executes on button press in Mono.
function Stereo_Callback(hObject, eventdata, handles)
% hObject    handle to Mono (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

monoValue=0;
monoLValue=0;
monoRValue=0;
stereoValue=1;

%storing the variables created to the strucutre "handles"
handles.monoValue=monoValue;
handles.stereoValue=stereoValue;
handles.monoLValue=monoLValue;
handles.monoRValue=monoRValue;

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Mono.
function Mono_Callback(hObject, eventdata, handles)
% hObject    handle to Mono (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

monoValue=1;
monoLValue=0;
monoRValue=0;
stereoValue=0;

%storing the variables created to the strucutre "handles"
handles.monoValue=monoValue;
handles.stereoValue=stereoValue;
handles.monoLValue=monoLValue;
handles.monoRValue=monoRValue;

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Mono_L.
function Mono_L_Callback(hObject, eventdata, handles)
% hObject    handle to Mono_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

monoValue=0;
monoLValue=1;
monoRValue=0;
stereoValue=0;

%storing the variables created to the strucutre "handles"
handles.monoValue=monoValue;
handles.stereoValue=stereoValue;
handles.monoLValue=monoLValue;
handles.monoRValue=monoRValue;

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Mono_R.
function Mono_R_Callback(hObject, eventdata, handles)
% hObject    handle to Mono_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

monoValue=0;
monoLValue=0;
monoRValue=1;
stereoValue=0;

%storing the variables created to the strucutre "handles"
handles.monoValue=monoValue;
handles.stereoValue=stereoValue;
handles.monoLValue=monoLValue;
handles.monoRValue=monoRValue;

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Help_Mono_Stereo.
function Help_Mono_Stereo_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Mono_Stereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

helpdlg({'Stereo will not apply to','a mono audio file.'},'Mono/Stereo Help') %displays a help message when the button is pressed



%% Chopping
% --- Executes on button press in Chop.
function Chop_Callback(hObject, eventdata, handles)
% hObject    handle to Chop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%creating a logical arrays which shows whether the fields (Start_Min, Start_Sec, End_Min or End_Sec) exists 
%if any one of these fields do not exist (meaning the user has not specified the time frame) the "if" loop below will generate an error dialog 
clear sound
stop(handles.audio)

chopSMExist=isfield(handles,'Start_Min');
chopSSExist=isfield(handles,'Start_Sec');
chopEMExist=isfield(handles,'End_Min');
chopESExist=isfield(handles,'End_Sec');

audioFileExist=isfield(handles,'audioFile');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
elseif chopSMExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please specifiy the times frame.','ERROR!','modal') %generates an error message if the user has not specified a time frame
elseif chopSSExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please specifiy the times frame.','ERROR!','modal') %generates an error message if the user has not specified a time frame
elseif chopEMExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please specifiy the times frame.','ERROR!','modal') %generates an error message if the user has not specified a time frame
elseif chopESExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please specifiy the times frame.','ERROR!','modal') %generates an error message if the user has not specified a time frame
else
    startMin=str2double(get(handles.Chopping_Start_Min,'String')); %converting the contents entered in the edit box from class char to class double
    startSec=str2double(get(handles.Chopping_Start_Sec,'String')); %converting the contents entered in the edit box from class char to class double
    endMin=str2double(get(handles.Chopping_End_Min,'String')); %converting the contents entered in the edit box from class char to class double
    endSec=str2double(get(handles.Chopping_End_Sec,'String')); %converting the contents entered in the edit box from class char to class double
    startTime=startMin*60+startSec; %converting the user input start min to seconds and adding it to start seconds
    endTime=endMin*60+endSec; %converting the user input end min to seconds and adding it to end seconds

    %storing the valuables created above in the structure "handles"
    handles.startMin=startMin;
    handles.startSec=startSec;
    handles.endMin=endMin;
    handles.endSec=endSec;
    handles.startTime=startTime;
    handles.endTime=endTime;
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in PlayChopp.
function PlayChopp_Callback(hObject, eventdata, handles)
% hObject    handle to PlayChopp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audioFileExist=isfield(handles,'audioFile');
startTimeExist=isfield(handles,'startTime');
endTimeExist=isfield(handles,'endTime');
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please load an audio file (.wav) first.','ERROR!','modal') %generates an error message if the user has not loaded an audiofile
elseif startTimeExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please chop an audio file first.','ERROR!','modal') %generates an error message if the user has not chopped an audiofile
elseif endTimeExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('Please chop an audio file first.','ERROR!','modal') %generates an error message if the user has not chopped an audiofile
else
    startMin=handles.startMin;
    startSec=handles.startSec;
    endMin=handles.endMin;
    endSec=handles.endSec;
    startTime=handles.startTime;
    endTime=handles.endTime;
    [amplitude fq]=audioread(handles.audioFile);
    conversion=handles.conversion;
    amplitudeChop=amplitude(startTime*conversion:endTime*conversion,:);
    t=[1/fq:1/fq:length(amplitudeChop)/fq]; %generating the time to be used to when plotting the audio file
    axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
    plot(t,amplitudeChop); %plots the audio file
    title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
    title(sprintf('%s (%s %.0f:%.0f to %.0f:%.0f)',handles.audioFile,'Chopped from',startMin,startSec,endMin,endSec)); %changes the title of the graph to the title of the audio file and the effects being applied
    xlabel('Time(s)');
    ylabel('Amplitude');
    handles.audioChopped=audioplayer(amplitudeChop, fq); %storing the amplitude and frequeny as audioplayer file 
    play(handles.audioChopped);
end

guidata(hObject,handles); %updating the handles on the global workspace


function Chopping_Start_Min_Callback(hObject, eventdata, handles)
% hObject    handle to Chopping_Start_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Start_Min=handles.Chopping_Start_Min;

guidata(hObject,handles); %updating the handles on the global workspace

% Hints: get(hObject,'String') returns contents of Chopping_Start_Min as text
%        str2double(get(hObject,'String')) returns contents of Chopping_Start_Min as a double


% --- Executes during object creation, after setting all properties.
function Chopping_Start_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Chopping_Start_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Chopping_Start_Sec_Callback(hObject, eventdata, handles)
% hObject    handle to Chopping_Start_Sec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Start_Sec=handles.Chopping_Start_Sec;

guidata(hObject,handles); %updating the handles on the global workspace

% Hints: get(hObject,'String') returns contents of Chopping_Start_Sec as text
%        str2double(get(hObject,'String')) returns contents of Chopping_Start_Sec as a double


% --- Executes during object creation, after setting all properties.
function Chopping_Start_Sec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Chopping_Start_Sec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Chopping_End_Min_Callback(hObject, eventdata, handles)
% hObject    handle to Chopping_End_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.End_Min=handles.Chopping_End_Min;

guidata(hObject,handles); %updating the handles on the global workspace

% Hints: get(hObject,'String') returns contents of Chopping_End_Min as text
%        str2double(get(hObject,'String')) returns contents of Chopping_End_Min as a double


% --- Executes during object creation, after setting all properties.
function Chopping_End_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Chopping_End_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Chopping_End_Sec_Callback(hObject, eventdata, handles)
% hObject    handle to Chopping_End_Sec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.End_Sec=handles.Chopping_End_Sec;

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes during object creation, after setting all properties.
function Chopping_End_Sec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Chopping_End_Sec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Help_Chopping.
function Help_Chopping_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Chopping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

helpdlg({'Chopping function will not work','if the time frame you chose','exceeds the duration of the song.'},'Chopping Help') %displays a help message when the button is pressed



%% Basic Tone Generation (Synthesizer)
%custom made function
function pianoSound=PianoPlayer(piano,handles,hObject,eventdata)
amplitudePiano=1; %amplitude of the note to be played
fqPiano=piano; %frequency of desired note to be played
fqSample=8000; %sample frequency
time=0:1/fqSample:1; %duration of the note

clear sound
sineExist=isfield(handles,'sine'); %checking to see if the field sine exist
if sineExist==0 %if the field sine does not exist, it will play the note with default wave function format
        y=amplitudePiano*sin(2*pi*fqPiano*time); %generating the y component of the sound to be played
else %when a button is pressed the value of the respective field is changed to 1
    sine=handles.sine; %extracting the value from the structure "handles" and storing it as class double
    square1=handles.square; %extracting the value from the structure "handles" and storing it as class double
    triangle=handles.triangle; %extracting the value from the structure "handles" and storing it as class double
    sawtooth1=handles.sawtooth; %extracting the value from the structure "handles" and storing it as class double
    if sine==1; %if the value of the sine is 1, this will set the wave manipulation to sine wave 
        y=amplitudePiano*sin(2*pi*fqPiano*time); %generating the y component of the sound to be played
    elseif square1==1 %if the value of the square is 1, this will set the wave manipulation to square wave 
        y=amplitudePiano*square(2*pi*fqPiano*time); %generating the y component of the sound to be played
    elseif triangle==1 %if the value of the triangle is 1, this will set the wave manipulation to triangular wave 
        y=amplitudePiano*sawtooth(2*pi*fqPiano*time,0.5); %generating the y component of the sound to be played
    elseif sawtooth1==1 %if the value of the sawtooth is 1, this will set the wave manipulation to sawtooth wave 
        y=amplitudePiano*sawtooth(2*pi*fqPiano*time); %generating the y component of the sound to be played
    end
end
sound(y,fqSample);

%frequency of the piano keys starts with C4 (middel C)
%C=261.63;
%CD=277.18;
%D=293.67;
%DE=311.13;
%E=329.63;
%F=349.23;
%FG=369.99;
%G=392.00;
%GA=415.30;
%A=440.00;
%AB=466.16;
%B=493.88;
%CC=523.25;
%CCDD=554.37;
%DD=587.33;
%DDEE=622.25;
%EE=659.26;


% --- Executes on button press in C.
function C_Callback(hObject, eventdata, handles)
% hObject    handle to C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

C=261.63; %frequency of the note
PianoPlayer(C,handles,hObject,eventdata)


% --- Executes on button press in CD.
function CD_Callback(hObject, eventdata, handles)
% hObject    handle to CD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CD=277.18; %frequency of the note
PianoPlayer(CD,handles,hObject,eventdata)


% --- Executes on button press in D.
function D_Callback(hObject, eventdata, handles)
% hObject    handle to D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

D=293.67; %frequency of the note
PianoPlayer(D,handles,hObject,eventdata)


% --- Executes on button press in DE.
function DE_Callback(hObject, eventdata, handles)
% hObject    handle to DE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DE=311.13; %frequency of the note
PianoPlayer(DE,handles,hObject,eventdata)


% --- Executes on button press in E.
function E_Callback(hObject, eventdata, handles)
% hObject    handle to E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

E=329.63; %frequency of the note
PianoPlayer(E,handles,hObject,eventdata)


% --- Executes on button press in F.
function F_Callback(hObject, eventdata, handles)
% hObject    handle to F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

F=349.23; %frequency of the note
PianoPlayer(F,handles,hObject,eventdata)


% --- Executes on button press in FG.
function FG_Callback(hObject, eventdata, handles)
% hObject    handle to FG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FG=369.99; %frequency of the note
PianoPlayer(FG,handles,hObject,eventdata)


% --- Executes on button press in G.
function G_Callback(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

G=392.00; %frequency of the note
PianoPlayer(G,handles,hObject,eventdata)


% --- Executes on button press in GA.
function GA_Callback(hObject, eventdata, handles)
% hObject    handle to GA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

GA=415.30; %frequency of the note
PianoPlayer(GA,handles,hObject,eventdata)


% --- Executes on button press in A.
function A_Callback(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A=440.00; %frequency of the note
PianoPlayer(A,handles,hObject,eventdata)


% --- Executes on button press in AB.
function AB_Callback(hObject, eventdata, handles)
% hObject    handle to AB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AB=466.16; %frequency of the note
PianoPlayer(AB,handles,hObject,eventdata)


% --- Executes on button press in B.
function B_Callback(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

B=493.88; %frequency of the note
PianoPlayer(B,handles,hObject,eventdata)


% --- Executes on button press in CC.
function CC_Callback(hObject, eventdata, handles)
% hObject    handle to CC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CC=554.37; %frequency of the note
PianoPlayer(CC,handles,hObject,eventdata)


% --- Executes on button press in CCDD.
function CCDD_Callback(hObject, eventdata, handles)
% hObject    handle to CCDD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CCDD=587.33; %frequency of the note
PianoPlayer(CCDD,handles,hObject,eventdata)


% --- Executes on button press in DD.
function DD_Callback(hObject, eventdata, handles)
% hObject    handle to DD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DD=587.33; %frequency of the note
PianoPlayer(DD,handles,hObject,eventdata)


% --- Executes on button press in DDEE.
function DDEE_Callback(hObject, eventdata, handles)
% hObject    handle to DDEE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DDEE=622.25; %frequency of the note
PianoPlayer(DDEE,handles,hObject,eventdata)


% --- Executes on button press in EE.
function EE_Callback(hObject, eventdata, handles)
% hObject    handle to EE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EE=659.26; %frequency of the note
PianoPlayer(EE,handles,hObject,eventdata)

% --- Executes on button press in Help_Piano.
function Help_Piano_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Piano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

helpdlg({'The default sound wave is sine','and when the respective wave','manipulation button is pressed','the sound wave will change','to the respective wave.'},'Piano Help') %displays a help message when the button is pressed



%% Effects and Sample Modification
% --- Executes on button press in Reverse.
function Reverse_Callback(hObject, eventdata, handles)
% hObject    handle to Reverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude fq]=audioread(handles.audioFile);
    amplitudeReverse=amplitude(end:-1:1,:);
    sound(amplitudeReverse,fq);
    t=[1/fq:1/fq:length(amplitudeReverse)/fq]; %generating the time to be used to when plotting the audio file
    axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
    plot(t,amplitudeReverse); %plots the audio file
    title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
    title(sprintf('%s (%s)',handles.audioFile,'Reversed')); %changes the title of the graph to the title of the audio file and the effects being applied
    xlabel('Time(s)');
    ylabel('Amplitude');
end


% --- Executes on button press in Delay.
function Delay_Callback(hObject, eventdata, handles)
% hObject    handle to Delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    sound(amplitude,fq./2)
    t=[1/(fq./2):1/(fq./2):length(amplitude)/(fq./2)]; %generating the time to be used to when plotting the audio file
    axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
    plot(t,amplitude); %plots the audio file
    title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
    title(sprintf('%s (%s)',handles.audioFile,'Delayed')); %changes the title of the graph to the title of the audio file and the effects being applied
    xlabel('Time(s)');
    ylabel('Amplitude');
end


% --- Executes on button press in Speed_Up.
function Speed_Up_Callback(hObject, eventdata, handles)
% hObject    handle to Speed_Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    sound(amplitude,fq.*1.5);
    t=[1/(fq.*1.5):1/(fq.*1.5):length(amplitude)/(fq.*1.5)]; %generating the time to be used to when plotting the audio file
    axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
    plot(t,amplitude); %plots the audio file
    title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
    title(sprintf('%s (%s)',handles.audioFile,'Sped Up')); %changes the title of the graph to the title of the audio file and the effects being applied
    xlabel('Time(s)');
    ylabel('Amplitude');
end


% --- Executes on button press in Filtering_Muffled.
function Filtering_Muffled_Callback(hObject, eventdata, handles)
% hObject    handle to Filtering_Muffled (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    [r,c]=size(amplitude);
    stereoValue=handles.stereoValue;
    if c~=2|stereoValue~=1;
        [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
        sound(y, x)
        errordlg('To use this effect, the audio file must be stereo.','ERROR!','modal') %generates an error message
    else
        outFilteringM=amplitude;
        for n=2:length(amplitude)
            outFilteringM(n,1)=.9*outFilteringM(n-1,1)+amplitude(n,1); %left
            outFilteringM(n,2)=.9*outFilteringM(n-1,2)+amplitude(n,2); %right
        end
        sound(outFilteringM,fq);
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,outFilteringM); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf('%s (%s)',handles.audioFile,'Filter On "Muffled"')); %changes the title of the graph to the title of the audio file and the effects being applied
        xlabel('Time(s)');
        ylabel('Amplitude');
    end
end


% --- Executes on button press in Filtering_BoostedHighs.
function Filtering_BoostedHighs_Callback(hObject, eventdata, handles)
% hObject    handle to Filtering_BoostedHighs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    [r,c]=size(amplitude);
    stereoValue=handles.stereoValue;
    if c~=2|stereoValue~=1;
        [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
        sound(y, x)
        errordlg('To use this effect, the audio file must be stereo.','ERROR!','modal') %generates an error message
    else
        outFilteringBH=amplitude;
        for n=2:length(amplitude)
            outFilteringBH(n,1)=amplitude(n,1)-amplitude(n-1,1); %left
            outFilteringBH(n,2)=amplitude(n,2)-amplitude(n-1,2); %right
        end
        sound(outFilteringBH,fq);
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,outFilteringBH); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf('%s (%s)',handles.audioFile,'Filter On "Boosted Highs"')); %changes the title of the graph to the title of the audio file and the effects being applied
        xlabel('Time(s)');
        ylabel('Amplitude');
    end
end
% --- Executes on button press in VoiceRemoval.
function VoiceRemoval_Callback(hObject, eventdata, handles)
% hObject    handle to VoiceRemoval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    [r,c]=size(amplitude);
    stereoValue=handles.stereoValue;
    if c~=2|stereoValue~=1;
        [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
        sound(y, x)
        errordlg('To use this effect, the audio file must be stereo.','ERROR!','modal') %generates an error message
    else
        left=amplitude(:,1);
        right=amplitude(:,2);
        amplitude=left-right;
        sound(amplitude,fq);
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,amplitude,'k'); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf('%s (%s)',handles.audioFile,'Voice Removed')); %changes the title of the graph to the title of the audio file and the effects being applied
        xlabel('Time(s)');
        ylabel('Amplitude');
    end
end


% --- Executes on button press in Echo.
function Echo_Callback(hObject, eventdata, handles)
% hObject    handle to Echo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    [r,c]=size(amplitude);
    stereoValue=handles.stereoValue;
    if c~=2|stereoValue~=1;
        [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
        sound(y, x)
        errordlg('To use this effect, the audio file must be stereo.','ERROR!','modal') %generates an error message
    else
        outEcho=amplitude;  %set up a new array, same size as old one
        N=10000;  %delay amount N/44100 seconds
        for n=N+1:length(amplitude)
            outEcho(n,1)=amplitude(n,1)+amplitude(n-N,2);  % echo right-to-left!
            outEcho(n,2)=amplitude(n,2)+amplitude(n-N,1);  % echo left-to-right!
        end
        sound(outEcho,fq);
        t=[1/fq:1/fq:length(amplitude)/fq]; %generating the time to be used to when plotting the audio file
        axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
        plot(t,outEcho); %plots the audio file
        title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
        title(sprintf('%s (%s)',handles.audioFile,'Echoed')); %changes the title of the graph to the title of the audio file and the effects being applied
        xlabel('Time(s)');
        ylabel('Amplitude');
    end
end


% --- Executes on button press in Fade_In.
function Fade_In_Callback(hObject, eventdata, handles)
% hObject    handle to Fade_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound

audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    amplitudeAltered1=amplitude(1:end,1)';
    amplitudeAltered2=amplitude(1:end,2)';
    x1=amplitudeAltered1.*linspace(0,1,length(amplitudeAltered1));
    x2=amplitudeAltered2.*linspace(0,1,length(amplitudeAltered2));
    x=[x1 x2];
    sound(x,fq);
    t=[1/fq:1/fq:length(amplitudeAltered1)/fq]; %generating the time to be used to when plotting the audio file
    axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
    cla reset
    hold on
    plot(t,x2); %plots the audio file
    plot(t,x1);
    hold off 
    title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
    title(sprintf('%s (%s)',handles.audioFile,'Fading In')); %changes the title of the graph to the title of the audio file and the effects being applied
    xlabel('Time(s)');
    ylabel('Amplitude');
end


% --- Executes on button press in Fade_Out.
function Fade_Out_Callback(hObject, eventdata, handles)
% hObject    handle to Fade_Out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear sound
audioFileExist=isfield(handles,'audioFile'); %creating a logical array which indicates the existance of the field "audioFile"
if audioFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must select a file to apply effects.','ERROR!','modal') %generates an error message if the user has not chosen any sample to play
else
    stop(handles.audio)
    [amplitude,fq]=audioread(handles.audioFile);
    amplitudeAltered1=amplitude(1:end,1)';
    amplitudeAltered2=amplitude(1:end,2)';
    x1=amplitudeAltered1.*linspace(1,0,length(amplitudeAltered1));
    x2=amplitudeAltered2.*linspace(1,0,length(amplitudeAltered2));
    x=[x1 x2];
    sound(x,fq);
    t=[1/fq:1/fq:length(amplitudeAltered1)/fq]; %generating the time to be used to when plotting the audio file
    axes(handles.AudioSamplePlot); %selects the desired graph to plot the audio file
    cla reset
    hold on
    plot(t,x1); %plots the audio file
    plot(t,x2);
    hold off 
    title('x_2','Interpreter','none'); %displays the file name as the title of the graph as it is
    title(sprintf('%s (%s)',handles.audioFile,'Fading Out')); %changes the title of the graph to the title of the audio file and the effects being applied
    xlabel('Time(s)');
    ylabel('Amplitude');
end



%% Wave Manipulation
% --- Executes on button press in WaveManipulation_Sine.
function WaveManipulation_Sine_Callback(hObject, eventdata, handles)
% hObject    handle to WaveManipulation_Sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear plot;
x=linspace(0,7*pi,1000); %generates equally spaced 1000 points between 0 to 7pi
y=sin(x); %generating y component of the wave function to be plotted
axes(handles.WaveManipulation_SampleGraph); %selecting the desired graph to plot the wave function 
plot(x,y,'r','LineWidth',1);
title('Sine Wave')
xlabel('Frequency')
ylabel('Amplitude')
axis([0,max(x),min(y),max(y)]) %setting the axis to fit the wave function

%setting the other values=0
handles.sine=1; 
handles.square=0;
handles.triangle=0;
handles.sawtooth=0;

clear sound;
%when the button is pressed, it will play the note (C4) in the selected wave format
C=261.63;
PianoPlayer(C,handles,hObject,eventdata)

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in WaveManipulation_Square.
function WaveManipulation_Square_Callback(hObject, eventdata, handles)
% hObject    handle to WaveManipulation_Square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear plot;
x=linspace(0,7*pi,1000); %generates equally spaced 1000 points between 0 to 7pi
y=square(x); %generating y component of the wave function to be plotted
axes(handles.WaveManipulation_SampleGraph); %selecting the desired graph to plot the wave function 
plot(x,y,'b','LineWidth',1);
title('Square Wave')
xlabel('Frequency')
ylabel('Amplitude')
axis([0,max(x),min(y),max(y)])

%setting the other values to 0
handles.sine=0;
handles.square=1;
handles.triangle=0;
handles.sawtooth=0;

clear sound;
%when the button is pressed, it will play the note (C4) in the selected wave format
C=261.63;
PianoPlayer(C,handles,hObject,eventdata)

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in WaveManipulation_Triangle.
function WaveManipulation_Triangle_Callback(hObject, eventdata, handles)
% hObject    handle to WaveManipulation_Triangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear plot;
x=linspace(0,7*pi,1000); %generates equally spaced 1000 points between 0 to 7pi
y=sawtooth(x,0.5); %generating y component of the wave function to be plotted
axes(handles.WaveManipulation_SampleGraph);
plot(x,y,'k','LineWidth',1);
title('Triangular Wave')
xlabel('Frequency')
ylabel('Amplitude')
axis([0,max(x),min(y),max(y)]) %setting the axis to fit the wave function

%setting the other values to 0
handles.sine=0;
handles.square=0;
handles.triangle=1;
handles.sawtooth=0;

clear sound;
%when the button is pressed, it will play the note (C4) in the selected wave format
C=261.63;
PianoPlayer(C,handles,hObject,eventdata)

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in WaveManipulation_Sawtooth.
function WaveManipulation_Sawtooth_Callback(hObject, eventdata, handles)
% hObject    handle to WaveManipulation_Sawtooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear plot;
x=linspace(0,7*pi,1000); %generates equally spaced 1000 points between 0 to 7pi
y=sawtooth(x); %generating y component of the wave function to be plotted
axes(handles.WaveManipulation_SampleGraph);
plot(x,y,'g','LineWidth',1);
title('Sawtooth Wave')
xlabel('Frequency')
ylabel('Amplitude')
axis([0,max(x),min(y),max(y)]) %setting the axis to fit the wave function

%setting the other values to 0
handles.sine=0;
handles.square=0;
handles.triangle=0;
handles.sawtooth=1;

clear sound;
%when the button is pressed, it will play the note (C4) in the selected wave format
C=261.63;
PianoPlayer(C,handles,hObject,eventdata)

guidata(hObject,handles); %updating the handles on the global workspace



%% Recording
% --- Executes on button press in Start_Recording.
function Start_Recording_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.recObj=audiorecorder(8000,16,2)
get(handles.recObj)
handles.recObj=audiorecorder;
record(handles.recObj)
set(handles.Standing_By,'Backgroundcolor','red','String','RECORDING','Foregroundcolor','white')

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Stop_Recording.
function Stop_Recording_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_Recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

recObjFileExist=isfield(handles,'recObj'); %creating a logical array which indicates the existance of the field "recObj"
if recObjFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must start recording first to recording.','ERROR!','modal') %generates an error message if the user has not recorded anything
else 
    stop(handles.recObj)
    handles.recordingSound=getaudiodata(handles.recObj);
    handles.recordingPlay=audioplayer(handles.recordingSound,8000);

    set(handles.Standing_By,'Backgroundcolor',[0.94 0.94 0.94],'String','Standing By','Foregroundcolor','black')
end
    
guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Play_Recording.
function Play_Recording_Callback(hObject, eventdata, handles)
% hObject    handle to Play_Recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

recObjFileExist=isfield(handles,'recObj'); %creating a logical array which indicates the existance of the field "recObj"
if recObjFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must start recording first to play recording.','ERROR!','modal') %generates an error message if the user has not recorded anything
else
    play(handles.recordingPlay);
end
    
guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

recObjFileExist=isfield(handles,'recObj'); %creating a logical array which indicates the existance of the field "recObj"
if recObjFileExist==0
    [y x]=audioread('WINDOWS_XP_ERROR_SOUND.wav');
    sound(y, x)
    errordlg('You must start recording first to save recording.','ERROR!','modal') %generates an error message if the user has not recorded anything
else 
    fileName=inputdlg('Please name your file.','Save');
    fileName=char(fileName);
    fileName=strcat(fileName,'.wav');
    msgbox('Saved','Save','modal')
    audiowrite(fileName, handles.recordingSound, 8000)
end

guidata(hObject,handles); %updating the handles on the global workspace


% --- Executes on button press in Help_Recording.
function Help_Recording_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Recording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

helpdlg({'User can apply effects to','their own recording by','saving the recording then','loading and selecting','the file.'},'Recording Help') %displays a help message when the button is pressed
