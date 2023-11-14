# під'єднали необхідні модулі та геми для роботи
require 'nokogiri'
require 'open-uri'
require 'csv'

# клас для парсингу сайту Wikipedia (бібліотеки)
class LibraryParser
  # конструктор (відкриває сайт за переданим URL)
  def initialize(url)
    @page = Nokogiri::HTML(URI.open(url))
  end

  # основний метод парсингу
  def parse_library_names
    # масиви, у яких будемо зберігати назву бібліотеки
    collected_data = []
    collect_all_parts_of_li = []
    # заходимо у блок Alphabetical (проходимо його)
    (1..26).each do |number| # проходимо по усім літерам англійської абетки
      xpath_query = "//h2[span[@class='mw-headline' and text()='Alphabetical']]/following-sibling::ul[#{number}]"
      alphabetical_h2 = @page.at_xpath(xpath_query)
      # якщо ми знайшли список "Alphabetical", то проходимо по його змісту
      if alphabetical_h2
        list_items = alphabetical_h2.xpath('.//li')

        # збираємо тестовий вміст усіх елементів li (це наші назви)
        list_items.each_with_index do |li, index|
          li.children.each do |child|
            collect_all_parts_of_li.push(child.text)
          end

          # формуємо результат парсингу
          string_from_collected_data = collect_all_parts_of_li.join # з'єднуємо усі "текстові фрагменти" в єдину назву
          part_before_comma = string_from_collected_data.split(',').first # формуємо кінцеву назву бібліотеки (до першої коми)
          collected_data.push(remove_opening_parenthesis(part_before_comma)) # додаємо назву в масив
          collect_all_parts_of_li.clear # очищуємо допоміжний масив
        end
      else
        puts "\nНа вказаній сторінці не було знайдено список з назвою \"Alphabetical\"!\n"
      end
    end
    collected_data
  end

  # створили допоміжний "приватний" метод класу
  private
  # метод для більш форрмування більш "красивої" назви бібліотеки (видалення відкриваючої дужки)
  def remove_opening_parenthesis(text)
    if text.include?('(') && !text.include?(')')
      text = text.gsub('(', '')
    end
    text
  end
end

# клас для створення CSV-файлу
class FileHandler
  # конструктор (приймає масив)
  def initialize(data)
    @data = data
  end

  # метод створення CSV-файлу
  def create_csv_file(csv_file_path)
    # створюємо файл та записуємо до нього інформацію (назви бібліотек)
    CSV.open(csv_file_path, "w") do |csv|
      csv << ["ID", "LibName"] # назви стовпчиків

      # запис ID і назви бібліотеки до файлу
      @data.each_with_index do |string, index|
        csv << [index + 1, string]
      end
    end
    puts "\nCSV-файл, який містить інформацію стосовно бібліотек, був успішно створений: #{csv_file_path}\n"
  end
end

# -------------------------------------------------------------------------------------------------------------- #
puts "Шановний користувач, вітаємо вас у застосунку \"Парсинг сайту Wikipedia (бібліотеки)\"!"
url = 'https://en.wikipedia.org/wiki/List_of_libraries'
# спочатку парсимо наш сайт
library_parser = LibraryParser.new(url)
library_names = library_parser.parse_library_names
# потім формуємо CSV-файл з назвами бібліотек
file_handler = FileHandler.new(library_names)
csv_file_path = "libraries.csv"
file_handler.create_csv_file(csv_file_path)