function testcopyArray(maxDT)
path = '.\Gastag_PSO.aedt';
for i = 1:maxDT
    copyfile(path,['.\array\array' num2str(i) '.aedt']);
end
