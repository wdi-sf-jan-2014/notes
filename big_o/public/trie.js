Trie = function(){
  Trie.count += 1;
  this.characters = {};
};

Trie.prototype.learn = function(word, index){
  // This function should add the given word,
  // starting from the given index,
  // to this Trie.

  // It will be recursive.  It will tell
  // the correct child of this Trie to learn the word
  // starting from a later index.

  // Consider what the learn function should do
  // when it reaches the end of the word?
  // A word does not necessarily end at a leaf.
  // You must mark nodes which are the ends of words,
  // so that the words can be reconstructed later.

  index = index || 0;

  if(index === word.length){
    this.isWord = true;
  } else if(index < word.length){
    var char = word[index];
    var subTrie = this.characters[char] || new Trie();
    subTrie.learn(word, index+1);
    this.characters[char] = subTrie;
  }
  return this;
};

Trie.prototype.getWords = function(words, currentWord){
  // This function will return all the words which are
  // contained in this Trie.
  // it will use currentWord as a prefix,
  // since a Trie doesn't know about its parents.

  currentWord = currentWord || "";
  words = words || [];

  if(this.isWord){
    words.push(currentWord);
  }
  for(var char in this.characters){
    var nextWord = currentWord + char;
    this.characters[char].getWords(words,nextWord);
  }
  return words;
};

Trie.prototype.find = function(word, index){
  // This function will return the node in the trie
  // which corresponds to the end of the passed in word.

  // Be sure to consider what happens if the word is not in this Trie.

  index = index || 0;
  var char = word[index];
  if(index < word.length - 1 && this.characters[char]){
    index += 1;
    return this.characters[char].find(word, index); 
  } else {
    return this.characters[char];
  }
};

Trie.prototype.autoComplete = function(prefix){
  // This function will return all completions 
  // for a given prefix.
  // It should use find and getWords.
  var subTrie = this.find(prefix);
  if(subTrie){
    return subTrie.getWords([], prefix);
  } else{
    return [];
  }

};