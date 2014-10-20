class CarsController < ApplicationController
  require 'mechanize'
  def index
  	@welcome_msg = "Hello! Welcome to Car Reward Tracker!"
  	# render text: "User wants to see his spg points!"
  	# print all record from model table car
  	@cr_summary = Car.all
  end

  def add_cr
# when icon "add hotel reward" is clicked, will bring to here
	# render text: "User wants to add Hotel reward no!!!"
	@cr = Car.new(cr_params)
	@cr.save
	# puts "!!!!!!!user wants to add Hotel reward info!!!!!!!!!"
	redirect_to '/cars'
  end

  def get_cr
  	cr_info = Car.find(params[:id])
  	# check schema for names
  	puts "!!!!!!!!!!!!"  #see this at terminal rails server window
  	cr_id = cr_info.id # need this to add updated points to database
  	# puts cr_id
  	
  	# check and see what is the hotel reward program name, pass to url
	reward_points = get_sign_in_url(cr_info.car, cr_info.cr_no, cr_info.cr_pw)
    # reward points will be returned to here, add to database, then show all data here again
  	# redirect_to '/hotels' #debugging only
  	# puts reward_points

  	# update the new points to table hotel
  	# Car.find(cr_id).update_attributes(cr_point: reward_points)

  	redirect_to '/cars' 
  end

  def get_sign_in_url(car, cr_no, cr_pw)
  	if car == "hertz"
  		# puts "user wants to add spg"
  		# redirect_to '/hotels' # for debugging only
  		hertz(cr_no, cr_pw)
  	elsif car == "enterprise"
  		# puts "user wants to add marriot"
  		enterprise(cr_no, cr_pw)
  	end	
  end
  
  def destroy
  	cr_record = Car.find(params[:id])
  	cr_record.destroy
  	redirect_to '/cars'
  end

  private
  def hertz(cr_no, cr_pw)
  	render text: "User wants to do sth with car rental rewards"
  	agent = Mechanize.new
  	agent.get('https://www.hertz.com/rentacar/emember/login.do')
  	forms = agent.page.forms
  # 	# puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  # 	# puts YAML::dump(forms)
  # 	# form.count
  	form = agent.page.form_with(:name=>'submitLogin')
  # 	# form
  # 	# puts YAML::dump(form)
  	form.loginId = cr_no
  	form.password = cr_pw
  	# failed as it has javascript - need other gem - WATIR or Selenium 
  # 	# puts YAML::dump(form)
  # 	form.submit
  # 	# agent.page.at('#trackStarPoints')
  # 	points = agent.page.at('#trackStarPoints')
		# if points.nil?
		# 	points = "Unmatch reward number and passoword!"
		# else
		# 	# points = points.text
		# 	# render text: points
		# 	# puts points
		# 	# points.text.gsub(/\n+|\t+|\r+/, "")
		# 	points = points.text.gsub(/\n+|\t+|\r+/, "")
		# 	# points.class
		# 	pt_length = points.length
		# 	# puts pt_length
		# 	# puts points
		# 	# points
		# 	points = points[11...pt_length]
		# 	# puts points
		# 	# redirect_to ('/hotels') # debugging only so puts will show
		# end
  # 	return points
  end

  def cr_params
  	params.require(:car).permit(:car, :cr_no, :cr_pw, :user_id, :description)
  end
end
