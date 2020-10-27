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



var data ;

d3.csv("https://raw.githubusercontent.com/Rajwantmishra/DATA_608/master/m5/presidents.csv", function(data){
  //code dealing with data here
  var  matrix = [];
  n = 4;
  r = 1;
  for(var i=0; i<5; i++) {
    matrix[i] = [];
    for(var j=0; j<4; j++) {     
        matrix[i][j] = n  * r;
        r = r + 1;
    }
}
data = data;
matrix = data;
const table = d3.select("#presd-table");
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
  console.log(data)
  });

  var searchPre = function(){

    /**  search functionality **/
    d3.select("#txtpre")
    .on("keyup", function() { // filter according to key pressed 
      var searched_data = data,
      text = this.value.trim();
      console.log("TYPE ",text)
      var searchResults = searched_data.map(function(r) {
        var regex = new RegExp("^" + text + ".*", "i");
        if (regex.test(r.Height)) { // if there are any results
          return regex.exec(r.Height)[0]; // return them to searchResults
        } 
      })

      // Update table  
      const table = d3.select("#presd-table");
      const tableBody = table.append("tbody");
        tableBody
          .selectAll("tr")
          .data(searchResults)
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

    })
}

// searchPre()

// d3.select("#txtpre").on("input", searchPre )
// http://bl.ocks.org/dhoboy/1ac430a7ca883e7a8c09

var column_names = ["Name","Height","Weight"];
var clicks = {title: 0, views: 0, created_on: 0};
// draw the table
d3.select("body").append("div")
  .attr("id", "container")

d3.select("#container").append("div")
  .attr("id", "FilterableTable");

d3.select("#FilterableTable").append("h1")
  .attr("id", "title")
  .text("My Youtube Channels")

d3.select("#FilterableTable").append("div")
  .attr("class", "SearchBar")
  .append("p")
    .attr("class", "SearchBar")
    .text("Search By Title:");

d3.select(".SearchBar")
  .append("input")
    .attr("class", "SearchBar")
    .attr("id", "search")
    .attr("type", "text")
    .attr("placeholder", "Search...");
    var table = d3.select("#FilterableTable").append("table");
    table.append("thead").append("tr"); 
    
    var headers = table.select("tr").selectAll("th")
        .data(column_names)
      .enter()
        .append("th")
        .text(function(d) { return d; });
    
    var rows, row_entries, row_entries_no_anchor, row_entries_with_anchor;
      
    d3.csv("https://raw.githubusercontent.com/Rajwantmishra/DATA_608/master/m5/presidents.csv", function(data) { // loading data from server
      
    
      const tableBody = table.append("tbody");
        tableBody
          .selectAll("tr")
          .data(data)
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
          
      // // draw table body with rows
      // table.append("tbody")
    
      // // data bind
      // rows = table.select("tbody").selectAll("tr")
      //   .data(data, function(d){ return d.id; });
      
      // // enter the rows
      // rows.enter()
      //   .append("tr")
      
      // // enter td's in each row
      // row_entries = rows.selectAll("td")
      //     .data(function(d) { 
      //       var arr = [];
      //       for (var k in d) {
      //         if (d.hasOwnProperty(k)) {
      //       arr.push(d[k]);
      //         }
      //       }
      //       return [arr[1],arr[2],arr[0]];
      //     })
      //   .enter()
      //     .append("td") 
    
      // // draw row entries with no anchor 
      // row_entries_no_anchor = row_entries.filter(function(d) {
      //   return (/https?:\/\//.test(d) == false)
      // })
      // row_entries_no_anchor.text(function(d) { return d; })
    
      // // draw row entries with anchor
      // row_entries_with_anchor = row_entries.filter(function(d) {
      //   return (/https?:\/\//.test(d) == true)  
      // })
      // row_entries_with_anchor
      //   .append("a")
      //   .attr("href", function(d) { return d; })
      //   .attr("target", "_blank")
      // .text(function(d) { return d; })
        
        
      /**  search functionality **/
        d3.select("#search")
          .on("keyup", function() { // filter according to key pressed 
            var searched_data = data,
                text = this.value.trim();
            
            var searchResults = searched_data.map(function(r) {
              var regex = new RegExp("^" + text + ".*", "i");
              if (regex.test(r.Name)) { // if there are any results
                return regex.exec(r.Name)[0]; // return them to searchResults
              } 
            })
          // console.log(searchResults);
          // filter blank entries from searchResults
            searchResults = searchResults.filter(function(r){ 
              return r != undefined;
            })

                 // filter dataset with searchResults
                 searched_data = searchResults.map(function(r) {
                  return data.filter(function(p) {
                   return p.Name.indexOf(r) != -1;
                 })
               })

               //     // flatten array 
        searched_data = [].concat.apply([], searched_data)

           
        //     const tableBody = table.append("tbody");            
        // tableBody
        //   .selectAll("tr")
        //   .data(searchResults)
        //   .enter()
        //   .append("tr")
        //   .selectAll("td")
        //   .data(function(d, i) { return Object.values(d); })
        //   .enter()
        //   .append("td")
        //   .attr("class", "small")
        //   .text(function(d) {
        //     return d;
        //   });

              // data bind with new data
        rows = table.select("tbody").selectAll("tr")
          .data(searched_data, function(d){ console.log("CHEC>.",d.Name);
            return d.Name; })
        
            // enter the rows
            rows.enter()
             .append("tr");
             
            // enter td's in each row
            row_entries = rows.selectAll("td")
                .data(function(d) { 
                  var arr = [];
                  for (var k in d) {
                    if (d.hasOwnProperty(k)) {
                  arr.push(d[k]);
                    }
                  }
                  return [arr[0],arr[1],arr[2],arr[3]];
                })
              .enter()
                .append("td") 
    
            // draw row entries with no anchor 
            row_entries_no_anchor = row_entries.filter(function(d) {
              return (/https?:\/\//.test(d) == false)
            })
            row_entries_no_anchor.text(function(d) { return d; })
    
            // draw row entries with anchor
            row_entries_with_anchor = row_entries.filter(function(d) {
              return (/https?:\/\//.test(d) == true)  
            })
            row_entries_with_anchor
              .append("a")
              .attr("href", function(d) { return d; })
              .attr("target", "_blank")
            .text(function(d) { return d; })
            
            // exit
            rows.exit().remove();
          })
        
      /**  sort functionality **/
      headers
        .on("click", function(d) {
          if (d == "Title") {
            clicks.title++;
            // even number of clicks
            if (clicks.title % 2 == 0) {
              // sort ascending: alphabetically
              rows.sort(function(a,b) { 
                if (a.title.toUpperCase() < b.title.toUpperCase()) { 
                  return -1; 
                } else if (a.title.toUpperCase() > b.title.toUpperCase()) { 
                  return 1; 
                } else {
                  return 0;
                }
              });
            // odd number of clicks  
            } else if (clicks.title % 2 != 0) { 
              // sort descending: alphabetically
              rows.sort(function(a,b) { 
                if (a.title.toUpperCase() < b.title.toUpperCase()) { 
                  return 1; 
                } else if (a.title.toUpperCase() > b.title.toUpperCase()) { 
                  return -1; 
                } else {
                  return 0;
                }
              });
            }
          } 
          if (d == "Views") {
          clicks.views++;
            // even number of clicks
            if (clicks.views % 2 == 0) {
              // sort ascending: numerically
              rows.sort(function(a,b) { 
                if (+a.views < +b.views) { 
                  return -1; 
                } else if (+a.views > +b.views) { 
                  return 1; 
                } else {
                  return 0;
                }
              });
            // odd number of clicks  
            } else if (clicks.views % 2 != 0) { 
              // sort descending: numerically
              rows.sort(function(a,b) { 
                if (+a.views < +b.views) { 
                  return 1; 
                } else if (+a.views > +b.views) { 
                  return -1; 
                } else {
                  return 0;
                }
              });
            }
          } 
          if (d == "Created On") {
            clicks.created_on++;
            if (clicks.created_on % 2 == 0) {
              // sort ascending: by date
              rows.sort(function(a,b) { 
                // grep date and time, split them apart, make Date objects for comparing  
              var date = /[\d]{4}-[\d]{2}-[\d]{2}/.exec(a.created_on);
              date = date[0].split("-"); 
              var time = /[\d]{2}:[\d]{2}:[\d]{2}/.exec(a.created_on);
              time = time[0].split(":");
              var a_date_obj = new Date(+date[0],(+date[1]-1),+date[2],+time[0],+time[1],+time[2]);
              
                date = /[\d]{4}-[\d]{2}-[\d]{2}/.exec(b.created_on);
              date = date[0].split("-"); 
              time = /[\d]{2}:[\d]{2}:[\d]{2}/.exec(b.created_on);
              time = time[0].split(":");
              var b_date_obj = new Date(+date[0],(+date[1]-1),+date[2],+time[0],+time[1],+time[2]);
                    
                if (a_date_obj < b_date_obj) { 
                  return -1; 
                } else if (a_date_obj > b_date_obj) { 
                  return 1; 
                } else {
                  return 0;
                }
              });
            // odd number of clicks  
            } else if (clicks.created_on % 2 != 0) { 
              // sort descending: by date
              rows.sort(function(a,b) { 
                // grep date and time, split them apart, make Date objects for comparing  
              var date = /[\d]{4}-[\d]{2}-[\d]{2}/.exec(a.created_on);
              date = date[0].split("-"); 
              var time = /[\d]{2}:[\d]{2}:[\d]{2}/.exec(a.created_on);
              time = time[0].split(":");
              var a_date_obj = new Date(+date[0],(+date[1]-1),+date[2],+time[0],+time[1],+time[2]);
              
                date = /[\d]{4}-[\d]{2}-[\d]{2}/.exec(b.created_on);
              date = date[0].split("-"); 
              time = /[\d]{2}:[\d]{2}:[\d]{2}/.exec(b.created_on);
              time = time[0].split(":");
              var b_date_obj = new Date(+date[0],(+date[1]-1),+date[2],+time[0],+time[1],+time[2]);
                    
                if (a_date_obj < b_date_obj) { 
                  return 1; 
                } else if (a_date_obj > b_date_obj) { 
                  return -1; 
                } else {
                  return 0;
                }
              });
            }
          }
          if (d == "URL") {
            clicks.url++;
          // even number of clicks
            if (clicks.url % 2 == 0) {
              // sort ascending: alphabetically
              rows.sort(function(a,b) { 
                if (a.thumb_url_default.toUpperCase() < b.thumb_url_default.toUpperCase()) { 
                  return -1; 
                } else if (a.thumb_url_default.toUpperCase() > b.thumb_url_default.toUpperCase()) { 
                  return 1; 
                } else {
                  return 0;
                }
              });
            // odd number of clicks  
            } else if (clicks.url % 2 != 0) { 
              // sort descending: alphabetically
              rows.sort(function(a,b) { 
                if (a.thumb_url_default.toUpperCase() < b.thumb_url_default.toUpperCase()) { 
                  return 1; 
                } else if (a.thumb_url_default.toUpperCase() > b.thumb_url_default.toUpperCase()) { 
                  return -1; 
                } else {
                  return 0;
                }
              });
            }	
          }      
        }) // end of click listeners
    });
    d3.select(self.frameElement).style("height", "780px").style("width", "1150px");	