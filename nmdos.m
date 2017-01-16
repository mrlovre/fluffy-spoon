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
[polka, fs] = audioread('polka.wav');
ts = 1 / fs;
t = 0 : ts : 10 - ts;
polka = polka(1 : 10 * fs, 1);
figure, plot(t, polka);

%%
scales =  2 .^ (-13 - 3 / 12 : 1 / 12 : -6);
wtft = cwtft(struct('val', polka, 'period', 1 / 44100), 'wavelet', {'bump', [3.4375, 0.1]}, 'scales', scales);

wt = abs(wtft.cfs(:, 1 : 10 : end));
diff_wt = diff(wt.').';
[~, m] = size(diff_wt);
for i = 1 : m
    temp = diff_wt(:, i);    
%     temp(temp < 0) = 0;
%     temp = temp / max(temp);
%     temp = softmax(temp);
%     temp(temp < 2 / 88) = 0;
    diff_wt(:, i) = temp;
end

% A = zeros(12, m + 1);
% for i = 1 : 88
%     j = mod(i - 1, 12) + 1;
%     A(j, :) = A(j, :) + wt(i, :);
% end

figure, imagesc(wt(:, 580 : 1300)), colormap jet

figure, hold on
for i = 19 : 31
    plot(diff_wt(i, 580:3500))
end
legend(tones(88 + 1 - (19 : 31)))
 
% figure, imagesc(wt(:, 600 : 3000)), colormap jet

%%
interval = mean(diff_wt(:, 1 : 3500).');
% interval = diff_wt(:, 4000);
% interval(interval < 0.5) = 0;
figure, bar(interval), ylim([min(interval(:)), max(interval(:))])
[~, inds] = sort(interval, 'descend');
tones(inds(1 : sum(interval > 0)))

%%
[mila, fs] = audioread('mila.wav');
ts = 1 / fs;
mila1 = mila(20 * fs + 1 : 24 * fs, 1);

%%
scaling = 6518.986469044 / 7040;
scales =  2 .^ (-13 : 1 / 12 : -5) * scaling;
wtft = cwtft(struct('val', mila1, 'period', 1 / 44100), 'wavelet', {'bump', [5, 0.1]}, 'scales', scales);

wt = abs(wtft.cfs);
wt = softmax(wt);
figure, imagesc(wt)
for i = 1 : length(t3)
    wt_temp = wt(:, i);
    wt_temp(wt_temp < mean(wt_temp(:)) * 1.001) = 0;
    wt(:, i) = wt_temp;
end

f = wtft.frequencies;
figure, imagesc(wt)

figure, bar(sum(wt.'));

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
scales =  2 .^ (-13 - 3 / 12 : 1 / 12 : -6);
wtft = cwtft(struct('val', chop3, 'period', 1 / 44100), 'wavelet', {'bump', [3.4375, 0.1]}, 'scales', scales);

wt = abs(wtft.cfs(:, 1 : 10 : end));
figure, imagesc(wt), colormap jet
for i = 1 : length(wt(1, :))
    wt_temp = wt(:, i);
    wt_temp = wt_temp / sum(wt_temp);
    wt_temp(wt_temp < 1.001 / 88) = 0;
    wt(:, i) = wt_temp;
end
figure, imagesc(wt), colormap jet
% wt = softmax(wt);

f = wtft.frequencies;

figure, imagesc(wt), colormap jet
figure, bar(fliplr(wt(:, 4000)))

figure, bar(sum(wt.'));

%%
figure, hold on, plot(wt(40, :)), plot(wt(41, :)), plot(wt(39, :))

%%
figure, hold on
for i = [64, 59, 56, 71, 69]
    plot(wt(i, :))
end

legend fis h d H Cis

%%
figure, hold on
for i = 38 : 49
    plot(wt(i, :))
end
legend gis g fis eis e dis d cis c h ais a Location Best

%%
figure, hold on
for i = [64, 59, 56, 71, 69, 40] 
    plot(wt(i, :))
end
legend fis0 h0 d0 H Cis fis Location Best

%%
figure, hold on
plot(wt(49, :)), plot(wt(37, :))