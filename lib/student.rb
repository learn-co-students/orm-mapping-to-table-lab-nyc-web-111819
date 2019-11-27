class Student

  attr_accessor :name, :grade

  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = 'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)'
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute('DROP TABLE students')
  end

  def save
    sql = "INSERT INTO students(name, grade) VALUES ('#{name}', '#{grade}')"
    DB[:conn].execute(sql)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(hash)
    if hash.keys.length == 2
      student = Student.new(hash[:name], hash[:grade])
      student.save
    else
      student = hash.each{|student| (Student.new(student[:name],student[:grade]))}.save
    end
  student
  end
end
