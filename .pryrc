Pry.config.history.should_save = true
Pry.config.history.should_load = true
Pry.config.editor = 'vim'
Pry.config.prompt_name = File.basename(Dir.pwd)
Pry.history.load
# Pry.config.prompt = proc { |obj, nest_level, _| "#{obj}:#{nest_level}>  " }
Pry.config.prompt_name = File.basename(Dir.pwd)
