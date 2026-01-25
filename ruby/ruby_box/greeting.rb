class Greeting
  @@polite = false

  def self.polite=(polite)
    @@polite = polite
  end

  def say_hello
    if @@polite
      puts 'Hello. How are you today?'
    else
      puts 'Yo!'
    end
  end
end
