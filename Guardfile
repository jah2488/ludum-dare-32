gem 'dare', '0.2.0'
gem 'opal', '0.7.0beta3'
gem 'opal-jquery', '0.3.0beta1'
require 'opal'
require 'opal-jquery'
Opal::Processor.source_map_enabled = false
Opal::Processor.inline_operators_enabled = true
env = Sprockets::Environment.new
Opal.paths.each do |path|
  env.append_path path
end
env.append_path "."
env.append_path `bundle show dare`.chomp + '/lib'

guard :shell do
  watch(%r{(assets/(.+\.(css|js|html|png|jpg))).*}) do |m|
    `cp #{m[0]} public/assets/`
  end
  watch(%r{lib/.+\.rb}) do |m|
    puts '', 'rebuilding', ''
    #File.open("public/unweapon.js", "w+") do |out|
    #  out << env["lib/unweapon"].to_s
    #end
    File.binwrite "public/unweapon.js", env["lib/unweapon"].to_s
  end
end

guard 'livereload' do
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{(assets/\w+/(.+\.(css|js|html|png|jpg))).*})
end
