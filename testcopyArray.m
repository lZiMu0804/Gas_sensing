function testcopyArray(maxDT)
path = '.\4.24.aedt';
for i = 1:maxDT
    copyfile(path,['.\array\array' num2str(i) '.aedt']);
end
