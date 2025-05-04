// ImageJ Macro for processing images
// Processes two random sets of images: one with original images, another with noise and blur

// Define paths for results
resultsPath = "C:/Users/didenkoe/Desktop/Diplom/tables_results/real_data_low.csv";  

// Get list of images
inputDir = "C:/Users/didenkoe/Desktop/Diplom/Images/LowSNR/";
list = getFileList(inputDir);
n = list.length;

// Function to shuffle array
//function shuffleArray(arr) {
  //  for (i = arr.length - 1; i > 0; i--) {
      //  j = floor(random() * (i + 1));
       // temp = arr[i];
       // arr[i] = arr[j];
      //  arr[j] = temp;
  // }
//}

// Shuffle images
//shuffleArray(list);

// Open results file 
run("Clear Results"); 

// Process first half (original images)
for (i = 0; i < n; i++) {
    path = inputDir + list[i];
    open(path);
    run("8-bit");
    run("Measure");
    run("Close All");
    
    // Open the image again for Edge
    open(path);
    run("8-bit");
    
    // Apply Find Edges and Measure
    run("Find Edges");
    run("Measure");
    run("Close All");

    // Open the image again for Variance
    open(path);
    run("8-bit");

    // Apply Variance and Measure
    run("Variance...", "radius=2");
    run("Measure");
    run("Close All");
}

// After processing all images, save results to CSV
saveResultsToCSV(resultsPath);

print("Processing complete!");

function saveResultsToCSV(resultsPath) {
    // Check if the results table has data
    if (nResults > 0) {
        // Save the results table to the specified CSV path
        saveAs("Results", resultsPath);
    } else {
        print("No results to save.");
    }
}

//run("Close All");
