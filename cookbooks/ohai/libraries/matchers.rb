# encoding: utf-8

if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method(:ohai_hint)

  def create_ohai_hint(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ohai_hint, :create, resource)
  end

  def delete_ohai_hint(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ohai_hint, :delete, resource)
  end

end
