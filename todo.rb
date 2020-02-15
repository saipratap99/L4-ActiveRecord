require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def self.overdue
    where("due_date < ?", Date.parse(Date.today.to_s))
    #return Todo object array for due_date is less than Date.today"
  end

  def self.due_today
    where("due_date = ?", Date.parse(Date.today.to_s))
  end

  def self.due_later
    where("due_date > ?", Date.parse(Date.today.to_s))
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts overdue.to_displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.to_displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.to_displayable_list
    puts "\n\n"
  end
  def self.add_task(new_todo)
    create!(todo_text: new_todo[:todo_text], due_date: Date.today + new_todo[:due_in_days])
  end

  def self.mark_as_complete!(todo_id)
    todo = find(todo_id) #finds todo by id
    todo.completed = true
    todo.save #change will persists into database
    return todo
  end
end

