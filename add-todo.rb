require "./connect_db.rb"
require "./todo.rb"

def get_new_todo
  puts "Todo text:"
  todo_text = gets.strip
  return nil if todo_text.empty?

  puts "How many days from now is it due? (give an integer value)"
  due_in_days = gets.strip.to_i

  {
    todo_text: todo_text,
    due_in_days: due_in_days,
  }
end

connect_db!
todo = get_new_todo #returns Hash
if todo #if works when todo is someting except nil
  new_todo = Todo.add_task(todo) #Hash is passing into add_task method
  puts "New todo created with id #{new_todo.id}" #new_todo is a Todo object returned from add_task
  puts Todo.show_list
end

