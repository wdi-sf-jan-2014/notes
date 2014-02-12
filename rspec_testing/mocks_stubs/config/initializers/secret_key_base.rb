secret_key = ENV["SECRET_KEY_BASE"]
unless secret_key
	puts
	puts "The SECRET_KEY_BASE environment variable is empty.  Please add a SECRET_KEY_BASE to your .env file and run with foreman." 
	puts "You can generate a new secret with the command 'rake secret'."
	puts "You're welcome,"
	puts "Rafi"
	puts
end
TodoWithRspec::Application.config.secret_key_base = secret_key
