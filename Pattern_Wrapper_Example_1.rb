# у даному прикладі напишемо користувальницьку программу, що базується
# на класичній реалізації патерна Wrapper (Decorator)

# створимо модуль, що буде слугувати загальним інтерфейсом для
# обгорток (декораторів) і об'єктів, які загортаються
module General_interfaces
  # загальний метод привітання
  def greeting_with_the_user # (метод, що може бути змінений декораторами)
    raise NotImplementedError, "#{self.class} має імлементувати метод #{__method__}"
  end
end

# базовий клас для об'єктів, функціональність яких будемо розширювати
class Human
  # імплементуємо загальний модуль
  include General_interfaces
  attr_accessor :name
  # конструктор класу
  def initialize(name)
    @name = name
  end
  # метод, що будемо "розширювати"
  def greeting_with_the_user
    "Мій любий користувач, вітаю Вас у світі мови програмування Ruby! Мене звати #{@name}!\n"
  end
end

# загальний клас "декоратор" для усіх можливих "класів-обгорток"
class Decorator_Human
  include General_interfaces
  # конструктор
  def initialize(human) # фактично, передали лише посилання на об'єкт, який буде "обгортуватися"
    @human = human
  end
  # делегуємо усю роботу оберненому об'єкту
  def greeting_with_the_user
    @human.greeting_with_the_user
  end
end

# 1-й клас "обгортки"
class Decorator_friendly_Human < Decorator_Human
  # розширили метод привітання
  def greeting_with_the_user
    "#{super}Я дуже радий, що можу з Вами розмовляти!\n"
  end
  # додатковий метод, що виводить діалогову фразу
  def say_something
    "Я лише код, що друкує фрази на консоль...\n"
  end
end

# 2-й клас "обгортки"
class Decorator_goodbye_Human < Decorator_Human
  # розширили метод привітання
  def greeting_with_the_user
    "#{super}Сподіваюсь, що ми з Вами ще побачимось! До побачення!"
  end
  # додатковий метод підрахунку суми чисел
  def plus_something(a, b)
    "Я також вмію складати числа: #{a} + #{b} = #{a+b}!"
  end
end

# тестимо програму
puts("Проста программа на основі класичного патерну Wrapper (Decorator)!")
human = Human.new("Марія")
friendly_human = Decorator_friendly_Human.new(human) # "обгорнули об'єкт"
goodbye_human = Decorator_goodbye_Human.new(friendly_human) # "обгорнули обгорнутий об'єкт"
# перевіряємо можливості "обгорнутих" об'єктів
puts("-----------------------------------------------------------")
puts friendly_human.say_something
puts("-----------------------------------------------------------")
puts goodbye_human.plus_something(4, 5)
puts("-----------------------------------------------------------")
puts goodbye_human.greeting_with_the_user
print("-----------------------------------------------------------")