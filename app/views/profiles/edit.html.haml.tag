- content_for(:navigation_item) { 'Home' }

 
#main.inwards.colgroup.colgroup1
 %hgroup.leftFix
  %h1
   Edit Profile
 #form_wrap
  = form_for [@user, @profile], :html => { :class => "form_default", :id => "edit_profile_form", :multipart => true } do |f|
   = f.fields_for :user do |u|
    = u.label :name
    = u.text_field :name, value: @user.name
    = u.label :Picture
    = u.file_field :avatar
   = f.label :place
   -# = f.text_field :place, value: @profile.place
   
   - if @country.nil?
    = select_tag "country", options_from_collection_for_select(@countries, "country_pk", "name"), :id => "profile_country"
   - else
    = select_tag "country", options_from_collection_for_select(@countries, "country_pk", "name", :selected => @country.country_pk), :id => "profile_country"
   - unless @regions.nil?
    - if @region.nil?
     = select_tag "region",  options_from_collection_for_select(@regions, "region_pk", "name"), :id => "profile_region"
    - else
     = select_tag "region",  options_from_collection_for_select(@regions, "region_pk", "name", :selected => @region.region_pk), :id => "profile_region"
   
   - unless @cities.nil? 
    - if @city.nil?
     = select_tag "city",    options_from_collection_for_select(@cities, "city_pk", "name"), :id => "profile_city"
    - else
     = select_tag "city",    options_from_collection_for_select(@cities, "city_pk", "name", :selected => @city.city_pk), :id => "profile_city"
    
   = f.label :gender
   - male = nil
   - female = nil
   - if @profile.gender == 'M'
    - male = true
   - elsif @profile.gender == 'F'
    - female = true
   = f.radio_button :gender, 'M', :checked => male
   %span
    Male
   = f.radio_button :gender, 'F', :checked => female
   %span
    Female
   %p     
   = f.label :birthday, :class => 'date_label'
   = f.date_select(:birthday,:start_year => Profile::START_YEAR, :class => '', :default => @profile.birthday)
   = f.label :relationship_status
   - array = ['Single', 'Married', 'In a Relationship']
   = f.select :relationship_status, options_for_select(array, @profile.relationship_status)
   = f.label "What are you here for?"
   #edit_form_checkboxes
    - for goal in Goal.all
     = check_box_tag "profile[goal_ids][]", goal.id, @goals && @goals.include?(goal.id.to_s)
     = goal.name
     %br/
   = f.label :about_me
   = f.text_area :about_me, value: @profile.about_me
   = label_tag "interest"
   = text_field_tag "interest", nil,  :id => "add_interest", :class => "input_autocomplete", :placeholder => "Type an interest and press enter..."
   
   

   #interest_target 
    - @interests.each do |interest|
     %span.an_interest= interest.name
    
   = f.submit "Save", :class => "primaryButton block" 




