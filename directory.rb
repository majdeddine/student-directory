# add 2 variable for names that starts with specific letter and have specific length
$first_letter = "D"
$name_length = 12
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november, hobbies: "Write DRY code", country: :UK, height: "Over 1m"}
    puts "Now we have #{students.count} students"
    #get another name from user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# rewrite the each methods using while loop

def print(students)
  i=0
  while i < students.length
    if students[i][:name][0] == $first_letter && students[1][:name].length < $name_length
    puts "#{i+1}. #{students[i][:name]} (#{students[i][:cohort]} cohort) (hobbie #{students[i][:hobbies]}) (country #{students[i][:country]}) (#{students[i][:height]} height)"
    end
    i+=1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)
