function updateParameterFile(filePath, newParams)
    % filePath: String, path to the parameter file
    % newParams: Vector of new parameter values to insert; assumed to be in the order
    % corresponding to lines 3, 12, 22, 23, 24, 31

    % Open the file for reading
    fileId = fopen(filePath, 'r');
    if fileId == -1
        error('Failed to open file: %s', filePath);
    end
    
    % Read all lines into a cell array
    lines = textscan(fileId, '%s', 'Delimiter', '\n');
    lines = lines{1};
    fclose(fileId);
    
    % Update specified lines with new parameter values
    % Assuming the parameters are the entire line content for simplicity
    linesToModify = [3,12,14,25,28]; % Lines to modify
    for i = 1:length(linesToModify)
        lineIndex = linesToModify(i);
        if lineIndex <= length(lines)
            lines{lineIndex} = num2str(newParams(i), '%f');
        else
            warning('File does not have line %d, skipping...', lineIndex);
        end
    end
    
    % Open the file for writing (this will overwrite the existing file)
    fileId = fopen(filePath, 'w');
    if fileId == -1
        error('Failed to open file for writing: %s', filePath);
    end
    
    % Write the modified lines back to the file
    for i = 1:length(lines)
        fprintf(fileId, '%s\n', lines{i});
    end
    
    fclose(fileId);
end
