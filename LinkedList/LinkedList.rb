# клас, що ініціалізує вузол пов'язаного списку
class Node
  attr_accessor :next  # "вказівка" на наступний вузол
  attr_reader :value   # значення вузла

  # конструктор вузла
  def initialize(value)
    @value = value
    @next  = nil
  end

  # перевизначения метод друку значення вузла
  def to_s
    "#{@value}"
  end
end

# клас, що реалізує пов'язаний список
class LinkedList
  # конструтор
  def initialize
    @head = nil # визначаємо "голову" списка
  end

  # метод пошуку "хвоста" зв'язаного списку
  def find_tail
    node = @head
    # якщо маємо лише "голову" списка
    if !node.next
      return node
    end
    # проходимо по усім вузлам, поки не знайдемо "хвіст" списку
    while (node = node.next)
      if !node.next
        return node
      end
    end
  end

  # метод пошуку вузла за значенням
  def find(value)
    # якщо список порожній
    if @head == nil
      return false
    end
    node = @head
    # якщо маємо лише "голову" списка
    if !node.next
      return false
    end
    if node.value == value
      return node
    end
    # проходимо по усім вузлам, поки не знайдемо потрібний вузол
    while (node = node.next)
      if node.value == value
        return node
      else
        return false
      end
    end
  end

  # метод додавання нового вузла в кінець пов'язаного списку
  def append(value)
    if @head # якщо список має вузли, то додаємо новий вузол в якості "хвоста" списку
      # обробка можливої помилки
      if @head.value == value || find(value) != false
        puts "\nError: дана операція вставки неможлива -> список має вузол із таким значенням!"
        return
      end
      find_tail.next = Node.new(value)
    else # якщо список порожній, то додаємо новий вузол в якості "голови" списку
      @head = Node.new(value)
    end
    puts "\nВузол зі значенням #{value} був доданий в кінець пов'язаного списку!"
  end

  # метод додавання нового вузла, після деякого визначеного вузла (за значенням)
  def append_after(target, value)
    # обробка можливої помилки
    if find(target) == false
      puts "\nError: дана операція вставки неможлива -> список немає вузла з таким значенням!"
      return
    end
    # обробка можливої помилки
    if find(value) != false
      puts "\nError: дана операція вставки неможлива -> список має вузол із таким значенням!"
      return
    end
    node = find(target)
    puts "\nВузол зі значенням #{value} був доданий після вузла #{target}!"
    return unless node
    # фактично, просто змінюємо вузли місцями, додаючи новий
    old_next = node.next
    node.next = Node.new(value)
    node.next.next = old_next
  end

  # метод пошуку попереднього вузла за значенням поточного
  def find_before(value)
    node = @head
    # якщо маємо лише "голову" списка
    if !node.next
      return false
    end
    if node.next.value == value
      return node
    end
    # проходимо по усім вузлам, поки не знайдемо потрібний вузол
    while (node = node.next)
      if node.next && node.next.value == value
        return node
      end
    end
  end

  # метод видалення вузла за значенням
  def delete(value)
    # обробка можливої помилки - немає "голови" списку
    if @head == nil
      puts "\nError: операція видалення неможлива -> список порожній!"
      return
    end
    # якщо видалили "голову" пов'язаного списка, то наступний елмемет стає "головою"
    if @head.value == value
      @head = @head.next
      puts "\nВузол зі значенням #{value} був видалений з пов'язаного списку!"
      return
    end
    # обробка можливої помилки
    if find(value) == false
      puts "\nError: операція видалення неможлива -> список немає вузла з таким значенням!"
      return
    end
    # просто видаляємо вузол, перевизначаючи значення вказівника на наступний вузол
    node = find_before(value)
    node.next = node.next.next
    puts "\nВузол зі значенням #{value} був видалений з пов'язаного списку!"
  end

  # метод друку пов'язаного списку
  def print_list
    node = @head
    # якщо список порожній, то виводимо відплвідне повідомлення
    if node == nil
      puts "\nПов'язаний список немає жождного вузла!"
      return
    end
    print "\nПов'язаний список: "
    # друкуємо "голову" списку
    print node
    # друкуємо усі інші вузли, доки не дійдемо до кінця
    while (node = node.next)
      print " -> "
      print node
    end
    print "\n"
  end
end

# -------------------------------------------------------------------------------------------------------------- #
puts "Шановний користувач, вітаємо вас у застосунку \"Пов'язаний список\"!"
list = LinkedList.new # створений пов'язаний список
check = true # змінна для перевірки умови виходу з цикла
while check do
  # за допомогою нескінченного циклу, реалізуемо елементарне меню для користувача
  puts "\nБудь ласка, зробіть свій вибір!..."
  puts "--------------------------------------------------------"
  puts "1 - Додати вузол в кінець списку"
  puts "2 - Додати вузол після деякого вузла (за значенням)"
  puts "3 - Видалити вузол зі списку (за значенням)"
  puts "4 - Перевірка наявності вузла (за значенням)"
  puts "5 - Друк появ'язаного списку на консоль"
  puts "0 - Вихід"
  puts "--------------------------------------------------------"
  print"Ваш вибір ->"
  menu = gets.chomp.to_i
  # перевірка на правильність введених значень
  while menu < 0 || menu > 5
    print"Неможливе значення! Повторіть ваш вибір ->"
    menu = gets.chomp.to_i
  end
  # в залежності від вибору, виконуємо дію
  case menu
  when 1
    print "\nВведить значення вузла ->"
    value = gets.chomp
    list.append(value)
  when 2
    print "\nВведить значення вузла ->"
    value = gets.chomp
    print "\nВведить значення вузла, після якого відбудеться вставка ->"
    target = gets.chomp
    list.append_after(target, value)
  when 3
    print "\nВведить значення вузла ->"
    value = gets.chomp
    list.delete(value)
  when 4
    print "\nВведить значення вузла ->"
    value = gets.chomp
    result = list.find(value)
    if result != false
      puts "\nВузол із таким значенням є у списку: #{result}!"
    else
      puts "\nВузла із таким значенням немає у спіску!"
    end
  when 5
    list.print_list
  when 0
    puts "\nДякую за Вашу працю! До зустрічі!"
    check = false
  else
    puts "Помилка! Неможливе значення!"
  end
end