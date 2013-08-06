// Higher-Order Functions
// Adapted from (2011 Haverbeke 73)

// Goes over an array and prints out every element
function printArray(array) {
    for (var i = 0; i < array.length; i++)
	print(array[i]);
}

// forEach 
function forEach(array, action) {
    for (var i = 0; i < array.length; i++)
	action(array[i]);
}

forEach(["Lucas", "Rolig", "Dean"], print);

// Using an anonymous function to remove useless details
function sum(numbers) {
    var total = 0;
    forEach(numbers, function (number) {
	total += number;
    });
    return total;
}
