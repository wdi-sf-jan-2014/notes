NiceTrie = function(){
  NiceTrie.count += 1;
};

var commonPrefixLength = function(str1, str2){
  var i;
  for(i = 0; i < str1.length && i < str2.length; i++){
    if(str1[i] !== str2[i]){
      return i;
    }
  }
  return i;
};

NiceTrie.prototype.bumpChildForward = function(childName, prefix){
  // Take the found child off of its current stem
  var child = this.children[childName];
  delete this.children[childName];

  // And put it one node further away.
  var newChild = new NiceTrie();
  this.children[prefix] = newChild;
  newChild.children = {};
  var remnantPrefix = childName.substring(prefix.length, childName.length);
  newChild.children[remnantPrefix] = child;
};

NiceTrie.prototype.learn = function(word, startIndex){
  startIndex = startIndex || 0;
  if(startIndex === word.length){
    this.isWord = true;  
  }
  if(startIndex < word.length){
    this.children = this.children ||  {};

    var stem;
    var keys = Object.keys(this.children);
    for(var i = 0; i < keys.length; i++){
      var str = keys[i];
      // For each child, check if word and str start the same way
      var l = commonPrefixLength(str, word.substring(startIndex));
      if(l > 0){
        stem = str.substring(0,l);

        if(l < str.length){
          this.bumpChildForward(str, stem);
        }
        break;
      }
    }
    
    if(stem === undefined){
      stem = word.substring(startIndex, word.length);
    }

    if(this.children[stem]=== undefined || 
        !this.children.hasOwnProperty(stem)){
      this.children[stem] = new NiceTrie();
    }
    this.children[stem].learn(word, startIndex + stem.length);
  }
  return this;
};

NiceTrie.prototype.getWords = function(words, currentWord){
  currentWord = currentWord || "";
  words = words || [];

  if(this.isWord){
    words.push(currentWord);
  }

  if(this.children){
    for(var char in this.children){
      var nextWord = currentWord + char;
      this.children[char].getWords(words,nextWord);
    }
  }
  return words;
};

NiceTrie.prototype.find = function(word){
  if(word === ""){
    return {node: this, path: ""};
  }

  for(var str in this.children){
    var l = commonPrefixLength(str, word);
    if(l > 0){
      if(str.length > word.length){
        return {node: this, path: ""};
      }else{
        var restOfString = word.substring(l, word.length);
        var result = this.children[str].find(restOfString);
        if(result){
        result.path = str + result.path;
        }
        return result;
      }
    }
  }
  return null;
};

NiceTrie.prototype.autoComplete = function(currentWord){
  var result = this.find(currentWord);
  
  if(result){
    var subTrie = result.node;
    var words = subTrie.getWords([], result.path);
    if(result.path.length < currentWord.length){
      words = words.filter(function(word){
        return word[result.path.length] === currentWord[result.path.length];
      });
    }
    return words;
  }else{
    return [];
  }
};