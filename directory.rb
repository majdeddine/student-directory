require "csv"
@students = []

# list of possible cohorts
def possible_cohorts
  [:january, :february, :march, :april, :may, :june, :july,
  :august, :september, :october, :november, :december]
end

def input_students_header
  # ask for both name and cohort
  puts "Please enter the names of the students then their cohort"
  puts "To finish, just hit return twice"
end

def input_students
  input_students_header
  # get the first name and the first cohort
  name = STDIN.gets.chomp
  cohort = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    if cohort.empty?
      cohort = "---"
    else
      while !possible_cohorts.include?(cohort.downcase.to_sym)
        puts "Please enter a valid month"
        cohort = STDIN.gets.chomp
      end
    end
    # call append_to_students
    append_to_students(name,cohort)
    puts "Now we have #{@students.count} #{student_form(@students.count)}"
    #get another name and cohort from user
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
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
def group_by_cohort
  puts "Enter a cohort"
  cohort = gets.chomp
   group = @students.select{|name| name[:cohort].downcase == cohort.downcase.to_sym  }
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

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "*************************************************"
  puts "* 1. Input the students                         *"
  puts "* 2. Show the students                          *"
  puts "* 3. Save the list to a file                    *"
  puts "* 4. Load the list from a file                  *"
  puts "* 5. Show names starting with a specific letter *"
  puts "* 6. Show names shorter than 12 characters      *"
  puts "* 7. Group students by a specific cohort        *"
  puts "* 8. Exit                                       *"
  puts "*************************************************"
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
    save_students(name_file)
  when "4"
    load_students(name_file)
  when "5"
    specific_name_print
  when "6"
    specific_length_print
  when "7"
    group_by_cohort
  when "8"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def name_file
  puts "Enter file name"
  file_name = gets.chomp
  file_name = "students.csv" if file_name == ""
  if file_name[-4..-1] == ".csv"
    file_name
  else
    file_name+=".csv"
  end
end

def save_students(filename)
  # open the file for writing
  CSV.open(filename, "w") do |file|
  # iterate over the array of students
    @students.each do |student|
      file << [student[:name], student[:cohort]]
    end
  end
  puts "Your list has been successfully saved to \"#{filename}\""
end

def load_students(filename = "students.csv")
  if File.exist?(filename)
    CSV.foreach(filename) do |name, cohort|
      append_to_students(name,cohort)
    end
    puts "File \"#{filename}\" has been successfully uploaded"
  else
    puts "File \"#{filename}\" does not exist"
  end
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

# small program that reads its own source code
def read_self
  File.open($0, "r") do |file|
   file.each do |line|
     puts line
   end
  end
end

# nothing happens until we call the methods

# try_load_students
# interactive_menu
read_self
