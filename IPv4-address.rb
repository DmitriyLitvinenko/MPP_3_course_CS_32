# власний клас "помилки" для обробки виключень
class IPv4LengthError < StandardError
  def initialize(message = "Пробачте, але IPv4-адреса введена неправильно! (ex: 192.168.12.1)")
    super(message)
  end
end

# метод перевірки рядка на приналежність до IPv4-адреси
def control_ip_address(address)
  elements = address.split(".") # поділили рядок на складові за символом "."
  # якщо запис IPv4-адреси неправильний (тобто не 192.168.12.1, як приклад), то оброблюємо виключення
  begin
    if elements.length != 4
      raise IPv4LengthError
    end
  rescue IPv4LengthError => error
    puts error.message
    return false
  end
  # якщо все "ОК", то продовжуємо перевірку...
  for part in elements
    help_array = part.chars # отримали рядок для роботи
    if help_array[0] == "0" # якщо перший символ це "0"...
      return false
    elsif part.include? " "  # якщо є пропуски...
      return false
    elsif part.to_i < 0 || part.to_i > 255 # якщо число не відповідає діапазону [0; 255]...
      return false
    end
  end
  true # якщо рядок пройшов перевірку...
end

# -------------------------------------------------------------------------------------------------------------- #
puts "Шановний користувач, вітаємо вас у застосунку \"Перевірка IPv4-адреси\"!"
puts "Для завершення програми введіть рядок \"exit\"!"
# релізував нескінченний цикл з умовою виходу => щоб можна було перевіряти декілька рядків
while true
  print "\nБудь ласка, введить рядок з IPv4-адресою ->"
  address = gets.chomp # отримали запис адреси з клавіатури (без "\n" в кінці)
  # умова виходу з циклу
  if address.downcase == "exit"
    puts "Дякую за Вашу роботу! До побачення!"
    break
  end
  print "Рядок #{address} є IPv4-адресою? -> #{control_ip_address(address)}\n"
end