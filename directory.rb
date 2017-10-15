@students = []

def input_students
  cohorts = [:january, :february, :march, :april, :may, :june, :july,
  :august, :september, :october, :november, :december]
  # ask for both name and cohort
  puts "Please enter the names of the students then their cohort"
  puts "To finish, just hit return twice"
  # get the first name and the first cohort
  name = STDIN.gets.chomp
  cohort = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    if cohort.empty?
      cohort = "---"
    else
      while !cohorts.include?(cohort.downcase.to_sym)
        puts "Please enter a valid month"
        cohort = STDIN.gets.chomp
      end
    end
    # call append_to_students
    append_to_students(name, cohort)
    puts "Now we have #{@students.count} #{student_form(@students.count)}"
    #get another name and cohort from user
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
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
def print_student_list
  i=0
  while i < @students.length
    puts "#{i+1}. #{@students[i][:name]} (#{@students[i][:cohort]} cohort)".center(50)
    i+=1
  end
end

# find students names that match the user input
def specific_name_print
  puts "Search for students by entering the first letter of their names"
  first_letter = STDIN.gets.chomp
  count = 0
  @students.each do |name|
    if name[:name][0] == first_letter
      puts "#{count+1} #{name[:name]} (#{name[:cohort]} cohort)"
      count+=1
    end
  end
  puts "We found #{count} names that start with \"#{first_letter}\""
end

# print names shorter than 12 characters
def specific_length_print
  puts "Students whose name is shorter than 12 characters"
  name_length = 12
  count = 0
  @students.each do |name|
    if name[:name].length <= name_length
      puts "#{count+1} #{name[:name]} (#{name[:cohort]} cohort)"
      count+=1
    end
  end
  puts "We found #{count} names shorter than 12 characters"
end

# group students by cohort
def group_by_cohort(cohort)
   group = @students.select{|name| name[:cohort] == cohort  }
    count = 0
   group.each do |name|
      puts "#{count+1} #{name[:name]} (#{name[:cohort]} cohort)"
      count+=1
    end
    puts "We found #{count} #{student_form(count)} from \"#{cohort}\" cohort"
end

def print_footer
  puts "Overall, we have #{@students.count} great #{student_form(@students.count)}"
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    append_to_students(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    load_students
  else
    if File.exist?(filename) # if it exist
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
      puts "Sorry, #{filename} doesn't exist."
      exit # quit the program
    end
  end
end

def append_to_students(name,cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

#nothing happens until we call the methods

try_load_students
interactive_menu
# specific_name_print
# specific_length_print
# group_by_cohort(:november)
