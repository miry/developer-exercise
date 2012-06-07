# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'coffeescript', output: 'javascript', error_to_js: true do
	watch(%r{^javascript/(.+\.coffee)$})
end

guard :test, :test_paths => ['ruby']  do
  watch(%r{^(ruby/.+_test\.rb)$}) { |m| m[1] }
  watch(%r{^(ruby/(.+)\.rb)$}) { |m| "ruby/#{m[1]}_test.rb" }
  watch(%r{^(ruby/where/.+\.rb)$}) { |m| "ruby/where/test.rb" }
  watch(%r{^(ruby/blackjack/blackjack/(.+).rb)$}) { |m| "ruby/blackjack/tests/#{m[1]}_test.rb" }
end
