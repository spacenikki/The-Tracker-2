class HotelsController < ApplicationController
  require 'mechanize'
  def index
  	@welcome_msg = "Hello! Welcome to Hotel Reward Tracker!"
  	# render text: "User wants to see his spg points!"
  	# print all record from model table car
  	@hr_summary = Hotel.all
  end

  def add_hr
# when icon "add hotel reward" is clicked, will bring to here
	# render text: "User wants to add Hotel reward no!!!"
	@hr = Hotel.new(hr_params)
	@hr.save
	# puts "!!!!!!!user wants to add Hotel reward info!!!!!!!!!"
	redirect_to '/hotels'
  end

  def get_hr
  	hr_info = Hotel.find(params[:id])
  	# check schema for names
  	# puts "!!!!!!!!!!!!"
  	# puts hr_info.hotel
  	hr_id = hr_info.id # need this to add updated points to database

  	# check and see what is the hotel reward program name, pass to url
	reward_points = get_sign_in_url(hr_info.hotel, hr_info.hr_no, hr_info.hr_pw)
    # reward points will be returned to here, add to database, then show all data here again
  	# redirect_to '/hotels' #debugging only
  	# puts reward_points

  	# update the new points to table hotel
  	Hotel.find(hr_id).update_attributes(hr_point: reward_points)

  	redirect_to '/hotels' 
  end

  def get_sign_in_url(hotel, hr_no, hr_pw)
  	if hotel == "starwood"
  		# puts "user wants to add spg"
  		# redirect_to '/hotels' # for debugging only
  		spg(hr_no, hr_pw)
  	elsif hotel == "marriot"
  		# puts "user wants to add marriot"
  		marriot(hr_no, hr_pw)
  	elsif hotel == "hilton"
  		# puts "user wants to add hilton"
  		hilton(hr_no, hr_pw)
  	end	
  end
  
  def destroy
  	hr_record = Hotel.find(params[:id])
  	hr_record.destroy
  	redirect_to '/hotels'
  end

  private
  def spg(hr_no, hr_pw)
  	# render text: "User wants to do sth with spg"	
  	agent = Mechanize.new
  	agent.get('https://m.starwoodhotels.com/preferredguest/index.html?mobileSiteForce=true')
  	forms = agent.page.forms
  	# puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  	# puts YAML::dump(forms)
  	# form.count
  	form = agent.page.form_with(:name=>'loginForm')
  	# form
  	# puts YAML::dump(form)
  	form.login = hr_no
  	form.password = hr_pw
  	# puts YAML::dump(form)
  	form.submit
  	# agent.page.at('#trackStarPoints')
  	points = agent.page.at('#trackStarPoints')
		if points.nil?
			points = "Unmatch reward number and passoword!"
		else
			# points = points.text
			# render text: points
			# puts points
			# points.text.gsub(/\n+|\t+|\r+/, "")
			points = points.text.gsub(/\n+|\t+|\r+/, "")
			# points.class
			pt_length = points.length
			# puts pt_length
			# puts points
			# points
			points = points[11...pt_length]
			# puts points
			# redirect_to ('/hotels') # debugging only so puts will show
		end
  	return points
  end

  def hr_params
  	params.require(:hotel).permit(:hotel, :hr_no, :hr_pw, :user_id, :description)
  end
end