google.load('visualization', '1.0', {'packages':['corechart']});
var drawTriesChart= function(){
  var dataLengths = [1, 5, 10, 20, 50, 100, 1000, 2000, 4000, 6000, 10000];
  var data = new google.visualization.DataTable();
  data.addColumn('number', 'Number of Lines');

  var underTest = [{type: Trie,
   label: "Trie"},
   {type: NiceTrie,
    label: "Compressed Trie"}];


  _.each(dataLengths, function(dl, i){
    data.addRow([dl]);
  });

  _.each(underTest, function(trieTypeOpts, row){
    data.addColumn('number',trieTypeOpts.label);
  });


  _.each(underTest, function(trieTypeOpts, col){
    var trieType = trieTypeOpts.type;

    _.each(dataLengths, function(dataLength, row){
      trieType.count = 0;
      var root = new trieType();
      _.each(testData.slice(0, dataLength), function(line){
        root.learn(line);
      });
      data.setValue(row,col + 1, trieType.count);
    });
  });

  var options = {
    title: "Number of nodes created in different Trie Types",
    hAxis: {title: "Number of strings learned"},
    vAxis: {title: "Number of nodes created"},
    pointSize: 4,
    explorer: {maxZoomIn: 0.001}
  };
  $(function(){
    var chart = new google.visualization.AreaChart(document.getElementById('tries'));
    chart.draw(data, options);
  });
};
google.setOnLoadCallback(drawTriesChart);


var drawSortChart = function(){

  var dataLengths = [1, 5, 10, 20, 50, 100, 1000, 2000, 4000, 6000, 10000];
  var data = new google.visualization.DataTable();
  data.addColumn('number', 'Number of Strings');

  var underTest = [
    {func: Array.prototype.sort,
     label: "Native Browser Sort (QuickSort)"},
    {func: selectionSort,
     label: "Selection Sort"},
    {func: bubbleSort,
     label: "Bubble Sort"},
    {func: mergeSort,
     label: "Merge Sort"}
  ];


  _.each(dataLengths, function(dl, i){
    data.addRow([dl]);
  });

  _.each(underTest, function(sortOpts, row){
    data.addColumn('number',sortOpts.label);
  });

  var suite = new Benchmark.Suite({
    onComplete:function(){
    $(function(){
      var chart = new google.visualization.AreaChart(document.getElementById('sorts'));
      chart.draw(data, options);
    });
  }
  });

    _.each(underTest, function(sortOpts, col){
    var func = sortOpts.func;

    _.each(dataLengths, function(dataLength, row){
      suite.add(function(){
        func.apply(testData.slice(0, dataLength));
      }, {onComplete: function(evt){
        data.setValue(row,col + 1, evt.target.stats.mean);
      }});
    });
  });


  var options = {
    title: "Time spent sorting",
    hAxis: {title: "Number of strings sorted"},
    vAxis: {title: "Time spent (ms)"},
    pointSize: 4,
    explorer: {maxZoomIn: 0.001} 
  };
  suite.run();

};
google.setOnLoadCallback(drawSortChart);
