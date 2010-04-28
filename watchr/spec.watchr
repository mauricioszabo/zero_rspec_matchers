
watch('.*_spec\.rb') { |match| run_spec match[0] }
watch('lib/(.*)\.rb')     { |match| spec "#{match[1]}_spec.rb" }
watch('lib/(.*)_matcher\.rb') { |match| spec "#{match[1]}*_spec.rb" }

def spec(file)
  run_spec "spec/#{file}"
end

def run_spec(file)
  puts "Running: #{file}"
  system "spec #{file}"
end
