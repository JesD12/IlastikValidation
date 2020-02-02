%%load in the csv file and locate the file name for the tiff file and the
%%segmentation file

[file,path,idx] = uigetfile('*.csv','Select all the applicable csv files','MultiSelect','on');

for k=1:length(file)
csv_data = readtable([path, file]);
ImageFileName = file(15,end-10); %need to find a way to modify this
end
data_cystic = csv_data(strcmp('cystic',csv_data.PredictedClass),:);




%% import the tiff file and extract the images

ImageData = imread(ImageFileName);
figure(1)
imagesc(ImageData)
colormap gray
axis equal
axis off


figure(2)
for n=1:9
    h = subplot(3,3,n);
    plot_the_image(h,CutImage(data_cystic(n*2,:),ImageData));
end

%% test
test1 = commonnames(file(2),file(4));
test2=cell2mat(cellfun(@commonnames , file,file(end:-1:1),'UniformOutput',false));
test3=cell2mat(cellfun(@commonnames2 , file,file(end:-1:1),'UniformOutput',false));
disp(min(test2(1:2:end)))
disp(min(test2(2:2:end)))


%% 

function Image_to_plot = CutImage(DataLine,imagedata)
Image_to_plot = imagedata(DataLine.BoundingBoxMinimum_1:DataLine.BoundingBoxMaximum_1,DataLine.BoundingBoxMinimum_0:DataLine.BoundingBoxMaximum_0);
end

function plot_the_image(h,image_to_plot)
imagesc(h,image_to_plot)
axis equal
axis off
colormap gray
end


%% test


function startend = commonnames(cell1,cell2)
            if iscell(cell1)
                cell1 = cell2mat(cell1);
            end
            if iscell(cell2)
                cell2 = cell2mat(cell2);
            end
            commenLen = min(length(cell1),length(cell2));
            lodicalarrayfwd = ~(cell1(1:commenLen) == cell2(1:commenLen));
            lodicalarraybck = ~(cell1(end-(commenLen-1):end) == cell2(end-(commenLen-1):end));
            startend = [find(lodicalarrayfwd,1)-1,((commenLen-1)-find(lodicalarraybck,1,'last'))];
end

function startend = commonnames2(cell1,cell2)
            if iscell(cell1)
                cell1 = cell2mat(cell1);
            end
            if iscell(cell2)
                cell2 = cell2mat(cell2);
            end
            commonLen = min(length(cell1),length(cell2));
            lodicalarrayfwd = ~(cell1(1:commonLen) == cell2(1:commonLen));
            lodicalarraybck = ~(cell1(end-(commonLen-1):end) == cell2(end-(commonLen-1):end));
            startend = [find(lodicalarrayfwd,1)-1,((commonLen-1)-find(lodicalarraybck,1,'last'))];
 end

