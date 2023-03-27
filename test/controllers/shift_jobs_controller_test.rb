require 'test_helper'

class ShiftJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @store = FactoryBot.create(:store)
    @employee = FactoryBot.create(:employee)
    @pay_grade = FactoryBot.create(:pay_grade)
    @assignment = FactoryBot.create(:assignment, store: @store, employee: @employee, pay_grade: @pay_grade, start_date: 7.days.ago.to_date, end_date: nil)
    @job = FactoryBot.create(:job)
    @shift = FactoryBot.create(:shift, assignment: @assignment, date: 3.days.ago.to_date, status: 'finished')
  end

  test "should get new" do
    get new_shift_job_path(shift_id: @shift.id)
    assert_response :success
  end

  test "should create shift job" do
    assert_difference('ShiftJob.count') do
      post shift_jobs_path, params: { shift_job: { shift_id: @shift.id, job_id: @job.id } }
    end
    assert_redirected_to shift_path(ShiftJob.last.shift)

    post shift_jobs_path, params: { shift_job: { shift_id: @shift.id, job_id: nil } }
    assert_template :new
  end


  test "should destroy shift job" do
    @shift_job = FactoryBot.create(:shift_job, shift: @shift, job: @job)
    assert_difference('ShiftJob.count', -1) do
      delete shift_job_path(@shift_job)
    end

    assert_redirected_to shift_path(@shift_job.shift)
  end

  test "should not have generic routes (i.e., not using resources :shift_jobs)" do
    @shift_job = FactoryBot.create(:shift_job, job: @job, shift: @shift)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "shift_jobs", action: "index") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "shift_jobs", action: "show", id: "#{@shift_job.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "shift_jobs", action: "edit", id: "#{@shift_job.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "shift_jobs", action: "update", id: "#{@shift_job.id}") end
  end
end
