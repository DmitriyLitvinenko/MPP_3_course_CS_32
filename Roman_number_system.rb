# У цьому коді було реалізовано:
# - алгоритми щодо перетворення десяткового числа у римську систему числення та навпаки
# - користувальницький інтерфейс у вигляді елементарного меню
# - окремі методи для додаткового функціоналу

# -------------------------------------------------------------------------------------------------------------- #
# отримуємо римське значення числа для розряду "одиниці"
def get_unus(numeral)
  case numeral
  when 1
    return "I"
  when 2
    return "II"
  when 3
    return "III"
  when 4
    return "IV"
  when 5
    return "V"
  when 6
    return "VI"
  when 7
    return "VII"
  when 8
    return "VIII"
  when 9
    return "IX"
  else
    return ""
  end
end

# отримуємо римське значення числа для розряду "десятки"
def get_decem(numeral)
  case numeral
  when 1
    return "X"
  when 2
    return "XX"
  when 3
    return "XXX"
  when 4
    return "XL"
  when 5
    return "L"
  when 6
    return "LX"
  when 7
    return "LXX"
  when 8
    return "LXXX"
  when 9
    return "XC"
  else
    return ""
  end
end

# отримуємо римське значення числа для розряду "сотні"
def get_centum(numeral)
  case numeral
  when 1
    return "C"
  when 2
    return "CC"
  when 3
    return "CCC"
  when 4
    return "CD"
  when 5
    return "D"
  when 6
    return "DC"
  when 7
    return "DCC"
  when 8
    return "DCCC"
  when 9
    return "CM"
  else
    return ""
  end
end

# отримуємо римське значення числа для розряду "тисячі"
def get_mille(numeral)
  case numeral
  when 1
    return "M"
  when 2
    return "MM"
  when 3
    return "MMM"
  else
    return ""
  end
end

# метод перетворення десяткового числа до римської системи числення
def to_roman_number_system
  print "\nВведить десяткове число від 1 до 3999 (ex: 2046) ->"
  number = gets.chomp.to_i # отримали запис числа з клавіатури (без "\n" в кінці) -> перевели його у тип Integer
  # перевірка на правильність введення числа
  while number < 1 || number >= 4000 # якщо number не є числом, то повертаеться 0
    print"Число не входить у можливий діапазон! Повторіть введення даних ->"
    number = gets.chomp.to_i
  end
  number_array = number.to_s.chars # перевели значення числа у рядок -> отримали масив для роботи
  roman_array = [] # масив для виведення результату
  # в залежності від довжини масиву (тобто нашого числа) обираемо кроки щодо перетворення
  case number_array.length
  when 1
    roman_array.push(get_unus(number_array[0].to_i))
  when 2
    roman_array.push(get_decem(number_array[0].to_i))
    roman_array.push(get_unus(number_array[1].to_i))
  when 3
    roman_array.push(get_centum(number_array[0].to_i))
    roman_array.push(get_decem(number_array[1].to_i))
    roman_array.push(get_unus(number_array[2].to_i))
  else
    roman_array.push(get_mille(number_array[0].to_i))
    roman_array.push(get_centum(number_array[1].to_i))
    roman_array.push(get_decem(number_array[2].to_i))
    roman_array.push(get_unus(number_array[3].to_i))
  end
  # поелементно виводимо значення числа у римській системі числення
  print "Число #{number} у римській системі числення: "
  for index in roman_array
    if index != ""
      print "#{index}"
    end
  end
  print "\n"
end

# -------------------------------------------------------------------------------------------------------------- #
# метод для перевірки введеного числа у римській системі числення
def check_input_number(array, help)
  # сворили декілька лічильників для перевірки повторів цифр, а саме...
  unus = 0 # для "I"
  quinque = 0 # для "V"
  decem = 0 # для "X"
  quinquaginta = 0 # для "L"
  centum = 0 # для "C"
  quingenti = 0 # для "D"
  mille = 0 # для "M"
  # виконуємо прохід по ціклу, що зберігає значення числа
  for index in array
    # якщо зустрівся якийсь не той символ, то змінюємо значення змінної та виходимо з циклу
    if index != "I" && index != "V" && index != "X" && index != "L" && index != "C" && index != "D" && index != "M"
      help = 1
      break
    end
    # підрахуемо кількість повторів символів у записі
    case index
    when "I"
      unus += 1
    when "V"
      quinque += 1
    when "X"
      decem += 1
    when "L"
      quinquaginta += 1
    when "C"
      centum += 1
    when "D"
      quingenti += 1
    else
      mille += 1
    end
  end
  # якщо повторів виявилося забагато, то запис неправильний (максимально можливий запис: MMMDCCCLXXXVIII - 3888)
  if unus > 3 || quinque > 1 || decem > 3 || quinquaginta > 1 || centum > 3 || quingenti > 1 || mille > 3
    help = 1
  end
  help # повертаемо значення змінної
end

# метод перетворення римського числа до десяткової системи числення
def to_decimal_number_system
  print "\nВведить римське число від I до MMMCMXCIX (ex: MCMLXVII) ->"
  number = gets.chomp # отримали запис числа з клавіатури (без "\n" в кінці)
  number = number.upcase # перевели значення у верхній регістр (користувач випадково може ввести і так: mсхх)
  roman_array = number.chars # створили масив для роботи
  help = 0 # змінна для перевірки значення введеного числа
  # перевірка на правильність введення числа у римській системі числення
  check = check_input_number(roman_array, help)
  while check != 0
    print"Число у римській системі числення було записано неправильно!\nПовторіть введення даних ->"
    number = gets.chomp
    number = number.upcase
    roman_array = number.chars
    check = check_input_number(roman_array, help)
  end
  # вводимо деякі додаткові змінні...
  decimal_number = 0 # для значення десяткового числа
  i = 0 # для ітерації циклу
  cycle = true # для умови циклу
  # проходимо по масиву, що містить дані про число у римській системі числення
  while i < roman_array.length do
    # шукаємо комбінації, що "руйнують" алгоритм додавання (з ліва на право для римського числа)
    while cycle
      if roman_array[i] == "C" && roman_array[i+1] == "M"
        decimal_number += 900
        i += 2
      elsif roman_array[i] == "C" && roman_array[i+1] == "D"
        decimal_number += 400
        i += 2
      elsif roman_array[i] == "X" && roman_array[i+1] == "C"
        decimal_number += 90
        i += 2
      elsif roman_array[i] == "X" && roman_array[i+1] == "L"
        decimal_number += 40
        i += 2
      elsif roman_array[i] == "I" && roman_array[i+1] == "X"
        decimal_number += 9
        i += 2
      elsif roman_array[i] == "I" && roman_array[i+1] == "V"
        decimal_number += 4
        i += 2
      else
        cycle = false
      end
    end
    # якщо все "ОК", то збільшуемо значення десяткового числа, відповідно до римської цифри...
    case roman_array[i]
    when "M"
      decimal_number += 1000
    when "D"
      decimal_number += 500
    when "C"
      decimal_number += 100
    when "L"
      decimal_number += 50
    when "X"
      decimal_number += 10
    when "V"
      decimal_number += 5
    when "I"
      decimal_number += 1
    else
      puts "Помилка, якої не може бути!"
      #error
    end
    i += 1
    cycle = true # повернули почаикову умову!
  end
  # виводимо результат на консоль
  print "Число #{number} у десятковій системі числення: #{decimal_number}\n"
end

# -------------------------------------------------------------------------------------------------------------- #
puts "Шановний користувач, вітаємо вас у застосунку \"Римська сичтема числення\"!"
check = true # змінна для перевірки умови виходу з цикла
while check do
  # за допомогою нескінченного циклу, реаліщуемо елементарне меню для користувача
  puts "\nБудь ласка, зробіть свій вибір!..."
  puts "--------------------------------------------------------"
  puts "1 - Перевести десяткове число в римську систему числення"
  puts "2 - Отримати десяткове число з римської системи числення"
  puts "0 - Вихід"
  puts "--------------------------------------------------------"
  print"Ваш вибір ->"
  menu = gets.chomp.to_i
  # перевірка на правильність введених значень
  while menu < 0 || menu > 2
    print"Неможливе значення! Повторіть ваш вибір ->"
    menu = gets.chomp.to_i
  end
  # в залежності від вибору, виконуємо дію
  case menu
  when 1
    to_roman_number_system
  when 2
    to_decimal_number_system
  when 0
    puts "\nДякую за Вашу працю! До зустрічі!"
    check = false
  else
    puts "Помилка! Неможливе значення!"
  end
end