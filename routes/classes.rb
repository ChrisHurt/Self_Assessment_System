
# All Class Records
get '/classes' do 
  # @classes = SchoolClass.all
  # erb :classes

  erb :teacher_classes
end

get '/teachers/classes' do 
  @classes = SchoolClass.all
  erb :classes
end

get '/teachers/:id/classes' do 
  if session[:user_id] && session[:user_type] != 'Student'
    @classes = SchoolClass.where(teacher_id: params[:id])
    erb :classes
  else
    session = {}
    redirect '/login'
  end

end

# Show a specific teachers' question
get '/teachers/:id/questions' do
  if session[:user_id] && session[:user_type] != 'Student'
    @questions = LatinQuestion.where(teacher_id: params[:id])
    # Connect to a relevant page
    erb :questions
  else
    session = {}
    redirect '/login'
  end
end




# New Class Record
get '/classes/new' do
  erb :add_class
end
    
# Individual Class Record
get '/classes/:id' do
  @class = SchoolClass.find(params[:id])
  erb :class
end
    
# Creating a New Class
post '/classes' do 
  
  school_class = SchoolClass.new
  school_class.year = params[:year]
  school_class.class_letter = params[:class_letter]
  school_class.teacher_id = params[:teacher_id]
  school_class.save
  
  redirect '/classes'
end
  
# Updating a Class Record
put '/classes/:id' do 
  school_class = SchoolClass.find(params[:id])
  school_class.year = params[:year]
  school_class.class_letter = params[:class_letter]
  school_class.teacher_id = params[:teacher_id]
  school_class.save
  redirect '/classes'
end
  
# Deleting a Class Record
delete '/classes/:id' do 
  school_class = SchoolClass.find(params[:id])
  school_class.delete
  redirect '/classes'
end
  