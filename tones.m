function t = tones(ord)
    t = cell(1, length(ord));
    for i = 1 : length(ord)
        switch(mod(ord(i) - 1, 12))
            case 0
                t{i} = 'a';    
            case 1
                t{i} = 'a#';
            case 2
                t{i} = 'h';
            case 3
                t{i} = 'c';
            case 4
                t{i} = 'c#';
            case 5
                t{i} = 'd';
            case 6
                t{i} = 'd#';
            case 7
                t{i} = 'e';
            case 8
                t{i} = 'f';
            case 9
                t{i} = 'f#';
            case 10
                t{i} = 'g';
            case 11
                t{i} = 'g#';     
        end
    end
end