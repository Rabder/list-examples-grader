CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

find student-submission/ListExamples.java

if [[ $? -eq 0 ]]
    then 
    echo "File found"
else  
    echo "File not found"
    exit 1
fi

cp student-submission/ListExamples.java TestListExamples.java grading-area


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
