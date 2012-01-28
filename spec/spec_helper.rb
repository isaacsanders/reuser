$: << '../'
$: << './'
require 'lib/reuser'

require 'rspec/expectations'

RSpec::Matchers.define :accept do |method|
  match do |*args, &block|
    begin
      subject.send(method, *args, &block)
      true
    rescue Exception => e
      false
    end
  end
end
