# render
module MustacheTemplateHandler
  def self.call(template)
    if template.locals.include? "mustache"
      "Mustache.render(#{template.source.inspect}, mustache).html_safe"
    else
      "#{template.source.inspect}.html_safe"
    end
  end
end
ActionView::Template.register_template_handler(:mustache, MustacheTemplateHandler)

=begin
# processors 
class MustacheTemplateProcessor < Tilt::Template
  def self.default_mime_type
    'application/javascript'
  end

  def self.default_namespace
    'this.MST'
  end

  def prepare
    @namespace = self.class.default_namespace
  end

  attr_reader :namespace

  def evaluate(scope, locals, &block)
    <<-MustacheTemplate
(function() {
#{namespace} || (#{namespace} = {});
#{namespace}[#{scope.logical_path.inspect}] = #{data.inspect};
}).call(this);
    MustacheTemplate
  end
end

class SharedMustacheTemplateProcessor < Tilt::Template
    def prepare
    end

    def evaluate(scope, locals, &block)
      filepath = File.join(Rails.root, "app", "views", data.to_s.gsub(/\n/,""))
      template = ""
      template = File.new(filepath).read if File.file?(filepath)
      template
    end
end

Rails.application.assets.register_engine 'mst', MustacheTemplateProcessor
Rails.application.assets.register_engine 'smst', SharedMustacheTemplateProcessor
=end