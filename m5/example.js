 // A function that reverses the word
var changeDir = function(){  
  console.log(reverseStringWords(this.value))
  d3.select("#qlbl").text(reverseStringWords(this.value))
}

function reverseStringWords (sentence) {
  return sentence.split(' ').map(function(word) {
    return word.split('').reverse().join('');
  }).join(' ');
}
  

d3.select("#num").on("input", changeDir )



var getMultiple = function(b){

var matrix = [];
if(isNaN(b)){
  console.log("User Enter")
  console.log(this.value)
  n= this.value;
  d3.select("#attack-table tbody").remove();
   d3.select("#attack-table tbody").remove();

}else{
  n= b;
  console.log("First Call")
}


r = 1;
for(var i=0; i<5; i++) {
    matrix[i] = [];
    for(var j=0; j<4; j++) {     
        matrix[i][j] = n  * r;
        r = r + 1;
    }
}


//------------


const table = d3.select("#attack-table");
const tableBody = table.append("tbody");
  tableBody
    .selectAll("tr")
    .data(matrix)
    .enter()
    .append("tr")
    .selectAll("td")
    .data(function(d, i) { return Object.values(d); })
    .enter()
    .append("td")
    .attr("class", "small")
    .text(function(d) {
      return d;
    });
//------------

}

// #initialize tables
getMultiple(2)
d3.select("#txtnum").on("input", getMultiple )


d3.csv("presidents.csv", function(data){
  //code dealing with data here
  console.log(data)
  });