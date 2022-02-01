try
    [file,path] = uigetfile( ...
        {'*.txt;*.dat;*.csv',...
        'Delimited Files (*.txt,*.dat,*.csv)';
        '*.xls;*.xlsb;*.xlsm;*.xlsx;*.xltm;*.xltx;*.ods',...
        'Spreadsheet Files (*.xls,*.xlsb,*.xlsm,*.xlsx,*.xltm,*.xltx,*.ods)';...
        '*.*','All Files (*.*)'},'Select a File','MultiSelect','on');
catch
    uialert(figure,"Error loading your file. Please try again or a new file.","Error in file path.");
    return;
end

% Use input prompt to decide what you want (either multiply or add)
prompt = ["Modification on ydata?","Modification on the xdata?"] ;
dlgtitle = 'Data Transformation';
transform = inputdlg(prompt,dlgtitle,[1 17; 1 17]);

if isa(file,"cell") % Multiple files selected
    originalTable = cell(1,size(file,2));
    for i=1:size(file,2)
        tableProperties = detectImportOptions([path,file{1,i}],"VariableNamingRule","preserve");
        originalTable{1,i} = readmatrix([path,file{1,i}]); % Load in your data into a Matlab table
        ydata{:,i} = originalTable{1,i}(:,1);
        xdata{:,i} = originalTable{1,i}(:,2);


        % Find the size to preallocate new table to save
        % ydataNew = zeros(size(ydata,1),size(originalTable,2));
        % xdataNew = zeros(size(xdata,1),size(originalTable,2));

        % Plot data to then be used later with OnePanelFig
        hold on
        plot(xdata,ydata);


        % Matlab will find the first character to either add/subtract or multiply/divide
        if contains(transform(1), "+")
            transform{1,1}(1) = [];
            ydataNew = ydata(:,1) + str2double(transform{1,1});
        elseif contains(transform(1), "-")
            transform{1,1}(1) = [];
            ydataNew = ydata(:,1) - str2double(transform{1,1});
        elseif contains(transform(1), "*")
            transform{1,1}(1) = [];
            ydataNew(:,1) = ydata(:,1)*str2double(transform{1,1});
        elseif contains(transform(1), "/")
            transform{1,1}(1) = [];
            ydataNew(:,1) = ydata(:,1)/str2double(transform{1,1});
        end

        if contains(transform(2), "+")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1) + str2double(transform{2,1});
        elseif contains(transform(2), "-")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1) - str2double(transform{2,1});
        elseif contains(transform(2), "*")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1)*str2double(transform{2,1});
        elseif contains(transform(2), "/")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1)/str2double(transform{2,1});
        end

        plot(xdataNew, ydataNew); % Plot transformed data onto same plot. Ready to now use OnePanelFig
    end
else % Only one file selected
    originalTable = readtable([path,file],"VariableNamingRule","preserve"); % Load in your data into a Matlab table
    xdata = originalTable{:,1};
    ydata = originalTable{:,2};
end
        % Plot data to then be used later with OnePanelFig
        hold on
        plot(xdata,ydata);


        % Matlab will find the first character to either add/subtract or multiply/divide
        if contains(transform(1), "+")
            transform{1,1}(1) = [];
            ydataNew = ydata(:,1) + str2double(transform{1,1});
        elseif contains(transform(1), "-")
            transform{1,1}(1) = [];
            ydataNew = ydata(:,1) - str2double(transform{1,1});
        elseif contains(transform(1), "*")
            transform{1,1}(1) = [];
            ydataNew(:,1) = ydata(:,1)*str2double(transform{1,1});
        elseif contains(transform(1), "/")
            transform{1,1}(1) = [];
            ydataNew(:,1) = ydata(:,1)/str2double(transform{1,1});
        end

        if contains(transform(2), "+")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1) + str2double(transform{2,1});
        elseif contains(transform(2), "-")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1) - str2double(transform{2,1});
        elseif contains(transform(2), "*")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1)*str2double(transform{2,1});
        elseif contains(transform(2), "/")
            transform{2,1}(1) = [];
            xdataNew(:,1) = xdata(:,1)/str2double(transform{2,1});
        end

        plot(xdataNew, ydataNew); % Plot transformed data onto same plot. Ready to now use OnePanelFig
hold off

% Write transformed data to new table to save
newTable = table(ydataNew,xdataNew,'VariableNames',tableProperties.VariableNames);
writetable(newTable,strcat(path,'Modified_',file));