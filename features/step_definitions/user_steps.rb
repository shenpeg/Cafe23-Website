require './test/contexts'
include Contexts

Given /^an initial setup$/ do
  # context used from phase 3
  create_employees
  create_stores
  create_jobs
  create_pay_grades
  create_pay_grade_rates
  create_assignments
  create_shifts
  create_shift_jobs

  # update assignment dates to fixed values
  @assign_ben.update_attribute(:start_date, Date.new(2020,2,14))
  @assign_ben.update_attribute(:end_date, Date.new(2021,8,17))
  @promote_ben.update_attribute(:start_date, Date.new(2021,8,17))
  @promote_ben.update_attribute(:end_date, nil)
  @assign_ed.update_attribute(:start_date, Date.new(2021,3,14))
  @assign_ralph.update_attribute(:start_date, Date.new(2022,5,21))
  @assign_cindy.update_attribute(:start_date, Date.new(2020,11,17))
  @assign_kathryn.update_attribute(:start_date, Date.new(2021,4,30))

end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_shift_jobs
  destroy_shifts
  destroy_assignments
  destroy_pay_grade_rates
  destroy_pay_grades 
  destroy_jobs
  destroy_stores
  destroy_employees
end

Given /^a logged in admin$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "alex"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

Given /^a logged in manager$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "kathryn"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

Given /^a logged in employee$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "ralph"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end