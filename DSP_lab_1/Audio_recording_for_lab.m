%% Recording for Task 1 and 2 
Fs = 48000; 
nBits = 8; 
nChannels = 2; 
D = -1;       % default audio input device 
recObj = audiorecorder(Fs,nBits,nChannels,ID);

disp("Begin speaking.")

recDuration = 10; % record for 5 seconds
recordblocking(recObj,recDuration);
disp("End of recording.")

%% Task 1
audioData = getaudiodata(recObj);

% Play the audio at twice the original rate
sound(audioData, 2 * Fs);

disp("Playing audio at twice the original rate.");

audioData = getaudiodata(recObj);

% Save the recorded audio data as a .wav file
audiowrite('DSP-Isaac_Alex_noise_2.wav', audioData, Fs);

disp("Recorded audio saved to 'DSP-Isaac_Alex_noise_2'.");

% Read the audio file
[audioData, Fs] = audioread('DSP-Isaac_Alex_noise_2.wav');

%% Task 3
% Create a time vector for plotting

audioData = audioread('DSP-Isaac_Alex_noise_2.wav');

t = (0:length(audioData)-1)/Fs;

% Plot the audio signal
figure;
plot(t, audioData);
title('Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

disp("Audio signal plotted.");

%% Task 4
function echoedAudio = addEcho(audioData, Fs, gain, delay)
    
    % Convert delay from seconds to samples
    delaySamples = round(delay * Fs);
    
    % Create the echoed signal
    echoedAudio = audioData;
    for i = (delaySamples+1):length(audioData)
        echoedAudio(i) = audioData(i) + gain * audioData(i - delaySamples);
    end
end

% Read the audio file
[audioData, Fs] = audioread('DSP-Isaac_Alex_noise_2.wav');

% Set parameters for the echo effect
gain = 0.8;    % Echo gain
delay = 0.3;   % Echo delay in seconds

% Apply the echo effect
echoedAudio = addEcho(audioData, Fs, gain, delay);

% Play the echoed audio
sound(echoedAudio, Fs);

% Save the echoed audio to a new file
audiowrite('DSP-Isaac_Alex-Echoed.wav', echoedAudio, Fs);

disp("Echoed audio saved to 'DSP-Isaac_Alex-Echoed.wav'.");

