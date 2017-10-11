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

    puts "#{i+1}. #{students[i][:name]} (#{students[i][:cohort]} cohort) (hobbie #{students[i][:hobbies]}) (country #{students[i][:country]}) (#{students[i][:height]} height)".center(50)

    i+=1
  end
end

# find students names that match the user input
def specific_name_print(names)
  puts "Search for students by entering the first letter of their names"
  first_letter = gets.chomp

  count = 0
  names.each do |name|
    if name[:name][0] == first_letter
      puts "#{count+1} #{name[:name]} (#{name[:cohort]} cohort)"
      count+=1
    end
  end
  puts "We found #{count} names that start with \"#{first_letter}\""
end
# print names shorter than 12 characters
def specific_length_print(names)
  puts "Students whose name is shorter than 12 characters"
  name_length = 12
  count = 0
  names.each do |name|
    if name[:name].length <= name_length
      puts "#{count+1} #{name[:name]} (#{name[:cohort]} cohort)"
      count+=1
    end
  end
  puts "We found #{count} names shorter than 12 characters"
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
#nothing happens until we call the methods
print_header
#print(students)
#specific_name_print(students)
specific_length_print(students)
print_footer(students)
