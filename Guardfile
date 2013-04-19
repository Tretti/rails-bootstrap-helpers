# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard "spork", :rspec_env => { "RAILS_ENV" => "test" } do
  watch("config/application.rb")
  watch("config/environment.rb")
  watch("config/environments/test.rb")
  watch(%r{^config/initializers/.+\.rb$})
  watch("Gemfile")
  watch("Gemfile.lock")
  watch("spec/spec_helper.rb") { :rspec }
end

guard "rspec", :cli => "--color --drb", :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch("spec/spec_helper.rb") { "spec" }
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
end