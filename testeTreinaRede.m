chunk_size = 200; %// Declare chunk size
num_chunks = ceil(size(X,2)/chunk_size); %// Get total number of chunks

%// For each chunk, extract out a section of the data, then train the
%// network.  Retrain on original network until we run out of data to train
for ii = 1 : num_chunks
    %// Ensure cap off if we get to the chunk at the end that isn't
    %// evenly divisible by the chunk size
    if ii*chunk_size > size(X,2)
        max_val = size(X,2);
    else
        max_val = ii*chunk_size;
    end

    %// Specify portion of data to extract
    interval = (ii-1)*chunk_size + 1 : max_val;

    %// Train the NN on this data
    net = train(net, X(:,interval), B(interval),'useParallel','yes','showResources','yes');
end