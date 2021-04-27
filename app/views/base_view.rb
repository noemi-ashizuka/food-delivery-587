class BaseView
  def ask_for(thing)
    puts "What is the #{thing}?"
    gets.chomp
  end
end
