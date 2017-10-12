def input_students
  cohorts = [:january, :february, :march, :april, :may, :june, :july,
  :august, :september, :october, :november, :december]
  # ask for both name and cohort
  puts "Please enter the names of the students then their cohort"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name and the first cohort
  name = gets.chomp
  cohort = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    if cohort.empty?
      cohort = "---"
    else
      while !cohorts.include?(cohort.downcase.to_sym)
        puts "Please enter a valid month"
        cohort = gets.chomp
      end
    end
    # add the student hash to the array
    students << {name: name , cohort: cohort.to_sym}
    puts "Now we have #{students.count} #{student_form(students.count)}"
    #get another name and cohort from user
    name = gets.chomp
    cohort = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# return singular or plural form when appropriate
def student_form(number)
  if number == 1
    return "student"
  else
    return "students"
  end
end
# rewrite the each methods using while loop
def print(students)
  i=0
  while i < students.length

    puts "#{i+1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)".center(50)

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

# group students by cohort
def group_by_cohort(names,cohort)
   group = names.select{|name| name[:cohort] == cohort  }
   count = 0
   group.each do |name|
     puts "#{count+1} #{name[:name]} (#{name[:cohort]} cohort)"
     count+=1
   end
   puts "We found #{count} #{student_form(count)} from \"#{cohort}\" cohort"
end

def print_footer(names)
  puts "Overall, we have #{names.count} great #{student_form(names.count)}"
end

students = input_students
#nothing happens until we call the methods
print_header
print(students)
#specific_name_print(students)
#specific_length_print(students)
#group_by_cohort(students,:november)
print_footer(students)
