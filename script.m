words = [];
sizewords = input("Enter word size: ");
w = zeros(1,sizewords);
while size(w)(2) > 0
  w = input("Input word, or press enter to end list: ", 's');
  if sizewords != size(w)(2) && size(w)(2) != 0
    disp("Word not the right size. Not adding to list")
  elseif size(w)(2) != 0
    words = [words; w];
  end
end
  
[numwords, sizewords] = size(words);
mat = zeros(numwords);

entropy = zeros(numwords,1);
for i = 1:numwords
  for j = 1:(i-1)
    match = 0;
    for k = 1:sizewords
      if words(i,k) == words(j,k)
        match++;
      end
    end
    mat(i,j) = match;
  end
end
    
mat = mat + mat';
for i = 1:numwords
  mat(i,i) = sizewords;
end
mat;

correct = 0;
while correct < sizewords  && ~isequal(size(mat),[1 1])
  entropy = zeros(numwords, 1);

  for i = 1:numwords    
    bucket = histc(mat(i,:),0:sizewords);
    
    for j = 1:(sizewords)
      p = bucket(j) / (numwords);
      if p != 0
        entropy(i) -= p*log2(p);
      end
    end
  end
    
  max = entropy(1);
  maxindex = 1;
  for i = 2:numwords
    if entropy(i) > max
      max = entropy(i);
      maxindex = i;
    end
  end

  s = sprintf("Guess : %s", words(maxindex,:));
  disp(s)
  correct = input(sprintf("How many letters correct? (Enter %d if guess correct) : ",sizewords));

  f = find(mat(maxindex,:)==correct);
  mat = mat([f],[f]);
  words = words(f,:)
  [numwords sizewords] = size(words);


  %backup
end