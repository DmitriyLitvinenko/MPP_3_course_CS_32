# супер-клас, який реалізує інтерфейс для службового об'єкту сервіса та замісника
class Subject
  def request
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# клас службового об'єкту сервіса, що виконує деяку бізнес логіку
class RealSubject < Subject
  def request
    puts 'RealSubject: Handling request.'
  end
end

# клас "замісника", що є "ідентичним" до службового об'єкта сервісу
class Proxy < Subject
  def initialize(real_subject)
    @real_subject = real_subject
  end

  def request
    return unless check_access
    @real_subject.request
    log_access
  end

  def check_access
    puts 'Proxy: Checking access prior to firing a real request.'
    true
  end

  def log_access
    print 'Proxy: Logging the time of request.'
  end
end

# метод, який реалізує дії від користувача
def client_code(subject)
  subject.request
end

# головний фрагмент коду для тестування програмного рішення
puts 'Client: Executing the client code with a real subject:'
real_subject = RealSubject.new
client_code(real_subject)

puts "\n"

puts 'Client: Executing the same client code with a proxy:'
proxy = Proxy.new(real_subject)
client_code(proxy)