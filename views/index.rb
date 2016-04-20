class Index < Mustache
  self.template_path = File.dirname(__FILE__) + '/../templates'
  attr_reader :content
  def initialize(content)
    @content = content
  end
end
