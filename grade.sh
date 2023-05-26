CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
 
rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

find student-submission/ListExamples.java

# Check if the file is available
if [[ $? -eq 0 ]]
    then 
    echo "File found"
else  
    echo "File not found"
    exit 1
fi

cp student-submission/ListExamples.java TestListExamples.java grading-area
cp -r lib grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar grading-area/*.java
if [[ $? -eq 0 ]]
    then 
    echo "Files compiled succesfully"
else
    echo "Your files failed to compile"
    exit 1
fi

cd grading-area
java -cp .:lib/junit-4.13.2.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore TestListExamples > junit.txt

# Detect if it any tests failed by looking at the JUnit output
grep "Failures:" junit.txt > result.txt
if [[ $? -eq 0 ]]
    then
    echo "Failures found"
    # Find the failure count
    grep -oE "[0-9]+" result.txt > failure_count.txt
    testsRan=$(grep -m 1 '' failure_count.txt)
    fails=$(grep -m 2 '' failure_count.txt | sed -n '2p')
    echo "Out of" $testsRan "tests, you failed" $fails ":"

    # Convert to integer
    testsRan_Int=$((testsRan))
    fails_int=$((fails))

    # Pick names of methods that failed 
    grep ") " junit.txt > tests_failed.txt

    cat "tests_failed.txt"

    # Calculate the score
    score=$((100 - $fails_int * 100 / $testsRan_Int))
    echo "Your score is" $score "out of 100"


else
    echo "No errors. All tests passed"
    echo 100

fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests