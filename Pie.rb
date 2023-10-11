# У цьому коді реалізуємо симулятор розрязання пирога з родзинками
# (в якості програмного рішення, використаємо алгоритм backtrack)

$true_answer = [] # глобальна змінна, що зберігатиме інформацію про усі можливі розрізи

# метод обчислення початкових параметрів пирога
def get_pie_info(pie)
  n = 0 # кіл-ть родзинок
  width = pie[0].length() # розмір пирога завширшки
  height = pie.length() # розмір пирога завдовжки
  # підраховуємо кількість родзинок (прохід по рядкам масиву)
  pie.each do |row|
    n += row.count("o") # повертає кіл-ть родзинок у "рядку"
  end
  return n, width, height
end

# метод пошуку усіх можливих розмірів для одного розрізаного шматка
def find_pieces(pieces)
  return (1..pieces).select { |a| pieces % a == 0 } # робимо вибірку -> отримуємо "масив з розмірами"
end

# метод пошуку одникових частин (шматків) пирога
def array_has_same_elements(arr)
  first_element = arr[0]
  return arr.all? { |element| element == first_element }
end

# метод "отримання" шматка пирога
def take_slice(pie, r, c, w, h)
  answer = ""
  for i in (r..h - 1)
    for j in (c..w - 1)
      if pie[i] && pie[i][j] == "x"
        return nil
      elsif pie[i] && pie[i][j]
        answer += pie[i][j]
      end
    end
    answer += "\n"
  end
  return answer
end

# метод "видалення" шматка пирога
def delete_slice(pie, r, c, w, h)
  for i in (r..h - 1)
    for j in (c..w - 1)
      if pie[i] && pie[i][j]
        pie[i][j] = "x"
      end
    end
  end
  return pie
end

# перевірка на те, що шматок має лише одну родзинку
def checker(slice)
  return slice != nil && slice.count('o') == 1
end

# метод "розрізання пирога"
def cutting(pie, sizes, w, h, x, answer)
  # отримали розмір пирога
  pie_size = pie.length()

  # якщо пиріг "складається" з однакових шматків -> зміщуємо розташування шматків
  if array_has_same_elements(pie)
    $true_answer << answer
    return false
  end

  # якщо немає інформації про можливі розміри шматків - немає рішень
  if sizes.empty?
    return false
  end

  # основний алгоритм отримання шматків при розрізі пирога
  for q in ((0..sizes.length() - 1))
    hn = sizes[q]
    wn = sizes[-q - 1]
    next if wn > w || hn > h

    # зробили копії ч/з перетворення у послідовність байтів
    pie_copy = Marshal.load(Marshal.dump(pie))
    answer_copy = Marshal.load(Marshal.dump(answer))

    for i in (0..pie_size - 1)
      if !(pie_copy[i].include? "x")
        for j in (0..pie[i].length() - 1)
          str = take_slice(pie_copy, i, j, wn, hn + i)
          if checker(str)
            answer_copy << str
            pie_copy = delete_slice(pie_copy, i, j, wn, hn + i)
            flag = cutting(pie_copy, sizes, w, h, x + 1, answer_copy)
            if flag
              answer_copy.pop
            end
            break
          else
            break
          end
        end
      else
        if wn <= w - pie_copy[i].count("x")
          if i + hn <= pie_size
            for j in (pie_copy[i].count("x")..pie_copy[i].length() - 1)
              str = take_slice(pie_copy, i, j, wn * 2, hn + i)
              if checker(str)
                answer_copy << str
                pie_copy = delete_slice(pie_copy, i, j, wn * 2, hn + i)
                flag = cutting(pie_copy, sizes, w, h, x + 1, answer_copy)
                if flag
                  answer_copy.pop
                end
                break
              else
                break
              end
            end
          end
          next
        else
          next
        end
      end
      break
    end
  end
  return true
end

# задали "вигляд" пирога
pie = [
  ".o......",
  "......o.",
  "....o...",
  "..o.....",
]

# додатковий варіант "вигляду" пирога для розрізання
# pie = [
#   ".o.o....",
#   "........",
#   "....o...",
#   "........",
#   ".....o..",
#   "........",
# ]

puts "Шановний користувач, вітаємо вас у застосунку \"Симулятор розрізання пирога\"!"
puts "\nВаш пиріг:"
for piece in pie
  print "#{piece}\n"
end
print "\n"

# визначимо основні параметри заданого пирога
n, width, height = get_pie_info(pie)
# визначимо площу пирога
area = width * height
# визначили усі можливі розміри шматків, які можна отримати після розрізу пирога (вони мають бути однаковими)
sizes = find_pieces(area/n)

# шукаємо усі можливі комбінації розрізу пирогв
answer = []
cutting(pie, sizes, width, height, 0, answer)
$true_answer.reject! { |row| row.length < 4 } # видаляємо "недоречні" шматки
$true_answer = $true_answer.uniq # видаляємо однакові шматки

puts "Пиріг можна розрізати наступними способами (горизонтальна проекція шматків):"
for cut_piece in $true_answer
  print "#{cut_piece.inspect}\n"
end
print "\n"

# обираємо головне рішення за умовою - найбільша ширина першого елементу масива
one_answre = $true_answer.max_by { |subarray| subarray[0] }
print "Найкраще розрізати приріг саме таким чином: "
puts one_answre.inspect
puts "\nДякую за Вашу увагу! До зустрічі!"