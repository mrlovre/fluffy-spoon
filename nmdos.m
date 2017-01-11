%%
[chopin, fs] = audioread('chopin.wav');
ts = 1 / fs;
chop1 = chopin(1 : 2 * fs, 1);
chop2 = chopin(fs + 1 : 3 * fs, 1);
chop3 = chopin(1 : 4 * fs, 1);
t1 = 0 : ts : 2 - ts;
t3 = 0 : ts : 4 - ts;
figure, plot(t3, chop3)

%%
[gauss, xval] = wavefun('gaus2');
figure, plot(xval, gauss)

%%
chop3a = conv(chop3, gauss, 'same') / fs;
figure, plot(t3, chop3a ./ chop3)

%%
[wt, f] = cwt(chop3, 'bump', fs, 'VoicesPerOctave', 48, 'NumOctaves', 8);
plot(t3, abs(wt(230, :)).' ./ abs(chop3))

%%
[wt, f] = cwtft(resample(chop3, 15393, fs), 'bump', 15393, 'VoicesPerOctave', 12, 'NumOctaves', 8);
wt_norm = softmax(abs(wt));

%%
figure, hold on, plot(wt_norm(40, :)), plot(wt_norm(41, :)), plot(wt_norm(39, :))

%%
imagesc(softmax(wt_norm(:, 10001 : 20000))), colormap jet

%%
scaling = 6518.986469044 / 7040;
scales =  2 .^ (-13 : 1 / 12 : -5) * scaling;
wtft = cwtft(struct('val', chop3, 'period', 1 / 44100), 'wavelet', {'bump', [5, 0.1]}, 'scales', scales);

figure, imagesc(abs(wtft.cfs))

%%
figure, hold on, plot(abs(wtft.cfs(40, :))), plot(abs(wtft.cfs(41, :))), plot(abs(wtft.cfs(39, :)))
