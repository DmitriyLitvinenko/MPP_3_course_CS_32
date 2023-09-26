# у даному прикладі напишемо користувальницьку программу, що базується
# на реалізації патерна Wrapper (Decorator) завдяки SimpleDelegator

# під'єднали модуль делегування
require 'delegate'

# створили клас для об'єкта, функціональність якого будемо розширювати
class Human
  attr_accessor :name, :surname, :date_birthday, :city
  # консруктор
  def initialize(name:, surname:, date_birthday:, city:)
    @name = name
    @surname = surname
    @date_birthday = date_birthday
    @city = city
  end
  # метод, що повертає сумму грошей на картковому балансі людини
  def money
    3000
  end
end

# загальний клас "декоратор" для усіх можливих "класів-обгорток"
class HumanDecorator < SimpleDelegator # усі методи об'єкта будуть доступні й для "обгорток"
  # фактично, передали лише посилання на об'єкт, який буде "обгортуватися"
  def initialize(human)
    @human = human
    super
  end
end

# 1-й декортатор з додатковим функціоналом
class FullNameDecorator < HumanDecorator
  # (дали бідній людини ще грошей)
  def money
    @human.money + 2000
  end
  # метод, що друкує повне ім'я
  def full_name
    "Мене звати #{surname} #{name}!"
  end
end

# 2-й декортатор з додатковим функціоналом
class AgeCityDecorator < HumanDecorator
  # метод, який обчислює вік за датою народження
  def age
    "Мені вже виповнилося #{((Time.now - date_birthday) / 31557600).floor} років!"
  end
  # метод, що друкує рідне місто об'єкта
  def city_name
    "Я народився у місті #{city}!"
  end
end


# тестимо програму
puts("Проста программа на основі патерну Wrapper (Decorator), з використанням SimpleDelegator!")
# ініціалізуємо об'єкт
human = Human.new(
  name: "Іван",
  surname: "Завгородній",
  date_birthday: Time.new(1996, 11, 29, 2, 15, 16, "+03:00"),
  city: "Полтава"
)
# перевіряємо можливості "обгорнутих" об'єктів
smart_human = FullNameDecorator.new(human) # "обгорнули об'єкт"
puts("-----------------------------------------------------------")
smart_human.full_name
puts "На рахунку вже #{smart_human.money}$..."

very_smart_human = AgeCityDecorator.new(smart_human) # "обгорнули обгорнутий об'єкт"
puts("-----------------------------------------------------------")
puts very_smart_human.full_name
puts "#{very_smart_human.name} народився #{very_smart_human.date_birthday}!"
puts very_smart_human.age
puts very_smart_human.city_name
puts "На рахунку все ще #{very_smart_human.money}$..."
print("-----------------------------------------------------------")